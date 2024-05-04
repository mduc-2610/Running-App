from rest_framework import serializers
from social.models import Follow

class FollowSerializer(serializers.ModelSerializer):
    class Meta:
        model = Follow
        fields = "__all__"
        read_only_fields = ('created_at', "id")

class CreateFollowSerializer(serializers.ModelSerializer):
    follower_id = serializers.UUIDField(write_only=True)
    followee_id = serializers.UUIDField(write_only=True)

    def create(self, validated_data):
        follower_id = validated_data.pop("follower_id")
        followee_id = validated_data.pop("followee_id")
        return Follow.objects.create(
            follower_id=follower_id, followee_id=followee_id, **validated_data)
    
    class Meta:
        model = Follow
        fields = ("id", "follower_id", "followee_id")
        extra_kwargs = {
            "id": {"read_only": True}
        }