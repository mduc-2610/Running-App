from rest_framework import serializers

from account.models import User, \
                            Performance, \
                            Profile

from account.serializers.notification_setting import NotificationSettingSerializer


class LoginSerializer(serializers.Serializer):
    class Meta:
        model = User
        fields = (
            "username",
            "password",
        )

class ChangePasswordSerializer(serializers.Serializer):
    user_id = serializers.UUIDField()
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)
    confirm_new_password = serializers.CharField(required=True)

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            "id", 
            "email", 
            "username",
            "name", 
            "phone_number",
        )
        extra_kwargs = {
            "id": {"read_only": True},
        }

class DetailUserSerializer(serializers.ModelSerializer):
    profile = serializers.HyperlinkedRelatedField(
        view_name="profile-detail",
        read_only=True,
    )
    performance = serializers.HyperlinkedRelatedField(
        view_name="performance-detail",
        read_only=True,
    )
    privacy = serializers.HyperlinkedRelatedField(
        view_name="privacy-detail",
        read_only=True,
    )
    activity = serializers.HyperlinkedRelatedField(
        view_name="activity-detail",
        read_only=True,
    )
    notification_setting = serializers.HyperlinkedRelatedField(
        view_name="notificationsetting-detail",
        read_only=True,
    )
    
    avatar = serializers.SerializerMethodField()
    
    def get_avatar(self, instance):
        request = self.context.get('request')
        avatar = instance.profile.avatar
        if avatar:
            return request.build_absolute_uri(f"/static/images/avatars/{avatar}")
        return None
    
    class Meta:
        model = User
        fields = (
            "id", 
            "email", 
            "is_verified_email", 
            "username",
            "name", 
            "phone_number", 
            "is_verified_phone",
            "profile",
            "performance",
            "activity",
            "privacy",
            "notification_setting",
            "avatar",
        )
        extra_kwargs = {
            "id": {"read_only": True},
        }

class UpdateUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

class CreateUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

    def create(self, validated_data):
        password = validated_data.pop('password')
        user = User.objects.create(**validated_data)
        user.set_password(password)
        user.save()
        return user

