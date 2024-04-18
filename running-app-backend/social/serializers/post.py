from rest_framework import serializers
from social.models import EventPost,\
                        ClubPost
from social.serializers.post_comment import ClubPostCommentSerializer, \
                                            EventPostCommentSerializer

from utils.pagination import CommonPagination

class EventPostSerializer(serializers.ModelSerializer):
    total_comments = serializers.SerializerMethodField()
    
    def get_total_comments(self, instance):
        return instance.total_comments()
    
    class Meta:
        model = EventPost
        fields = "__all__"
        read_only_fields = ('created_at', "id", "user")

class DetailEventPostSerializer(serializers.ModelSerializer):
    comments = serializers.SerializerMethodField()

    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return EventPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
        
    class Meta:
        model = EventPost
        fields = "__all__"
        read_only_fields = ('created_at', "id", "user")

class ClubPostSerializer(serializers.ModelSerializer):
    total_comments = serializers.SerializerMethodField()
    
    def get_total_comments(self, instance):
        return instance.total_comments()
    class Meta:
        model = ClubPost
        fields = "__all__"
        read_only_fields = ('created_at', "id", "user")

class DetailClubPostSerializer(serializers.ModelSerializer):
    comments = serializers.SerializerMethodField()

    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return ClubPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
        
    class Meta:
        model = ClubPost
        fields = "__all__"
        read_only_fields = ('created_at', "id", "user")

        