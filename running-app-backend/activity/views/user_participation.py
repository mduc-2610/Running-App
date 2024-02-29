from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from activity.models import UserParticipationClub, \
                            UserParticipationEvent      
from activity.serializers import UserParticipationClubSerializer, \
                                UserParticipationEventSerializer

class UserParticipationClubViewSet(
    viewsets.ModelViewSet
):
    queryset = UserParticipationClub.objects.all()
    serializer_class = UserParticipationClubSerializer

class UserParticipationEventViewSet(
    viewsets.ModelViewSet
):
    queryset = UserParticipationEvent.objects.all()
    serializer_class = UserParticipationEventSerializer