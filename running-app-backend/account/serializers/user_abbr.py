from rest_framework import serializers
from account.models import Activity
from social.models import Follow

class UserAbbrSerializer(serializers.ModelSerializer):
    id = serializers.SerializerMethodField()
    act_id = serializers.SerializerMethodField()
    name = serializers.SerializerMethodField()
    avatar = serializers.SerializerMethodField()
    check_user_follow = serializers.SerializerMethodField()

    def get_id(self, instance):
        return instance.user.id
    
    def get_act_id(self, instance):
        return instance.id
    
    def get_name(self, instance):
        return instance.user.name
    
    def get_avatar(self, instance):
        request = self.context.get('request')
        avatar = instance.user.profile.avatar
        if request and avatar:
            return request.build_absolute_uri(f"/static/images/avatars/{avatar}")
        return None

    def get_check_user_follow(self, instance):
        request_user = self.context.get("user")
        if request_user:
            request_user_id = request_user.id
            instance = Follow.objects.filter(follower=request_user_id, followee=instance.id).first()
            return instance.id if instance else None
        return None

    class Meta:
        model = Activity
        fields = (
            "id",
            "act_id",
            "name",
            "avatar",
            "check_user_follow",
        )
        extra_kwargs = {
            "id": {"read_only" : True}
        }
