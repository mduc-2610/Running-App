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