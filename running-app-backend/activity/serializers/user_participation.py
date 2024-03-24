from rest_framework import serializers

from activity.models import UserParticipationClub, \
                            UserParticipationEvent

from activity.serializers import ClubSerializer, \
                                EventSerializer, \
                                GroupSerializer
                                
# from account.serializers import ActivitySerializer                  

class UserParticipationClubSerializer(serializers.Serializer):
    # user = ActivitySerializer()
    club = ClubSerializer()
    class Meta:
        moddel = UserParticipationClub
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