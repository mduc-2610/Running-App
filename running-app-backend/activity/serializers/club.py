from rest_framework import serializers

from activity.models import Club
from account.serializers import LeaderboardSerializer 
from account.serializers import DetailUserSerializer

class ClubSerializer(serializers.ModelSerializer):
    sport_type = serializers.CharField(source='get_sport_type_display')
    class Meta:
        model = Club
        fields = (
            "id", 
            "name", 
            "avatar", 
            "sport_type", 
            "week_activities", 
            "number_of_participants"
        )
        extra_kwargs = {
            "id": {"read_only": True}
        }

class DetailClubSerializer(serializers.ModelSerializer):
    week_activites = serializers.SerializerMethodField()
    number_of_participants = serializers.SerializerMethodField()
    participants = serializers.SerializerMethodField()
    sport_type = serializers.CharField(source='get_sport_type_display')
    organization = serializers.CharField(source='get_organization_display')
    privacy = serializers.CharField(source='get_privacy_display') 
    
    def get_week_activites(self, instance):
        return instance.week_activities()
    
    def get_number_of_participants(self, instance):
        return instance.number_of_participants()
    
    def get_participants(self, instance):
        request = self.context.get('request', None)
        users = [instance.user.performance for instance in instance.clubs.all()]
        return LeaderboardSerializer(users, many=True, context={'request': request}).data

    class Meta:
        model = Club
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }
    
class CreateUpdateClubSerializer(serializers.ModelSerializer):
    user_id = serializers.SerializerMethodField()
    
    def get_user_id(self, instance):
        return instance.id
    
    class Meta:
        model = Club
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }
# class UpdateClubSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Club
#         fields = "__all__"
#         extra_kwargs = {
#             "id": {"read_only": True},
#             "user": {"read_only": True},
#         }