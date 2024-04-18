from rest_framework import serializers
from social.models import EventPostImage, ClubPostImage

class EventPostImageSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = EventPostImage
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

class ClubPostImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = ClubPostImage
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }
