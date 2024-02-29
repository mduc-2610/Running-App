from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from product.models import Brand

from product.serializers import BrandSerializer

class BrandViewSet(
    viewsets.ModelViewSet
):
    queryset = Brand.objects.all()
    serializer_class = BrandSerializer
