from django.urls import path, include
from rest_framework.routers import DefaultRouter
from social.views import (
    EventPostViewSet, ClubPostViewSet, 
    EventPostImageViewSet, ClubPostImageViewSet,
    ClubPostCommentViewSet, EventPostCommentViewSet, ActivityRecordPostCommentViewSet,
    FollowViewSet
)

router = DefaultRouter()
router.register(r"event-post", EventPostViewSet)
router.register(r"club-post", ClubPostViewSet)
router.register(r"event-post-image", EventPostImageViewSet)
router.register(r"club-post-image", ClubPostImageViewSet)
router.register(r"club-post-comment", ClubPostCommentViewSet)
router.register(r"event-post-comment", EventPostCommentViewSet)
router.register(r"act-rec-post-comment", ActivityRecordPostCommentViewSet)
router.register(r"follow", FollowViewSet)

urlpatterns = [
    path("", include(router.urls)),
]
