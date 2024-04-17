from rest_framework import viewsets
from social.models import EventPostImage,\
                            ClubPostImage
from social.serializers import EventPostImageSerializer, \
                                ClubPostImageSerializer

class EventPostImageViewSet(viewsets.ModelViewSet):
    queryset = EventPostImage.objects.all()
    serializer_class = EventPostImageSerializer

class ClubPostImageViewSet(viewsets.ModelViewSet):
    queryset = ClubPostImage.objects.all()
    serializer_class = ClubPostImageSerializer
