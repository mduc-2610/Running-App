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
    # user = ActivitySerializer()
    event = EventSerializer()

    class Meta:
        model = UserParticipationEvent
        fields = "__all__"