from django.db.models import Q
from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from product.models import Product, \
                            ProductImage      

from product.serializers import ProductSerializer, \
                                DetailProductSerializer, \
                                CreateUpdateProductSerialzier, \
                                ProductImageSerializer

class ProductViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def get_queryset(self):
        queryset = super().get_queryset()
        params = self.request.query_params
        limit = params.get('limit', None)
        brand = params.get('brand', None)
        category = params.get('category', None)
        q = params.get('q', None)

        queryset = queryset.select_related('brand', 'category')

        if brand:
            queryset = queryset.filter(brand__name=brand)

        if category:
            queryset = queryset.filter(category__name=category)
            
        if q:
            queryset = queryset.filter(
                Q(name__icontains=q) |
                Q(brand__name__icontains=q) |
                Q(price__startswith=q)
            )
        
        if limit:
            queryset = queryset[:int(limit)]
        
        return queryset
    
    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateProductSerialzier
        elif self.action == "retrieve":
            return DetailProductSerializer    
        return super().get_serializer_class()
    
    # def get_serializer_context(self):

    # def get_serializer(self, *args, **kwargs):
    #     serializer_class = self.get_serializer_class()
    #     kwargs["context"] = self.get_serializer_context()
    #     return serializer_class(*args, **kwargs)

    

class ProductImageViewSet(viewsets.ModelViewSet):
    queryset = ProductImage.objects.all()
    serializer_class = ProductImageSerializer