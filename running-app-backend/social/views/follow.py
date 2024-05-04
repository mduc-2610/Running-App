from rest_framework import viewsets
from social.models import Follow
from social.serializers import FollowSerializer, \
                                CreateFollowSerializer

class FollowViewSet(viewsets.ModelViewSet):
    queryset = Follow.objects.all()
    serializer_class = FollowSerializer

    def get_serializer_class(self):
        if self.action == "create":
            return CreateFollowSerializer
        return super().get_serializer_class()
