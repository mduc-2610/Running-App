from rest_framework import viewsets, \
                            mixins, \
                            response, \
                            status

from account.models import Profile
from account.serializers import ProfileSerializer, \
                                DetailProfileSerializer, \
                                CreateProfileSerializer, \
                                UpdateProfileSerializer

class ProfileViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer

    def get_serializer_class(self):
        if self.action == "create":
            return CreateProfileSerializer
        elif self.action == "update":
            return UpdateProfileSerializer
        elif self.action == "retrieve":
            return DetailProfileSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
    