from rest_framework import serializers
from rest_framework.exceptions import NotFound

from django.utils import timezone
from django.db.models import Q
from django.core.paginator import Paginator

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
    products = serializers.SerializerMethodField()
    events = serializers.SerializerMethodField()
    clubs = serializers.SerializerMethodField()
    activity_records = serializers.SerializerMethodField()

    def get_events(self, instance):
        now = timezone.now()
        context = self.context
        fields = context.get("fields")

        if not fields or "events" in fields:
            queryset = instance.events.all()

            event_params = context.get('event_params')
            if event_params["state"] == "CREATED":
                queryset = Event.objects.filter(userparticipationevent__user=instance, userparticipationevent__is_superadmin=True)
            elif event_params["state"] == "ENDED":
                queryset = queryset.filter(ended_at__lt=now)
    
            if event_params["name"]:
                queryset = queryset.filter(name__icontains=event_params["name"])

            return EventSerializer(queryset, many=True, read_only=True).data
        else:
            return None
    

    def get_clubs(self, instance):
        context = self.context
        fields = context.get("fields")

        if not fields or "clubs" in fields:
            queryset = instance.clubs.all()
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
        else:
            return None
    
    def get_activity_records(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "activity_records" in fields:
            queryset = instance.activity_records.all()
            activity_record_params = context.get("activity_record_params")
            page_size = activity_record_params["page_size"]
            page_number = activity_record_params["page"]

            paginator = Paginator(queryset, page_size)
            page_obj = paginator.get_page(page_number)

            if page_number > paginator.num_pages:
                return None  
            
            return ActivityRecordSerializer(page_obj.object_list, many=True, read_only=True).data
                
        else:
            return None
        
    def get_products(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "products" in fields:
            queryset = instance.products.all()
            return ProductSerializer(queryset, many=True, read_only=True).data
        else:
            return None
        
    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        return Activity.objects.create(user_id=user_id, **validated_data)

    class Meta:
        model = Activity
        fields = "__all__"
