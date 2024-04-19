from rest_framework import viewsets, response

from social.models import EventPostLike, ClubPostLike, ActivityRecordPostLike
from social.serializers import (
    EventPostLikeSerializer, 
    ClubPostLikeSerializer, 
    ActivityRecordPostLikeSerializer
)
from utils.pagination import CommonPagination

class EventPostLikeViewSet(viewsets.ModelViewSet):
    queryset = EventPostLike.objects.all()
    serializer_class = EventPostLikeSerializer
    pagination_class = CommonPagination
    
class ClubPostLikeViewSet(viewsets.ModelViewSet):
    queryset = ClubPostLike.objects.all()
    serializer_class = ClubPostLikeSerializer
    pagination_class = CommonPagination

class ActivityRecordPostLikeViewSet(viewsets.ModelViewSet):
    queryset = ActivityRecordPostLike.objects.all()
    serializer_class = ActivityRecordPostLikeSerializer
    pagination_class = CommonPagination