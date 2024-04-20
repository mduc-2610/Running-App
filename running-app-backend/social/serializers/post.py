from rest_framework import serializers

from social.models import EventPost,\
                        ClubPost

from account.serializers.like import LikeSerializer
from account.serializers.author import AuthorSerializer

from social.serializers.post_comment import ClubPostCommentSerializer, \
                                            EventPostCommentSerializer
from social.serializers.post_like import ClubPostLikeSerializer, \
                                        EventPostLikeSerializer

from utils.pagination import CommonPagination

class ClubPostSerializer(serializers.ModelSerializer):
    user = AuthorSerializer()
    total_likes = serializers.SerializerMethodField()
    total_comments = serializers.SerializerMethodField()

    def get_total_likes(self, instance):
        return instance.total_likes()
    
    def get_total_comments(self, instance):
        return instance.total_comments()
    
    class Meta:
        model = ClubPost
        # exclude = ("likes", "user")
        fields = (
            "id", "user", "total_likes", "total_comments",
            "title", "content", "created_at"
        )
        read_only_fields = ("id", 'created_at')

class DetailClubPostSerializer(serializers.ModelSerializer):
    user = AuthorSerializer()
    total_likes = serializers.SerializerMethodField()
    total_comments = serializers.SerializerMethodField()
    likes = serializers.SerializerMethodField()
    comments = serializers.SerializerMethodField()

    def get_total_likes(self, instance):
        return instance.total_likes()
    
    def get_total_comments(self, instance):
        return instance.total_comments()

    
    def get_likes(self, instance):
        queryset = instance.likes.all()
        paginator = CommonPagination(page_size=100)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return LikeSerializer(paginated_queryset, many=True, read_only=True).data
    
    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return ClubPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
        
    class Meta:
        model = ClubPost
        fields = (
            "id", "user", "total_likes", "total_comments", "likes", "comments",
            "title", "content", "created_at"
        )
        read_only_fields = ('created_at', "id", "author_id")
        

class EventPostSerializer(serializers.ModelSerializer):
    user = AuthorSerializer()
    total_likes = serializers.SerializerMethodField()
    total_comments = serializers.SerializerMethodField()

    def get_total_likes(self, instance):
        return instance.total_likes()
    
    def get_total_comments(self, instance):
        return instance.total_comments()
    
    class Meta:
        model = ClubPost
        # exclude = ("likes", "user")
        fields = (
            "id", "user", "total_likes", "total_comments",
            "title", "content", "created_at"
        )
        read_only_fields = ("id", 'created_at')

class DetailEventPostSerializer(serializers.ModelSerializer):
    user = AuthorSerializer()
    total_likes = serializers.SerializerMethodField()
    total_comments = serializers.SerializerMethodField()
    likes = serializers.SerializerMethodField()
    comments = serializers.SerializerMethodField()

    def get_total_likes(self, instance):
        return instance.total_likes()
    
    def get_total_comments(self, instance):
        return instance.total_comments()
        
    def get_likes(self, instance):
        queryset = instance.likes.all()
        paginator = CommonPagination(page_size=100)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return LikeSerializer(paginated_queryset, many=True, read_only=True).data
    
    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return EventPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
    
    class Meta:
        model = EventPost
        fields = (
            "id", "user", "total_likes", "total_comments", "likes", "comments",
            "title", "content", "created_at"
        )
        read_only_fields = ('created_at', "id", "author_id")
        

        