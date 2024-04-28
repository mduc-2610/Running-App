from rest_framework import serializers
from social.models import EventPostLike, \
                        ClubPostLike, \
                        ActivityRecordPostLike

class ClubPostLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClubPostLike
        fields = '__all__'

class CreateClubPostLikeSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField()
    post_id = serializers.UUIDField()

    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        post_id = validated_data.pop('post_id')
        like = ClubPostLike.objects.create(
            user_id=user_id, post_id=post_id, **validated_data)
        return like
    
    class Meta:
        model = ClubPostLike
        fields = ("id", "user_id", "post_id")
        extra_kwargs = {
            "id": {"read_only": True},
        }

class EventPostLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPostLike
        fields = '__all__'

class CreateEventPostLikeSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField()
    post_id = serializers.UUIDField()

    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        post_id = validated_data.pop('post_id')
        like = EventPostLike.objects.create(
            user_id=user_id, post_id=post_id, **validated_data)
        return like
    
    class Meta:
        model = EventPostLike
        fields = ("id", "user_id", "post_id")
        extra_kwargs = {
            "id": {"read_only": True},
        }

class ActivityRecordPostLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ActivityRecordPostLike
        fields = '__all__'

class CreateActivityRecordPostLikeSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField()
    post_id = serializers.UUIDField()

    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        post_id = validated_data.pop('post_id')
        like = ActivityRecordPostLike.objects.create(
            user_id=user_id, post_id=post_id, **validated_data)
        return like
    
    class Meta:
        model = ActivityRecordPostLike
        fields = ("id", "user_id", "post_id")
        extra_kwargs = {
            "id": {"read_only": True},
        }