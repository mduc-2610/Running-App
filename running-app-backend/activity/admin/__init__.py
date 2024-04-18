from django.contrib import admin

from .activity_record import ActivityRecordAdmin, \
                            ActivityRecordImageAdmin
from .club import ClubAdmin
from .event import EventAdmin
from .group import GroupAdmin
from .user_participation import UserParticipationAdmin

from activity.models import (ActivityRecord, 
                            ActivityRecordImage, 
                            Club, Group, Event, 
                            UserParticipationClub, 
                            UserParticipationEvent,
                            UserParticipationGroup)


admin.site.register(ActivityRecord, ActivityRecordAdmin)
admin.site.register(ActivityRecordImage, ActivityRecordImageAdmin)
admin.site.register(Club, ClubAdmin)
admin.site.register(Event, EventAdmin)
admin.site.register(Group, GroupAdmin)
admin.site.register(UserParticipationClub, UserParticipationAdmin)
admin.site.register(UserParticipationEvent, UserParticipationAdmin)
admin.site.register(UserParticipationGroup, UserParticipationAdmin)