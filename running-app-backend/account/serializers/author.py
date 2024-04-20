from rest_framework import serializers
from account.models import Activity

class AuthorSerializer(serializers.ModelSerializer):
    id = serializers.SerializerMethodField()
    name = serializers.SerializerMethodField()
    avatar = serializers.SerializerMethodField()

    def get_id(self, instance):
        return instance.user.id
    
    def get_name(self, instance):
        return instance.user.name
    
    def get_avatar(self, instance):
        return None

    class Meta:
        model = Activity
        fields = (
            "id",
            "name",
            "avatar"
        )
        extra_kwargs = {
            "id": {"read_only" : True}
        }
