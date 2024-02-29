from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from product.models import Category

from product.serializers import CategorySerializer

class CategoryViewSet(
    viewsets.ModelViewSet
):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
