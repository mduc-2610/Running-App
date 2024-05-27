from rest_framework import serializers

from activity.models import Club, UserParticipationClub
from account.serializers import LeaderboardSerializer 
from account.serializers import DetailUserSerializer
from activity.serializers import DetailActivityRecordSerializer
from social.serializers import ClubPostSerializer
from utils.function import get_start_of_day, \
                            get_end_of_day, \
                            get_start_date_of_week, \
                            get_end_date_of_week, \
                            get_start_date_of_month, \
                            get_end_date_of_month, \
                            get_start_date_of_year, \
                            get_end_date_of_year

from utils.pagination import CommonPagination
class ClubSerializer(serializers.ModelSerializer):
    sport_type = serializers.CharField(source="get_sport_type_display")
    organization = serializers.CharField(source="get_organization_display")
    privacy = serializers.CharField(source="get_privacy_display") 
    check_user_join = serializers.SerializerMethodField() 
    
    def get_check_user_join(self, instance):
        request_user = self.context.get("user")
        if request_user:
            request_user_id = request_user.id
            instance = UserParticipationClub.objects.filter(
                user_id=request_user_id, club_id=instance.id).first()
            return instance.id if instance else None
        return None
    
    class Meta:
        model = Club
        fields = (
            "id", 
            "name", 
            "avatar", 
            "sport_type",
            "privacy", 
            "organization",
            "week_activities", 
            "total_participants",
            "total_posts",
            "total_activity_records",
            "check_user_join"
        )
        extra_kwargs = {
            "id": {"read_only": True}
        }

class DetailClubSerializer(serializers.ModelSerializer):
    week_activites = serializers.SerializerMethodField()
    participants = serializers.SerializerMethodField()
    sport_type = serializers.CharField(source="get_sport_type_display")
    organization = serializers.CharField(source="get_organization_display")
    privacy = serializers.CharField(source="get_privacy_display") 
    posts = serializers.SerializerMethodField()
    activity_records = serializers.SerializerMethodField()
    check_user_join = serializers.SerializerMethodField()
    
    def get_week_activites(self, instance):
        return instance.week_activities()
    
    def get_participants(self, instance):
        context = self.context
        exclude = context.get("exclude", [])
        if "participants" not in exclude:
            sport_type = instance.sport_type
            club_id = instance.id
            type = "club"

            start_date = context.get("start_date")
            end_date = context.get("end_date")
            gender = context.get("gender")
            sort_by = context.get("sort_by")
            limit_user = context.get("limit_user")

            print({"start_date": start_date, "end_date": end_date, "sort_by": sort_by})

            users = [usr.user.performance for usr in instance.clubs.all()]
            
            if gender:
                users = [user for user in users if user.user.profile.gender == gender]

            def sort_cmp(x, sort_by):
                stats = x.range_stats(start_date, end_date, sport_type=sport_type)
                if sort_by == "Time":
                    return (-stats[3], -stats[0])
                return (-stats[0], -stats[3])
            users = sorted(users, key=lambda x: sort_cmp(x, sort_by))
            
            if limit_user:
                users = users[:int(limit_user)]

            return LeaderboardSerializer(users, many=True, context={
                "id": club_id,
                "type": type,
                "start_date": start_date,
                "end_date": end_date,
                "sport_type": sport_type,
                "check_follow": context.get("check_follow"),
                "user": context.get("user"),
                "request": context.get("request"),
            }).data
        return None
    
    def get_posts(self, instance):
        context = self.context
        exclude = context.get("exclude", [])
        if "posts" not in exclude:
            queryset = instance.club_posts.all()
            paginator = CommonPagination(page_size=5, page_query_param="post_page")
            paginated_queryset = paginator.paginate_queryset(queryset, context["request"])
            return ClubPostSerializer(
                paginated_queryset, many=True, context={
                    "request": context["request"],
                    "user": context["user"],
                }, read_only=True).data
        return None
    
    def get_activity_records(self, instance):
        context = self.context
        exclude = context.get("exclude", [])
        if "activity_records" not in exclude:
            participants = instance.clubs.all()
            queryset = []
            for participant in participants:
                queryset += participant.activity_records.all()
            paginator = CommonPagination(page_size=3, page_query_param="act_rec_page")
            paginated_queryset = paginator.paginate_queryset(queryset, context["request"])
            return DetailActivityRecordSerializer(
                paginated_queryset, many=True, context={
                    "request": context["request"],
                    "user": context["user"],
                }, read_only=True).data
        return None
    
    def get_check_user_join(self, instance):
        request_user_id = self.context["user"].id
        if request_user_id:
            instance = UserParticipationClub.objects.filter(
                user_id=request_user_id, club_id=instance.id).first()
            return instance.id if instance else None
        return None
    
    class Meta:
        model = Club
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }
    
class CreateUpdateClubSerializer(serializers.ModelSerializer):
    user_id = serializers.SerializerMethodField()
    
    def get_user_id(self, instance):
        return instance.id
    
    class Meta:
        model = Club
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }
# class UpdateClubSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Club
#         fields = "__all__"
#         extra_kwargs = {
#             "id": {"read_only": True},
#             "user": {"read_only": True},
#         }