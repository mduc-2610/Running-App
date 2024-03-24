from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from django.db.models import Count, Sum
from django.utils import timezone

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
    
    def get_queryset(self):
        queryset =  super().get_queryset()
        state = self.request.query_params.get("state", None)
        now = timezone.now()

        if state:
            if state == "upcoming":
                queryset = queryset.filter(started_at__gt=now)
            elif state == "ongoing":
                queryset = queryset.filter(started_at__lte=now, ended_at__gte=now)
            elif state == "ended":
                queryset = queryset.filter(ended_at__lt=now)
        
        sort_by = self.request.query_params.get("sort", None)
        sort_params = [x.strip() for x in sort_by.split(",")] if sort_by else []
        if sort_params and ("participants" in sort_params or "-participants" in sort_params):
            queryset = queryset.annotate(participants=Count("events"))
            participants_param = [x for x in sort_params if x.endswith("participants")]
            sort_params.remove(participants_param[0])
            queryset = queryset.order_by(participants_param[0], *sort_params)
        
        limit = self.request.query_params.get("limit", None)
        queryset = queryset[:int(limit)] if limit else queryset
        
        return queryset

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
