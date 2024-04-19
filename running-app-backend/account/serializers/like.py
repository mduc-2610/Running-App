from rest_framework import serializers
from account.models import Activity

class LikeSerializer(serializers.ModelSerializer):
    id = serializers.SerializerMethodField()
    name = serializers.SerializerMethodField()

    def get_id(self, instance):
        return instance.user.id
    
    def get_name(self, instance):
        return instance.user.name
    class Meta:
        model = Activity
        fields = (
            "id",
            "name"
        )
        extra_kwargs = {
            "id": {"read_only" : True}
        }
