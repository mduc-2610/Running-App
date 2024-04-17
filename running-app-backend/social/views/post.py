from rest_framework import viewsets
from social.models import EventPost, ClubPost
from social.serializers import EventPostSerializer, \
                                ClubPostSerializer
from social.pagination import SocialPagination

class EventPostViewSet(viewsets.ModelViewSet):
    queryset = EventPost.objects.all()
    serializer_class = EventPostSerializer
    pagination_class = SocialPagination

class ClubPostViewSet(viewsets.ModelViewSet):
    queryset = ClubPost.objects.all()
    serializer_class = ClubPostSerializer
    pagination_class = SocialPagination
