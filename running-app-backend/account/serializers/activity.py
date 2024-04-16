from rest_framework import serializers

from django.utils import timezone
from django.db.models import Q

from account.models import Activity

from account.serializers import UserSerializer
from activity.models import UserParticipationEvent
from activity.serializers.event import EventSerializer
from activity.serializers.club import ClubSerializer
from activity.serializers.activity_record import ActivityRecordSerializer
from product.serializers.product import ProductSerializer

class ActivitySerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    user_id = serializers.UUIDField()
    products = ProductSerializer(many=True, read_only=True)
    events = EventSerializer(many=True, read_only=True)
    clubs = serializers.SerializerMethodField()
    activity_records = ActivityRecordSerializer(many=True, read_only=True)

    def to_representation(self, instance):
        state = self.context.get('state', None)
        data = super().to_representation(instance)
        events = data.pop('events')
        
        if state:
            if state == "created":
                events = [EventSerializer(x.event).data for x in 
                        UserParticipationEvent.objects.filter(user=data['id'], is_superadmin=True)]
            elif state == "ended":
                events = [EventSerializer(x.event).data for x in 
                        UserParticipationEvent.objects.filter(user=data['id'], is_superadmin=True) if x.event.started_at < timezone.now()]
                # events = []
            elif state == 'joined':
                events = events
                
        data.update({'events': events})
        return data
    
    def get_clubs(self, instance):
        queryset = instance.clubs.all()
        context = self.context
        club_params = context.get('club_params')
        filters = Q()

        if club_params["club_name"]:
            filters &= Q(name__icontains=club_params["club_name"])

        if club_params["club_sport_type"]:
            filters &= Q(sport_type=club_params["club_sport_type"])

        if club_params["club_mode"]:
            filters &= Q(privacy=club_params["club_mode"])

        if club_params["club_org_type"]:
            filters &= Q(organization=club_params["club_org_type"])

        queryset = queryset.filter(filters)

        return ClubSerializer(queryset, many=True, read_only=True).data
    
    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        return Activity.objects.create(user_id=user_id, **validated_data)

    
    class Meta:
        model = Activity
        fields = "__all__"
