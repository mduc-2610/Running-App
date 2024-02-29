from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from activity.models import Event
from activity.serializers import EventSerializer, \
                                DetailEventSerializer, \
                                CreateUpdateEventSerializer

class EventViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
):
    queryset = Event.objects.all()
    serializer_class = EventSerializer

    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateEventSerializer
        elif self.action == "retrieve":
            return DetailEventSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
