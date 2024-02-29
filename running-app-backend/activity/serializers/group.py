from rest_framework import serializers

from activity.models import Group, \
                            UserGroup
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
    class Meta:
        model = Group
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }

class UserGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserGroup
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }