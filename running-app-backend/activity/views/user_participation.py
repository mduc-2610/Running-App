from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response
from rest_framework.decorators import action
from django.shortcuts import get_object_or_404

from account.models import User
from activity.models import Event, \
                            Club, \
                            UserParticipationClub, \
                            UserParticipationEvent
                            

from account.serializers import UserSerializer, \
                                ActivitySerializer
from activity.serializers import EventSerializer, \
                                ClubSerializer, \
                                UserParticipationClubSerializer, \
                                CreateUserParticipationClubSerializer, \
                                UserParticipationEventSerializer, \
                                CreateUserParticipationEventSerializer
                                

class UserParticipationClubViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet,
    # viewsets.ModelViewSet
):
    queryset = UserParticipationClub.objects.all()
    serializer_class = UserParticipationClubSerializer
    
    def get_serializer_class(self):
        if self.action == "create":
            return CreateUserParticipationClubSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs['context'] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
    
    # def get_queryset(self):
    #     user_id = self.kwargs.get('user_id', None)
    #     club_id = self.kwargs.get('club_id', None)

    #     if self.action == "participants":
    #         return get_object_or_404(Club, pk=club_id).clubs.all()
    #     if self.action == "clubs":
    #         return get_object_or_404(User, pk=user_id).user_activity.clubs.all()
    #     return super().get_queryset()

    # def get_serializer_class(self):
    #     if self.action == "participants":
    #         return ActivitySerializer
    #     elif self.action == "clubs":
    #         return ClubSerializer
    #     return super().get_serializer_class()

    # def get_serializer(self, *args, **kwargs):
    #     serializer_class = self.get_serializer_class()
    #     kwargs['context'] = self.get_serializer_context()
    #     return serializer_class(*args, **kwargs)
    
    # @action(detail=True, methods=["GET"], name="participants")
    # def participants(self, request, *args, **kwargs):
    #     instance = self.get_queryset()
    #     serializer = self.get_serializer(instance, many=True)
    #     return response.Response(serializer.data, status=status.HTTP_200_OK)

    # @action(detail=True, methods=["GET"], name="clubs")
    # def clubs(self, request, *args, **kwargs):
    #     instance = self.get_queryset()
    #     serializer = self.get_serializer(instance, many=True)
    #     return response.Response(serializer.data, status=status.HTTP_200_OK)
    
class UserParticipationEventViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet,
):
    queryset = UserParticipationEvent.objects.all()
    serializer_class = UserParticipationEventSerializer
    
    def get_serializer_class(self):
        return super().get_serializer_class()
    
    def get_serializer_class(self):
        if self.action == "create":
            return CreateUserParticipationEventSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs['context'] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
        
    # def get_queryset(self):
    #     user_id = self.kwargs.get('user_id', None)
    #     event_id = self.kwargs.get('event_id', None)

    #     if self.action == "participants":
    #         return get_object_or_404(Event, pk=event_id).events.all()
    #     if self.action == "events":
    #         return get_object_or_404(User, pk=user_id).user_activity.events.all()
    #     return super().get_queryset()

    # def get_serializer_class(self):
    #     if self.action == "participants":
    #         return ActivitySerializer
    #     elif self.action == "events":
    #         return EventSerializer
    #     return super().get_serializer_class()

    # def get_serializer(self, *args, **kwargs):
    #     serializer_class = self.get_serializer_class()
    #     kwargs['context'] = self.get_serializer_context()
    #     return serializer_class(*args, **kwargs)
    
    # @action(detail=True, methods=["GET"], name="participants")
    # def participants(self, request, *args, **kwargs):
    #     instance = self.get_queryset()
    #     serializer = self.get_serializer(instance, many=True)
    #     return response.Response(serializer.data, status=status.HTTP_200_OK)

    # @action(detail=True, methods=["GET"], name="events")
    # def events(self, request, *args, **kwargs):
    #     instance = self.get_queryset()
    #     serializer = self.get_serializer(instance, many=True)
    #     return response.Response(serializer.data, status=status.HTTP_200_OK)