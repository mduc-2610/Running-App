from rest_framework import serializers

from activity.models import Club
from account.serializers import LeaderboardSerializer 
from account.serializers import DetailUserSerializer
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
    sport_type = serializers.CharField(source='get_sport_type_display')
    organization = serializers.CharField(source='get_organization_display')
    privacy = serializers.CharField(source='get_privacy_display') 
    total_posts = serializers.SerializerMethodField()

    def get_total_posts(self, instance):
        return instance.club_posts.count()
    
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
            "number_of_participants",
            "total_posts"
        )
        extra_kwargs = {
            "id": {"read_only": True}
        }

class DetailClubSerializer(serializers.ModelSerializer):
    week_activites = serializers.SerializerMethodField()
    number_of_participants = serializers.SerializerMethodField()
    participants = serializers.SerializerMethodField()
    sport_type = serializers.CharField(source='get_sport_type_display')
    organization = serializers.CharField(source='get_organization_display')
    privacy = serializers.CharField(source='get_privacy_display') 
    total_posts = serializers.SerializerMethodField()
    posts = serializers.SerializerMethodField()

    def get_week_activites(self, instance):
        return instance.week_activities()
    
    def get_number_of_participants(self, instance):
        return instance.number_of_participants()
    
    def get_participants(self, instance):
        context = self.context
        exclude = context.get('exclude', [])
        if 'participants' not in exclude:
            sport_type = instance.sport_type
            club_id = instance.id
            type = "club"

            start_date = context.get('start_date')
            end_date = context.get('end_date')
            gender = context.get('gender')
            sort_by = context.get('sort_by')
            limit_user = context.get('limit_user')

            print({'start_date': start_date, 'end_date': end_date, 'sort_by': sort_by})

            users = [instance.user.performance for instance in instance.clubs.all()]
            
            if gender:
                users = [user for user in users if user.user.profile.gender == gender]

            def sort_cmp(x, sort_by):
                stats = x.range_stats(start_date, end_date, sport_type=sport_type)
                if sort_by == 'Time':
                    return (-stats[3], -stats[0])
                return (-stats[0], -stats[3])
            users = sorted(users, key=lambda x: sort_cmp(x, sort_by))
            
            if limit_user:
                users = users[:int(limit_user)]

            return LeaderboardSerializer(users, many=True, context={
                'id': club_id,
                'type': type,
                'start_date': start_date,
                'end_date': end_date,
                'sport_type': sport_type,
            }).data
        return None
    
    def get_total_posts(self, instance):
        return instance.club_posts.count()
    
    def get_posts(self, instance):
        context = self.context
        exclude = context.get('exclude', [])
        if 'posts' not in exclude:
            queryset = instance.club_posts.all()
            paginator = CommonPagination(page_size=5)
            paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
            return ClubPostSerializer(paginated_queryset, many=True, read_only=True).data
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