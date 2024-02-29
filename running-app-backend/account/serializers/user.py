from rest_framework import serializers

from account.models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            "id", 
            "email", 
            "username", 
            "phone_number"
        )
        extra_kwargs = {
            "id": {"read_only": True},
        }

class DetailUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            "id", 
            "email", 
            "is_verified_email", 
            "username", 
            "phone_number", 
            "is_verified_phone"
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


