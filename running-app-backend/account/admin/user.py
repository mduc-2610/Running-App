from django.contrib import admin

from account.models import User 
from activity.models import UserParticipationEvent, \
                            UserParticipationClub

class UserParticipationClubInline(admin.TabularInline):
    extra = 0
    model = UserParticipationClub

class UserParticipationEventInline(admin.TabularInline):
    extra = 0
    model = UserParticipationEvent
    fields = ("is_admin", "event")

class UserAdmin(admin.ModelAdmin):
    list_display = ("email", "username")
    list_filter = ("email", "is_verified_email", "username")
    inlines = [
        # UserParticipationClubInline, 
        # UserParticipationEventInline
    ]
    search_fields = ("email", "username")
