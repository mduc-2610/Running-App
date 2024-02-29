from rest_framework import serializers

from account.models import Performance
from account.serializers.user import UserSerializer 

class PerformanceSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    point=  serializers.SerializerMethodField()
    level = serializers.SerializerMethodField()
    total_steps = serializers.SerializerMethodField()
    steps_remaining = serializers.SerializerMethodField()

    def get_point(self, instance):
        return instance.point()
    
    def get_level(self, instance):
        return instance.level()

    def get_total_steps(self, instance):
        return instance.total_steps()

    def get_steps_remaining(self, instance):
        return instance.steps_remaining()
    
    class Meta:
        model = Performance
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

class CreatePerformanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Performance
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }