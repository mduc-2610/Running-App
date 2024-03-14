from rest_framework import viewsets, \
                            mixins, \
                            response, \
                            status, \
                            views
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.authtoken.models import Token

from django.contrib.auth import authenticate

from account.models import User

from account.serializers import UserSerializer, \
                                DetailUserSerializer, \
                                CreateUserSerializer, \
                                UpdateUserSerializer, \
                                LoginSerializer


class UserViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,  
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    # permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailUserSerializer
        elif self.action == "update":
            return UpdateUserSerializer
        elif self.action == "create":
            return CreateUserSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
        
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