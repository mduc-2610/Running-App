from rest_framework import serializers

from activity.models import Event
from account.serializers import DetailUserSerializer, LeaderboardSerializer
from activity.serializers.group import GroupSerializer

from utils.function import get_start_of_day, \
                            get_end_of_day, \
                            get_start_date_of_week, \
                            get_end_date_of_week, \
                            get_start_date_of_month, \
                            get_end_date_of_month, \
                            get_start_date_of_year, \
                            get_end_date_of_year

class EventSerializer(serializers.ModelSerializer):
    competition = serializers.CharField(source='get_competition_display')

    class Meta:
        model = Event
        fields = (
            "id",
            "name",
            "number_of_participants",
            "competition",
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
    groups = GroupSerializer(many=True)
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
    
    # def get_participants(self, instance):
    #     request = self.context.get('request', None)
    #     users = [instance.user.performance for instance in instance.events.all()]
    #     return LeaderboardSerializer(users, many=True, context={'request': request}).data

    def get_participants(self, instance):
        context = self.context
        sport_type = instance.sport_type
        event_id = instance.id
        type = "event"

        start_date = context.get('start_date')
        end_date = context.get('end_date')
        gender = context.get('gender')
        sort_by = context.get('sort_by')
        limit_user = context.get('limit_user')

        print({'start_date': start_date, 'end_date': end_date, 'sort_by': sort_by, 'limit_user': limit_user})

        users = [instance.user.performance for instance in instance.events.all()]
        if gender:
            users = [user for user in users if user.user.profile.gender == gender]

        def sort_cmp(x, sort_by):
            stats = x.range_stats(start_date, end_date, sport_type=sport_type)
            if sort_by == 'Time':
                return (-stats[3], -stats[0])
            return (-stats[0], -stats[3])
        users = sorted(users, key=lambda x: sort_cmp(x, sort_by))

        if limit_user:
            users = users[:int(limit_user)]

        return LeaderboardSerializer(users, many=True, context={
            'id': event_id,
            'type': type,
            'start_date': start_date,
            'end_date': end_date,
            'sport_type': sport_type,
        }).data
    
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
    def create(self, validated_data):
        validated_data["competition"] = validated_data.get("competition", "").upper()
        validated_data["sport_type"] = validated_data.get("sport_type", "").upper()
        validated_data["privacy"] = validated_data.get("privacy", "").upper()
        validated_data["ranking_type"] = validated_data.get("ranking_type", "").upper()

        return Event.objects.create(**validated_data)
    class Meta:
        model = Event
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }


