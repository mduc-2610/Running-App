from rest_framework import serializers

from account.models import Profile
from account.serializers import UserSerializer

class ProfileSerializer(serializers.ModelSerializer):
    avatar = serializers.SerializerMethodField()

    def get_avatar(self, instance):
        request = self.context.get('request')
        if instance.avatar:
            return request.build_absolute_uri(f"/static/images/avatars/{instance.avatar}")
        return None

    
    class Meta:
        model = Profile
        fields = (
            "id",
            "user",
            "name",
            "avatar",            
        )
        extra_kwargs = {
            "id" : {"read_only": True},
            "user": {"read_only": True}
        }

class DetailProfileSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    avatar = serializers.SerializerMethodField()

    def get_name(self, instance):
        return instance.name()
    
    def get_avatar(self, instance):
        from core.settings import BASE_DIR
        return f"{BASE_DIR}/static/images/avatars/{instance.avatar}"
    
    class Meta:
        model = Profile
        fields = "__all__"
        extra_kwargs = {
            "id" : {"read_only": True},
            # "user": {"read_only": True}
        }

class CreateProfileSerializer(serializers.ModelSerializer):
    name = serializers.CharField(write_only=True)
    user_id = serializers.UUIDField()
    class Meta:
        model = Profile
        fields = (
            "id", "name", 
            "avatar", "updated_at", "country",
            "city", "gender", "date_of_birth",
            "height", "weight", "shirt_size",
            "trouser_size", "shoe_size", "user_id"
        )
        extra_kwargs = {
            "id": {"read_only": True},
        }

    def validate(self, data):
        super().validate(data)
        data['user_id'] = self.initial_data.get('user_id', None)
        data['name'] = self.initial_data.get('name', None)

        return data

    def create(self, validated_data):
        name = validated_data.pop('name', None)
        user_id = validated_data.pop('user_id', None)
        profile = Profile.objects.create(user_id=user_id, **validated_data)
        profile.user.name = name
        profile.user.save()
        
        return profile
    
    
    
class UpdateProfileSerializer(serializers.ModelSerializer):
    name = serializers.CharField(write_only=True)

    class Meta:
        model = Profile
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
            "user": {"read_only": True},
        }

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['name'] = instance.user.name if instance.user.name else ""
        return data
    
    def update(self, instance, validated_data):
        user_data = validated_data.pop('name', None)
        if user_data:
            instance.user.name = user_data
            instance.user.save()
        return super().update(instance, validated_data)

