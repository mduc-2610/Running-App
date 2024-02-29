from rest_framework import serializers

from account.models import Profile
from account.serializers import UserSerializer

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = (
            "id",
            "user",
            "full_name",            
        )
        extra_kwargs = {
            "id" : {"read_only": True},
            "user": {"read_only": True}
        }

class DetailProfileSerializer(serializers.ModelSerializer):
    full_name = serializers.SerializerMethodField()

    def get_full_name(self, instance):
        return instance.full_name()
    
    class Meta:
        model = Profile
        fields = "__all__"
        extra_kwargs = {
            "id" : {"read_only": True},
            # "user": {"read_only": True}
        }

class CreateProfileSerializer(serializers.ModelSerializer):
    first_name = serializers.CharField(write_only=True)
    last_name = serializers.CharField(write_only=True)
    
    class Meta:
        model = Profile
        fields = (
            "id", "first_name", "last_name", 
            "avatar", "updated_at", "country",
            "city", "gender", "date_of_birth",
            "height", "weight", "shirt_size",
            "trouser_size", "shoe_size",
        )
        extra_kwargs = {
            "id": {"read_only": True},
        }

    def create(self, validated_data):
        first_name = validated_data.pop('first_name')
        last_name = validated_data.pop('last_name')
        user_data = {'first_name': first_name, 'last_name': last_name}
        user = self.context['request'].user
        profile = Profile.objects.create(user=user, **validated_data)
        return profile
    
class UpdateProfileSerializer(serializers.ModelSerializer):
    first_name = serializers.CharField(write_only=True)
    last_name = serializers.CharField(write_only=True)

    class Meta:
        model = Profile
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['first_name'] = instance.user.first_name if instance.user.first_name else ""
        data['last_name'] = instance.user.last_name if instance.user.last_name else ""
        return data
    
    def update(self, instance, validated_data):
        first_name = validated_data.pop('first_name', '')
        last_name = validated_data.pop('last_name', '')
        user = self.context['request'].user
        instance.user.first_name = first_name
        instance.user.last_name = last_name
        instance.user.save()
        instance = super().update(instance, validated_data)
        return instance

