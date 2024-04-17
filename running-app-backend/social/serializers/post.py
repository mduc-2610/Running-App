from rest_framework import serializers
from social.models import EventPost,\
                        ClubPost

class EventPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPost
        fields = ('id', 'title', 'content', 'user', 'created_at', 'event')
        read_only_fields = ('created_at', "id")

class ClubPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClubPost
        fields = ('id', 'title', 'content', 'user', 'created_at', 'club')
        read_only_fields = ('created_at', "id")
