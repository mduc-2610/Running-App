from django.urls import path, include
from rest_framework import routers

from account.views import UserViewSet, \
                        ProfileViewSet, \
                        PrivacyViewSet, \
                        PerformanceViewSet 

router = routers.DefaultRouter()
router.register(r"user", UserViewSet)
router.register(r"profile", ProfileViewSet)
router.register(r"privacy", PrivacyViewSet)
router.register(r"performance", PerformanceViewSet)

urlpatterns = [
    
]

urlpatterns += router.urls