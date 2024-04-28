from rest_framework import viewsets
from social.models import ClubPostComment, \
                            EventPostComment, \
                            ActivityRecordPostComment
from social.serializers import ClubPostCommentSerializer, \
                                EventPostCommentSerializer, \
                                ActivityRecordPostCommentSerializer, \
                                CreateClubPostCommentSerializer, \
                                CreateEventPostCommentSerializer, \
                                CreateActivityRecordPostCommentSerializer
from utils.pagination import CommonPagination


class ClubPostCommentViewSet(viewsets.ModelViewSet):
    queryset = ClubPostComment.objects.all()
    serializer_class = ClubPostCommentSerializer
    pagination_class = CommonPagination

    def get_serializer_class(self):
        if self.action == 'create':
            return CreateClubPostCommentSerializer
        return ClubPostCommentSerializer

class EventPostCommentViewSet(viewsets.ModelViewSet):
    queryset = EventPostComment.objects.all()
    serializer_class = EventPostCommentSerializer
    pagination_class = CommonPagination

    def get_serializer_class(self):
        if self.action == 'create':
            return CreateEventPostCommentSerializer
        return EventPostCommentSerializer
    
class ActivityRecordPostCommentViewSet(viewsets.ModelViewSet):
    queryset = ActivityRecordPostComment.objects.all()
    serializer_class = ActivityRecordPostCommentSerializer
    pagination_class = CommonPagination
    
    def get_serializer_class(self):
        if self.action == 'create':
            return CreateActivityRecordPostCommentSerializer
        return ActivityRecordPostCommentSerializer