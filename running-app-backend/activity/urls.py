from django.urls import path, include

from rest_framework import routers

from activity.views import ActivityRecordViewSet, \
                            ClubViewSet, \
                            GroupViewSet, \
                            UserGroupViewSet, \
                            EventViewSet, \
                            UserParticipationClubViewSet, \
                            UserParticipationEventViewSet

router = routers.DefaultRouter()
router.register(r"activity-record", ActivityRecordViewSet)
router.register(r"club", ClubViewSet)
router.register(r"group", GroupViewSet)
router.register(r"user-group", UserGroupViewSet)
router.register(r"event", EventViewSet)
router.register(r"user-participation-club", UserParticipationClubViewSet)
router.register(r"user-participation-event", UserParticipationEventViewSet)

urlpatterns = [

]

urlpatterns += router.urls
