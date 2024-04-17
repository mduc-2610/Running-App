from rest_framework import serializers
from social.models import EventPostImage, ClubPostImage

class EventPostImageSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = EventPostImage
        fields = ('id', 'image', 'post')

class ClubPostImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = ClubPostImage
        fields = ('id', 'image', 'post')
