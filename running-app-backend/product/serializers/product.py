from rest_framework import serializers

from product.models import Product, \
                            ProductImage

from product.serializers import BrandSerializer, \
                                CategorySerializer
from account.serializers import DetailUserSerializer

class ProductSerializer(serializers.ModelSerializer):
    brand = BrandSerializer(read_only=True)
    class Meta:
        model = Product
        fields = (
            "id",
            "name",
            "brand",
            "price",
        )
        extra_kwargs = {
            "id": {"read_only": True},
        }

class DetailProductSerializer(serializers.ModelSerializer):
    brand = BrandSerializer(read_only=True)
    category = CategorySerializer(read_only=True)
    owners = serializers.SerializerMethodField()
    
    def get_owners(self, instance):
        request = self.context.get('request', None)
        users = [instance.user for instance in instance.products.all()]
        return DetailUserSerializer(users, many=True, context={'request': request}).data

    class Meta:
        model = Product
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

class CreateUpdateProductSerialzier(serializers.ModelSerializer):
    # brand = BrandSerializer()
    # category = CategorySerializer()
    class Meta:
        model = Product
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

class ProductImageSerializer(serializers.ModelSerializer):
    brand = BrandSerializer(read_only=True)
    category = CategorySerializer(read_only=True)
    class Meta:
        model = ProductImage
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }

    
