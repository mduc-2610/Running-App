from rest_framework import serializers
from social.models import EventPostLike, \
                        ClubPostLike, \
                        ActivityRecordPostLike

class EventPostLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPostLike
        fields = '__all__'

class ClubPostLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClubPostLike
        fields = '__all__'

class ActivityRecordPostLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ActivityRecordPostLike
        fields = '__all__'
