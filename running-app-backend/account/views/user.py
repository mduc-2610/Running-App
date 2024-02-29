from rest_framework import viewsets, \
                            mixins, \
                            response, \
                            status

from account.models import User
from account.serializers import UserSerializer, \
                                DetailUserSerializer, \
                                CreateUserSerializer, \
                                UpdateUserSerializer

class UserViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,  
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    queryset = User.objects.all()
    serializer_class = UserSerializer

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

    