from rest_framework import serializers

from account.models import User, \
                            Profile

class LoginSerializer(serializers.Serializer):
    class Meta:
        model = User
        fields = (
            "username",
            "password",
        )
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            "id", 
            "email", 
            "username",
            "name", 
            "phone_number"
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


