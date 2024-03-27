from rest_framework import serializers

from activity.models import Group, Event

from account.serializers import UserSerializer
from activity.serializers.event import EventSerializer

class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = (
            "id",
            "name",
            "avatar",
            "total_distance",
            "total_duration"
        )
        extra_kwargs = {
            "id": {"read_only": True}
        }

class DetailGroupSerializer(serializers.ModelSerializer):
    total_distance = serializers.SerializerMethodField()
    number_of_participants = serializers.SerializerMethodField()
    total_duration = serializers.SerializerMethodField()
    rank = serializers.SerializerMethodField()
    event = EventSerializer()
    users = UserSerializer(many=True, read_only=True)

    def get_total_distance(self, instance):
        return instance.total_distance()
    
    def get_number_of_participants(self, instance):
        return instance.number_of_participants()
    
    def get_total_duration(self, instance):
        return instance.total_duration()

    def get_rank(self, instance):
        return instance.rank()
    
    class Meta:
        model = Group
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }
class CreateUpdateGroupSerializer(serializers.ModelSerializer):
    event_id = serializers.UUIDField()
    event = serializers.SerializerMethodField()

    def create(self, validated_data):
        event_id = validated_data.pop('event_id')
        return Group.objects.create(event_id=event_id, **validated_data)

    def get_event(self, instance):
        event = Event.objects.get(id=self.instance.event_id)
        return EventSerializer(event).data

    def to_representation(self, instance):
        instance = super().to_representation(instance)
        instance['event'] = self.get_event(instance)
        return instance

    class Meta:
        model = Group
        fields = (
            "id",
            "name", 
            "description",
            "avatar",
            "banner",
            "event_id",
            "event"
        )
        extra_kwargs = {
            "id": {"read_only": True}
        }