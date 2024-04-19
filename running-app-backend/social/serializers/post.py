from rest_framework import serializers

from social.models import EventPost,\
                        ClubPost

from account.serializers.like import LikeSerializer
from social.serializers.post_comment import ClubPostCommentSerializer, \
                                            EventPostCommentSerializer
from social.serializers.post_like import ClubPostLikeSerializer, \
                                        EventPostLikeSerializer

from utils.pagination import CommonPagination

class ClubPostSerializer(serializers.ModelSerializer):
    author_id = serializers.SerializerMethodField()
    total_likes = serializers.SerializerMethodField()
    total_comments = serializers.SerializerMethodField()

    def get_author_id(self, instance):
        return instance.user.user.id
        
    def get_total_likes(self, instance):
        return instance.total_likes()
    
    def get_total_comments(self, instance):
        return instance.total_comments()
    
    class Meta:
        model = ClubPost
        exclude = ("likes", "user")
        read_only_fields = ('created_at', "id", "author_id")

class DetailClubPostSerializer(serializers.ModelSerializer):
    author_id = serializers.SerializerMethodField()
    likes = serializers.SerializerMethodField()
    comments = serializers.SerializerMethodField()

    def get_author_id(self, instance):
        return instance.user.user.id
    
    def get_likes(self, instance):
        queryset = instance.likes.all()
        paginator = CommonPagination(page_size=6)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return LikeSerializer(paginated_queryset, many=True, read_only=True).data
    
    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return ClubPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
        
    class Meta:
        model = ClubPost
        exclude = ("user", )
        read_only_fields = ('created_at', "id", "author_id")
        

class EventPostSerializer(serializers.ModelSerializer):
    author_id = serializers.SerializerMethodField()
    total_likes = serializers.SerializerMethodField()
    total_comments = serializers.SerializerMethodField()

    def get_author_id(self, instance):
        return instance.user.user.id

    def get_total_likes(self, instance):
        return instance.total_likes()
    
    def get_total_comments(self, instance):
        return instance.total_comments()
    
    class Meta:
        model = EventPost
        exclude = ("likes", "user")
        read_only_fields = ('created_at', "id", "author_id")

class DetailEventPostSerializer(serializers.ModelSerializer):
    author_id = serializers.SerializerMethodField()
    likes = serializers.SerializerMethodField()
    comments = serializers.SerializerMethodField()
    
    def get_author_id(self, instance):
        return instance.user.user.id
        
    def get_likes(self, instance):
        queryset = instance.likes.all()
        paginator = CommonPagination(page_size=6)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return LikeSerializer(paginated_queryset, many=True, read_only=True).data
    
    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return EventPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
    
    class Meta:
        model = EventPost
        exclude = ("user", )
        read_only_fields = ('created_at', "id", "author_id")
        

        