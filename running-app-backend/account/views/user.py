from django.shortcuts import get_object_or_404
from rest_framework import viewsets, \
                            mixins, \
                            response, \
                            status, \
                            views
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.authtoken.models import Token
from rest_framework.decorators import action

from django.contrib.auth import authenticate
from django.db.models import Q
from django.contrib.auth import authenticate, update_session_auth_hash

from account.models import User

from account.serializers import UserSerializer, \
                                DetailUserSerializer, \
                                CreateUserSerializer, \
                                UpdateUserSerializer, \
                                LoginSerializer, \
                                ChangePasswordSerializer, \
                                LeaderboardSerializer


class UserViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,  
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    queryset = User.objects.filter(is_superuser=0)
    serializer_class = UserSerializer

    def get_permissions(self):
        if self.action == 'create':
            permission_classes = [AllowAny]
        else:
            permission_classes = [IsAuthenticated] 
        return [permission() for permission in permission_classes]
    
    def get_queryset(self):
        queryset = super().get_queryset()
        username = self.request.query_params.get('username', None)
        email = self.request.query_params.get('email', None)
        if username or email:
            queryset = queryset.filter(
                Q(username__icontains=username) if username else Q()
                | Q(email__icontains=email) if email else Q()
            )
    
        return queryset

    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailUserSerializer
        elif self.action == "update":
            return UpdateUserSerializer
        elif self.action == "create":
            return CreateUserSerializer
        elif self.action == "change_password":
            return ChangePasswordSerializer
        return super().get_serializer_class()
    

    @action(detail=False, methods=['post'], url_path='change-password', name='change_password')
    def change_password(self, request):
        serializer = ChangePasswordSerializer(data=request.data)
        if serializer.is_valid():
            user_id = serializer.data.get("user_id")
            old_password = serializer.data.get("old_password")
            new_password = serializer.data.get("new_password")
            confirm_new_password = serializer.data.get("confirm_new_password")
            user = get_object_or_404(User, id=user_id)
            
            if not user.check_password(old_password):
                return response.Response({"error": "Invalid old password"}, status=status.HTTP_400_BAD_REQUEST)
            
            if new_password != confirm_new_password:
                return response.Response({"error": "New passwords do not match"}, status=status.HTTP_400_BAD_REQUEST)
            
            user.set_password(new_password)
            user.save()
            update_session_auth_hash(request, user) 
            return response.Response({"message": "Password changed successfully"}, status=status.HTTP_200_OK)
        return response.Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
class LoginViewSet(viewsets.GenericViewSet):
    queryset = User.objects.all()
    permission_classes = [AllowAny]

    def create(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        
        user = authenticate(username=username, password=password)
        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            return response.Response({'token': token.key}, status=status.HTTP_200_OK)
        else:
            return response.Response({'error': 'Invalid username or password'}, status=status.HTTP_401_UNAUTHORIZED)
        
class LogoutView(views.APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        request.user.auth_token.delete()
        return response.Response({'message': "You are logged out"}, status=status.HTTP_200_OK)