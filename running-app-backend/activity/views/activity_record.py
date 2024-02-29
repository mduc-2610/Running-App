from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from activity.models import ActivityRecord
from activity.serializers import ActivityRecordSerializer, \
                            DetailActivityRecordSerializer, \
                            CreateActivityRecordSerializer, \
                            UpdateActivityRecordSerializer

# class ActivityRecordViewSet(
# ):

class ActivityRecordViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
    # viewsets.ModelViewSet
):
    queryset = ActivityRecord.objects.all()
    serializer_class = ActivityRecordSerializer

    def get_serializer_class(self):
        if self.action == "create":
            return CreateActivityRecordSerializer
        elif self.action == "retrieve":
            return DetailActivityRecordSerializer
        elif self.action == "update":
            return UpdateActivityRecordSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)