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
    # path('user-participation-club/participants/<uuid:club_id>/', UserParticipationEventViewSet.as_view({'get': 'participants'}), name='user_participation_club_api'),
    # path('user-participation-club/clubs/<uuid:user_id>/', UserParticipationEventViewSet.as_view({'get': 'clubs'}), name='user_participation_club_api'),

    # path('user-participation-event/participants/<uuid:event_id>/', UserParticipationEventViewSet.as_view({'get': 'participants'}), name='user_participation_event_api'),
    # path('user-participation-event/events/<uuid:user_id>/', UserParticipationEventViewSet.as_view({'get': 'events'}), name='user_participation_event_api'),
]

urlpatterns += router.urls
