from rest_framework import serializers

from django.utils import timezone

from account.models import Activity

from account.serializers import UserSerializer
from activity.models import UserParticipationEvent
from activity.serializers.event import EventSerializer
from activity.serializers.club import ClubSerializer
from product.serializers.product import ProductSerializer

class ActivitySerializer(serializers.ModelSerializer):
    user = UserSerializer()
    products = ProductSerializer(many=True, read_only=True)
    events = EventSerializer(many=True, read_only=True)
    clubs = ClubSerializer(many=True, read_only=True)

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
    
    class Meta:
        model = Activity
        fields = "__all__"
