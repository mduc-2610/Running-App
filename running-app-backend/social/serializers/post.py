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
    likes = serializers.SerializerMethodField()
    
    def get_likes(self, instance):
        queryset = instance.likes.all()
        # paginator = CommonPagination(page_size=100)
        # paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        # return LikeSerializer(paginated_queryset, many=True, read_only=True).data
        return LikeSerializer(queryset, many=True, read_only=True).data
    
    class Meta:
        model = ClubPost
        # exclude = ("likes", "user")
        fields = (
            "id", "user", "total_likes", "likes", "total_comments",
            "title", "content", "created_at"
        )
        read_only_fields = ("id", 'created_at')

class DetailClubPostSerializer(serializers.ModelSerializer):
    user = AuthorSerializer()
    likes = serializers.SerializerMethodField()
    comments = serializers.SerializerMethodField()
    
    def get_likes(self, instance):
        queryset = instance.likes.all()
        paginator = CommonPagination(page_size=100)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return LikeSerializer(paginated_queryset, many=True, read_only=True).data
    
    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5, page_query_param="cmt_pg")
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return ClubPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
        
    class Meta:
        model = ClubPost
        fields = (
            "id", "user", "total_likes", "total_comments", "likes", "comments",
            "title", "content", "created_at"
        )
        read_only_fields = ('created_at', "id", "author_id")

class CreateClubPostSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField(write_only=True)
    club_id = serializers.UUIDField(write_only=True)
    user = serializers.SerializerMethodField()

    def get_user(self, instance):
        return AuthorSerializer(instance.user).data
    
    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        club_id = validated_data.pop('club_id')
        post = ClubPost.objects.create(
            user_id=user_id, club_id=club_id, **validated_data)
        return post
    
    class Meta:
        model = ClubPost
        fields = (
            "id", "user", "title", "content",
            "created_at", "club_id", "user_id", "total_likes", "total_comments",
        )
        extra_kwargs = {
            "id": {"read_only": True},
            "post": {"read_only": True},
            "user": {"read_only": True},
            "total_likes": {"read_only": True},
            "total_comments": {"read_only": True},
            # "user_id": {"write_only": True},
        }

class EventPostSerializer(serializers.ModelSerializer):
    user = AuthorSerializer()
    likes = serializers.SerializerMethodField()
    
    def get_likes(self, instance):
        queryset = instance.likes.all()
        # paginator = CommonPagination(page_size=100)
        # paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        # return LikeSerializer(paginated_queryset, many=True, read_only=True).data
        return LikeSerializer(queryset, many=True, read_only=True).data
    class Meta:
        model = ClubPost
        # exclude = ("likes", "user")
        fields = (
            "id", "user", "total_likes", "likes", "total_comments",
            "title", "content", "created_at"
        )
        read_only_fields = ("id", 'created_at')

class DetailEventPostSerializer(serializers.ModelSerializer):
    user = AuthorSerializer()
    likes = serializers.SerializerMethodField()
    comments = serializers.SerializerMethodField()
    
    def get_likes(self, instance):
        queryset = instance.likes.all()
        paginator = CommonPagination(page_size=100)
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return LikeSerializer(paginated_queryset, many=True, read_only=True).data
    
    def get_comments(self, instance):
        queryset = instance.comments.all()
        paginator = CommonPagination(page_size=5, page_query_param="cmt_pg")
        paginated_queryset = paginator.paginate_queryset(queryset, self.context['request'])
        return EventPostCommentSerializer(paginated_queryset, many=True, read_only=True).data
    
    class Meta:
        model = EventPost
        fields = (
            "id", "user", "total_likes", "total_comments", "likes", "comments",
            "title", "content", "created_at"
        )
        read_only_fields = ('created_at', "id", "author_id")
        

class CreateEventPostSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField(write_only=True)
    event_id = serializers.UUIDField(write_only=True)
    user = serializers.SerializerMethodField()

    def get_user(self, instance):
        return AuthorSerializer(instance.user).data
    
    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        event_id = validated_data.pop('event_id')
        post = EventPost.objects.create(
            user_id=user_id, event_id=event_id, **validated_data)
        return post
    
    class Meta:
        model = EventPost
        fields = (
            "id", "user", "title", "content",
            "created_at", "event_id", "user_id", "total_likes", "total_comments",
        )
        extra_kwargs = {
            "id": {"read_only": True},
            "post": {"read_only": True},
            "user": {"read_only": True},
            "total_likes": {"read_only": True},
            "total_comments": {"read_only": True},
            # "user_id": {"write_only": True},
        }