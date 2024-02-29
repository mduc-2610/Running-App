from rest_framework import serializers

from activity.models import ActivityRecord
from account.serializers import UserSerializer

class ActivityRecordSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = ActivityRecord
        fields = (
            "id", 
            "sport_type", 
            "distance", 
            "step", 
            "user",
            "kcal", 
            "completed_at"
        )
        extra_kwargs = {
            "id": {"read_only": True},
            "user": {"read_only": True}
        }

class DetailActivityRecordSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    class Meta:
        model = ActivityRecord
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }

class CreateActivityRecordSerializer(serializers.ModelSerializer):
    class Meta:
        model = ActivityRecord
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

class UpdateActivityRecordSerializer(serializers.ModelSerializer):
    class Meta:
        model = ActivityRecord
        fields = ("description",)

