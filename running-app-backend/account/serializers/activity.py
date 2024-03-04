from rest_framework import serializers

from account.models import Activity

from account.serializers import UserSerializer
from activity.serializers.event import EventSerializer
from activity.serializers.club import ClubSerializer
from product.serializers.product import ProductSerializer

class ActivitySerializer(serializers.ModelSerializer):
    user = UserSerializer()
    products = ProductSerializer(many=True, read_only=True)
    events = EventSerializer(many=True, read_only=True)
    clubs = ClubSerializer(many=True, read_only=True)

    # def to_representation(self, instance):
    #     data = super().to_representation(instance)
    #     data.update(data.pop('user'))
    #     return data
    
    class Meta:
        model = Activity
        fields = "__all__"