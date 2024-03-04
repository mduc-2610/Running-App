from rest_framework import generics, \
                            mixins, \
                            viewsets, \
                            status
from rest_framework import response
from rest_framework.decorators import action

from django.shortcuts import get_object_or_404

from account.models import User
from product.models import Product, \
                            UserProduct
from product.serializers import ProductSerializer, \
                                UserProductSerializer

class UserProductViewSet(
    viewsets.ModelViewSet
):
    queryset = UserProduct.objects.all()
    serializer_class = UserProductSerializer
    
    # def get_queryset(self):
    #     user_id = self.kwargs.get('user_id', None)
    #     if self.action == 'user_owned_products':
    #         return get_object_or_404(User, pk=user_id).user_activity.products.all()
    #     return super().get_queryset()
    
    # def get_serializer_class(self):
    #     if self.action == 'user_owned_products':
    #         return ProductSerializer
    #     return super().get_serializer_class()

    # def get_serializer(self, *args, **kwargs):
    #     serializer_class = self.get_serializer_class()
    #     kwargs['context'] = self.get_serializer_context()
    #     return serializer_class(*args, **kwargs)

    # @action(detail=True, methods=['GET'], name="user_owned_products")
    # def user_owned_products(self, request, *args, **kwargs):
    #     user_products = self.get_queryset()
    #     serializer = self.get_serializer(user_products, many=True)
    #     return response.Response(serializer.data, status=status.HTTP_200_OK)
