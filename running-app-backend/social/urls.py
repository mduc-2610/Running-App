from django.urls import path, include
from rest_framework.routers import DefaultRouter
from social.views import (
    EventPostViewSet, ClubPostViewSet, 
    EventPostImageViewSet, ClubPostImageViewSet,
    ClubPostCommentViewSet, EventPostCommentViewSet, ActivityRecordPostCommentViewSet,
    FollowViewSet,  EventPostLikeViewSet, ClubPostLikeViewSet,
    ActivityRecordPostLikeViewSet
)

router = DefaultRouter()
router.register(r"follow", FollowViewSet)
router.register(r"event-post", EventPostViewSet)
router.register(r"club-post", ClubPostViewSet)
router.register(r"event-post-image", EventPostImageViewSet)
router.register(r"club-post-image", ClubPostImageViewSet)
router.register(r"club-post-comment", ClubPostCommentViewSet)
router.register(r"event-post-comment", EventPostCommentViewSet)
router.register(r"act-rec-post-comment", ActivityRecordPostCommentViewSet)
router.register(r'event-post-like', EventPostLikeViewSet)
router.register(r'club-post-like', ClubPostLikeViewSet)
router.register(r'activity-record-post-like', ActivityRecordPostLikeViewSet)

urlpatterns = [
    path("", include(router.urls)),
]
