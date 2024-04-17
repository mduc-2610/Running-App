from rest_framework import serializers
from social.models import Follow

class FollowSerializer(serializers.ModelSerializer):
    class Meta:
        model = Follow
        fields = ('id', 'follower', 'followee', 'created_at')
        read_only_fields = ('created_at', "id")
