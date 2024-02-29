from rest_framework import serializers

from product.models import Brand

class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True}
        }