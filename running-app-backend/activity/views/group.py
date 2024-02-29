from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from activity.models import Group, \
                            UserGroup
from activity.serializers import GroupSerializer, \
                                DetailGroupSerializer, \
                                CreateUpdateGroupSerializer, \
                                UserGroupSerializer        


class GroupViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
):
    queryset = Group.objects.all()
    serializer_class = GroupSerializer

    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateGroupSerializer
        elif self.action == "retrieve":
            return DetailGroupSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs['context'] = self.get_serializer_context()
        return super().get_serializer(*args, **kwargs)

class UserGroupViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
):
    queryset = UserGroup.objects.all()
    serializer_class = UserGroupSerializer