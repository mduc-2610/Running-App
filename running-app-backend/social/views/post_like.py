from rest_framework import viewsets, response

from social.models import EventPostLike, ClubPostLike, ActivityRecordPostLike
from social.serializers import (
    EventPostLikeSerializer, 
    ClubPostLikeSerializer, 
    ActivityRecordPostLikeSerializer,
    CreateClubPostLikeSerializer,
    CreateEventPostLikeSerializer,
    CreateActivityRecordPostLikeSerializer
)
from utils.pagination import CommonPagination

class ClubPostLikeViewSet(viewsets.ModelViewSet):
    queryset = ClubPostLike.objects.all()
    serializer_class = ClubPostLikeSerializer
    pagination_class = CommonPagination

    def get_serializer_class(self):
        if self.action == 'create':
            return CreateClubPostLikeSerializer
        return ClubPostLikeSerializer
    
class EventPostLikeViewSet(viewsets.ModelViewSet):
    queryset = EventPostLike.objects.all()
    serializer_class = EventPostLikeSerializer
    pagination_class = CommonPagination
    
    def get_serializer_class(self):
        if self.action == 'create':
            return CreateEventPostLikeSerializer
        return EventPostLikeSerializer

class ActivityRecordPostLikeViewSet(viewsets.ModelViewSet):
    queryset = ActivityRecordPostLike.objects.all()
    serializer_class = ActivityRecordPostLikeSerializer
    pagination_class = CommonPagination

    def get_serializer_class(self):
        if self.action == 'create':
            return CreateActivityRecordPostLikeSerializer
        return ActivityRecordPostLikeSerializer