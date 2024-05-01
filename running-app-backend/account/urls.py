from django.urls import path, include
from rest_framework import routers

from account.views import (
    UserViewSet, ProfileViewSet,
    PrivacyViewSet, PerformanceViewSet,
    ActivityViewSet, LoginViewSet, LogoutView,
    NotificationSettingViewSet
)
router = routers.DefaultRouter()
router.register(r"user", UserViewSet)
router.register(r"login", LoginViewSet)
router.register(r"profile", ProfileViewSet)
router.register(r"privacy", PrivacyViewSet)
router.register(r"performance", PerformanceViewSet)
router.register(r"activity", ActivityViewSet)
router.register(r"notification-setting", NotificationSettingViewSet)


urlpatterns = [
    # path('login/', LoginViewSet.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
]

urlpatterns += router.urls