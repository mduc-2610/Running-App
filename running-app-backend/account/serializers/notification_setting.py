from rest_framework import serializers
from account.models import NotificationSetting

class NotificationSettingSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationSetting
        fields = '__all__'
        extra_kwargs = {
            "user" : {
                "read_only": True,
            }
        }

class CreateNotificationSettingSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField()
    
    def create(self, validated_data):
        user_id = validated_data.pop('user_id')
        return NotificationSetting.objects.create(user_id=user_id, **validated_data)
    class Meta:
        model = NotificationSetting
        fields = '__all__'
        extra_kwargs = {
            "id": {"read_only": True},
            "user" : {"read_only": True,}
        }