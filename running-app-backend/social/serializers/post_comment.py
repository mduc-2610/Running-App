from rest_framework import serializers
from social.models import ClubPostComment,\
                            EventPostComment, \
                            ActivityRecordPostComment

        
class ClubPostCommentSerializer(serializers.ModelSerializer):   
    class Meta:
        model = ClubPostComment
        fields = '__all__'
        extra_kwargs = {
            "id": {"read_only": True},
        }

class EventPostCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPostComment
        fields = '__all__'
        extra_kwargs = {
            "id": {"read_only": True},
        }

class ActivityRecordPostCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = ActivityRecordPostComment
        fields = '__all__'
        extra_kwargs = {
            "id": {"read_only": True},
        }
