from rest_framework import serializers
from product.models import UserProduct

from account.serializers import UserSerializer
from product.serializers import ProductSerializer

class UserProductSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    product = ProductSerializer()
    
    class Meta:
        model = UserProduct
        fields = '__all__'