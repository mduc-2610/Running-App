from rest_framework import serializers

from activity.models import Event
from account.serializers import DetailUserSerializer

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = (
            "id",
            "name",
            "number_of_participants",
            "banner",
            "days_remain"
        )
        extra_kwargs = {
            "id": {"read_only": True}
        }
    
class DetailEventSerializer(serializers.ModelSerializer):
    days_remain = serializers.SerializerMethodField()
    number_of_participants = serializers.SerializerMethodField()
    participants = serializers.SerializerMethodField()

    def get_days_remain(self, instance):
        return instance.days_remain()
    
    def get_number_of_participants(self, instance):
        return instance.number_of_participants()
    
    def get_participants(self, instance):
        request = self.context.get('request', None)
        users = [instance.user for instance in instance.events.all()]
        return DetailUserSerializer(users, many=True, context={'request': request}).data

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

