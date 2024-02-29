from rest_framework import serializers

from activity.models import UserParticipationClub, \
                            UserParticipationEvent

from activity.serializers import ClubSerializer, \
                                EventSerializer, \
                                GroupSerializer
                                
from account.serializers import UserSerializer                  

class UserParticipationClubSerializer(serializers.Serializer):
    user = UserSerializer()
    club = ClubSerializer()
    class Meta:
        moddel = UserParticipationClub
        fields = "__all__"

class UserParticipationEventSerializer(serializers.Serializer):
    user = UserSerializer()
    event = EventSerializer()

    class Meta:
        model = UserParticipationEvent
        fields = "__all__"