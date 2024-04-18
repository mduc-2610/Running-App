from rest_framework import viewsets

from social.models import EventPostLike, ClubPostLike, ActivityRecordPostLike
from social.serializers import (
    EventPostLikeSerializer, 
    ClubPostLikeSerializer, 
    ActivityRecordPostLikeSerializer
)

class EventPostLikeViewSet(viewsets.ModelViewSet):
    queryset = EventPostLike.objects.all()
    serializer_class = EventPostLikeSerializer

class ClubPostLikeViewSet(viewsets.ModelViewSet):
    queryset = ClubPostLike.objects.all()
    serializer_class = ClubPostLikeSerializer

class ActivityRecordPostLikeViewSet(viewsets.ModelViewSet):
    queryset = ActivityRecordPostLike.objects.all()
    serializer_class = ActivityRecordPostLikeSerializer
