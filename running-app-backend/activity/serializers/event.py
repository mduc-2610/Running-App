from rest_framework import serializers

from activity.models import Event
from account.serializers import UserSerializer

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = (
            "id",
            "name",
            "number_of_participants",
            "banner",
            "days_remaining"
        )
        extra_kwargs = {
            "id": {"read_only": True}
        }
    
class DetailEventSerializer(serializers.ModelSerializer):
    days_remaining = serializers.SerializerMethodField()
    number_of_participants = serializers.SerializerMethodField
    users = UserSerializer(many=True)

    def get_days_remaining(self, instance):
        return instance.days_remaining()
    
    def get_number_of_participants(self, instance):
        return self.users.count()

    class Meta:
        model = Event
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }


class CreateUpdateEventSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }

