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

    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateProductSerialzier
        elif self.action == "retrieve":
            return DetailProductSerializer    
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)


class ProductImageViewSet(viewsets.ModelViewSet):
    queryset = ProductImage.objects.all()
    serializer_class = ProductImageSerializer