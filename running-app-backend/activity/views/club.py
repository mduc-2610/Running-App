from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response
from rest_framework.permissions import IsAuthenticated


from activity.models import Club
from activity.serializers import ClubSerializer, \
                                DetailClubSerializer, \
                                CreateUpdateClubSerializer

class ClubViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
):
    queryset = Club.objects.all()
    serializer_class = ClubSerializer
    # permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateClubSerializer
        elif self.action == "retrieve":
            return DetailClubSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)