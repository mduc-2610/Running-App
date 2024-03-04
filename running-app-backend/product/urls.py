from django.urls import path, include

from rest_framework import routers

from product.views import BrandViewSet,\
                        CategoryViewSet,\
                        ProductViewSet, \
                        ProductImageViewSet, \
                        UserProductViewSet

router = routers.DefaultRouter()
router.register(r"brand", BrandViewSet)
router.register(r"category", CategoryViewSet)
router.register(r"product", ProductViewSet)
router.register(r"product-image", ProductImageViewSet)
router.register(r"user-product", UserProductViewSet)

urlpatterns = [

]

urlpatterns += router.urls