from rest_framework import serializers

from account.models import Privacy

class PrivacySerializer(serializers.ModelSerializer):
    class Meta:
        model = Privacy
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
            "user": {"read_only": True}
        }

class CreatePrivacySerializer(serializers.ModelSerializer):
    class Meta:
        model = Privacy
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
            "user": {"read_only": True}
        }