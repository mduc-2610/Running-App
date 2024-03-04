from django.urls import path, include
from rest_framework import routers

from account.views import UserViewSet, \
                        ProfileViewSet, \
                        PrivacyViewSet, \
                        PerformanceViewSet, \
                        ActivityViewSet

router = routers.DefaultRouter()
router.register(r"user", UserViewSet)
router.register(r"profile", ProfileViewSet)
router.register(r"privacy", PrivacyViewSet)
router.register(r"performance", PerformanceViewSet)
router.register(r"activity", ActivityViewSet)

urlpatterns = [
    
]

urlpatterns += router.urls