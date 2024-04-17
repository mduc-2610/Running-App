from rest_framework import viewsets
from social.models import ClubPostComment, \
                            EventPostComment, \
                            ActivityRecordPostComment
from social.serializers import ClubPostCommentSerializer, \
                                EventPostCommentSerializer, \
                                ActivityRecordPostCommentSerializer
from social.pagination import SocialPagination


class ClubPostCommentViewSet(viewsets.ModelViewSet):
    queryset = ClubPostComment.objects.all()
    serializer_class = ClubPostCommentSerializer
    pagination_class = SocialPagination

class EventPostCommentViewSet(viewsets.ModelViewSet):
    queryset = EventPostComment.objects.all()
    serializer_class = EventPostCommentSerializer
    pagination_class = SocialPagination
    
class ActivityRecordPostCommentViewSet(viewsets.ModelViewSet):
    queryset = ActivityRecordPostComment.objects.all()
    serializer_class = ActivityRecordPostCommentSerializer
    pagination_class = SocialPagination
