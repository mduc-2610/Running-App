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
    privacy = serializers.CharField(source='get_privacy_display')
    competition = serializers.CharField(source='get_competition_display')
    sport_type = serializers.CharField(source='get_sport_type_display')
    started_at = serializers.SerializerMethodField()
    ended_at = serializers.SerializerMethodField()
    regulations = serializers.SerializerMethodField()

    def get_days_remain(self, instance):
        return instance.days_remain()
    
    def get_number_of_participants(self, instance):
        return instance.number_of_participants()
    
    def get_participants(self, instance):
        request = self.context.get('request', None)
        users = [instance.user for instance in instance.events.all()]
        return DetailUserSerializer(users, many=True, context={'request': request}).data

    def get_started_at(self, instance):
        return instance.get_readable_time('started_at')
    
    def get_ended_at(self, instance):
        return instance.get_readable_time('ended_at')
    
    def get_regulations(self, instance):
        regulations = instance.regulations
        if regulations is None:
            regulations = {
                "min_distance": "Unlimited",
                "max_distance": "Unlimited",
                "min_avg_pace": "Unlimited",
                "max_avg_pace": "Unlimited",
            }
        else:
            regulations["min_distance"] = f"{regulations.get('min_distance', 'Unlimited')}{'km' if regulations.get('min_distance', 'Unlimited') != 'Unlimited' else ''}"
            regulations["max_distance"] = f"{regulations.get('max_distance', 'Unlimited')}{'km' if regulations.get('max_distance', 'Unlimited') != 'Unlimited' else ''}"
            regulations["min_avg_pace"] = f"{regulations.get('min_avg_pace', 'Unlimited')}{'/km' if regulations.get('min_avg_pace', 'Unlimited') != 'Unlimited' else ''}"
            regulations["max_avg_pace"] = f"{regulations.get('max_avg_pace', 'Unlimited')}{'/km' if regulations.get('max_avg_pace', 'Unlimited') != 'Unlimited' else ''}"

        return regulations
    
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

