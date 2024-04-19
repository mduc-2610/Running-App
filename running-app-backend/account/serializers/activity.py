from rest_framework import serializers
from rest_framework.exceptions import NotFound

from django.utils import timezone
from django.db.models import Q
from django.core.paginator import Paginator

from account.models import Activity
from account.serializers import UserSerializer
from account.serializers.like import LikeSerializer
from activity.models import UserParticipationEvent, Event
from activity.serializers.event import EventSerializer
from activity.serializers.club import ClubSerializer
from activity.serializers.activity_record import ActivityRecordSerializer
from product.serializers.product import ProductSerializer
from social.serializers import ClubPostSerializer, \
                            EventPostSerializer, \
                            ClubPostCommentSerializer, \
                            EventPostCommentSerializer, \
                            ActivityRecordPostCommentSerializer, \
                            ClubPostLikeSerializer, \
                            EventPostLikeSerializer, \
                            ActivityRecordPostLikeSerializer
from utils.pagination import CommonPagination

class ActivitySerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    user_id = serializers.UUIDField()
    followers = serializers.SerializerMethodField()
    followees = serializers.SerializerMethodField()
    products = serializers.SerializerMethodField()
    clubs = serializers.SerializerMethodField()
    events = serializers.SerializerMethodField()
    activity_records = serializers.SerializerMethodField()
    club_posts = serializers.SerializerMethodField()
    event_posts = serializers.SerializerMethodField()
    activity_record_post_likes = serializers.SerializerMethodField()
    club_post_likes = serializers.SerializerMethodField()
    event_post_likes = serializers.SerializerMethodField()

    activity_record_post_comments = serializers.SerializerMethodField()
    club_post_comments = serializers.SerializerMethodField()
    event_post_comments = serializers.SerializerMethodField()

    
    def get_paginated_queryset(self, queryset, page_size=5):
        paginator = CommonPagination(page_size=page_size)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return paginated_queryset
    
    def get_followers(self, instance):
        context = self.context
        fields = context.get("fields")
        if not fields or "followers" in fields:
            queryset = [follow.follower for follow in instance.followers.all()]
            queryset = self.get_paginated_queryset(queryset)
            return LikeSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_followees(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "followees" in fields:
            queryset = [follow.followee for follow in instance.following.all()]
            queryset = self.get_paginated_queryset(queryset)
            return LikeSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_products(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "products" in fields:
            queryset = instance.products.all()
            queryset = self.get_paginated_queryset(queryset)
            return ProductSerializer(queryset, many=True, read_only=True).data
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
            
            queryset = self.get_paginated_queryset(queryset)
            return ClubSerializer(queryset, many=True, read_only=True).data
        return None
    
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

            queryset = self.get_paginated_queryset(queryset)
            return EventSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_activity_records(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "activity_records" in fields:
            queryset = instance.activity_records.all()
            # activity_record_params = context.get("activity_record_params")
            # page_size = activity_record_params["page_size"]
            # page_number = activity_record_params["page"]

            # paginator = Paginator(queryset, page_size)
            # page_obj = paginator.get_page(page_number)

            # if page_number > paginator.num_pages:
            #     return None  
            # return ActivityRecordSerializer(page_obj.object_list, many=True, read_only=True).data
            queryset = self.get_paginated_queryset(queryset)
            return ActivityRecordSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_club_posts(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "club_posts" in fields:
            queryset = instance.club_posts.all()
            queryset = self.get_paginated_queryset(queryset)
            return ClubPostSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_event_posts(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "event_posts" in fields:
            queryset = instance.event_posts.all()
            queryset = self.get_paginated_queryset(queryset)
            return EventPostSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_activity_record_post_likes(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "activity_record_post_likes" in fields:
            queryset = [x.post for x in  instance.act_rec_post_likes.all()]
            queryset = self.get_paginated_queryset(queryset)
            return ActivityRecordSerializer(queryset, many=True, read_only=True).data
        return None

    def get_club_post_likes(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "club_post_likes" in fields:
            queryset = [x.post for x in instance.club_post_likes.all()]
            queryset = self.get_paginated_queryset(queryset)
            return ClubPostSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_event_post_likes(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "event_post_likes" in fields:
            queryset = [x.post for x in instance.event_post_likes.all()]
            queryset = self.get_paginated_queryset(queryset)
            return EventPostSerializer(queryset, many=True, read_only=True).data
        return None

    def get_activity_record_post_comments(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "activity_record_post_comments" in fields:
            queryset = instance.activityrecordpostcomment_set.all()
            queryset = self.get_paginated_queryset(queryset)
            return ActivityRecordPostCommentSerializer(queryset, many=True, read_only=True).data
        return None

    def get_club_post_comments(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "club_post_comments" in fields:
            queryset = instance.clubpostcomment_set.all()
            queryset = self.get_paginated_queryset(queryset)
            return ClubPostCommentSerializer(queryset, many=True, read_only=True).data
        return None
    
    def get_event_post_comments(self, instance):
        context = self.context
        fields = context.get("fields")
        
        if not fields or "event_post_comments" in fields:
            queryset = instance.eventpostcomment_set.all()
            queryset = self.get_paginated_queryset(queryset)
            return EventPostCommentSerializer(queryset, many=True, read_only=True).data
        return None

    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        return Activity.objects.create(user_id=user_id, **validated_data)

    class Meta:
        model = Activity
        exclude = ("follow",)
