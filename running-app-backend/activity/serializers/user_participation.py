from rest_framework import serializers

from activity.models import UserParticipationClub, \
                            UserParticipationEvent

from account.serializers import UserSerializer
from activity.serializers import ClubSerializer, \
                                EventSerializer, \
                                GroupSerializer
                                
# from account.serializers import ActivitySerializer                  

class UserParticipationClubSerializer(serializers.Serializer):
    club = ClubSerializer()
    user = UserSerializer()

    class Meta:
        moddel = UserParticipationClub
        fields = "__all__"

class CreateUserParticipationClubSerializer(serializers.Serializer):
    user_id = serializers.UUIDField()
    club_id = serializers.UUIDField()

    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        club_id = validated_data.pop('club_id')
        return UserParticipationClub.objects.create(user_id=user_id, club_id=club_id, **validated_data)

    class Meta:
        model = UserParticipationClub
        fields = "__all__"


class UserParticipationEventSerializer(serializers.Serializer):
    # user = ActivitySerializer(many=False)
    event = EventSerializer()
    is_admin = serializers.BooleanField()
    is_superadmin = serializers.BooleanField()
    participated_at = serializers.DateTimeField()

    # def get_is_admin(self, instance):
    #     return instance.is_admin
    


    class Meta:
        model = UserParticipationEvent
        fields = (
            "is_admin",
            "is_superadmin",
            "participated_at",
            "user",
            "event"
        )