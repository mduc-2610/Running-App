from rest_framework import serializers

from django.utils import timezone
from django.db.models import Q

from account.models import Activity

from account.serializers import UserSerializer
from activity.models import UserParticipationEvent, Event
from activity.serializers.event import EventSerializer
from activity.serializers.club import ClubSerializer
from activity.serializers.activity_record import ActivityRecordSerializer
from product.serializers.product import ProductSerializer

class ActivitySerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    user_id = serializers.UUIDField()
    products = ProductSerializer(many=True, read_only=True)
    events = serializers.SerializerMethodField()
    clubs = serializers.SerializerMethodField()
    activity_records = ActivityRecordSerializer(many=True, read_only=True)

    def get_events(self, instance):
        now = timezone.now()
        context = self.context
        event_params = context.get('event_params')
        
        queryset = instance.events.all()
        if event_params["state"] == "CREATED":
            queryset = Event.objects.filter(userparticipationevent__user=instance, userparticipationevent__is_superadmin=True)
        elif event_params["state"] == "ENDED":
            queryset = queryset.filter(ended_at__lt=now)
        
        if event_params["name"]:
            queryset = queryset.filter(name__icontains=event_params["name"])

        return EventSerializer(queryset, many=True, read_only=True).data

    def get_clubs(self, instance):
        queryset = instance.clubs.all()
        context = self.context
        club_params = context.get('club_params')
        filters = Q()

        if club_params["name"]:
            filters &= Q(name__icontains=club_params["name"])

        if club_params["sport_type"]:
            filters &= Q(sport_type=club_params["sport_type"])

        if club_params["mode"]:
            filters &= Q(privacy=club_params["mode"])

        if club_params["org_type"]:
            filters &= Q(organization=club_params["org_type"])

        queryset = queryset.filter(filters)

        return ClubSerializer(queryset, many=True, read_only=True).data
    
    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        return Activity.objects.create(user_id=user_id, **validated_data)

    class Meta:
        model = Activity
        fields = "__all__"
