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
        return None

    def get_check_user_follow(self, instance):
        request_user_id = self.context.get("request_user_id")
        if request_user_id:
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
