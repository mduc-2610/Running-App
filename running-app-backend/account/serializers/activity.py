from rest_framework import serializers

from django.utils import timezone

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
    clubs = ClubSerializer(many=True, read_only=True)
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
    
    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        return Activity.objects.create(user_id=user_id, **validated_data)

    
    class Meta:
        model = Activity
        fields = "__all__"
