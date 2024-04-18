from django.contrib import admin
from activity.models import UserParticipationClub, \
                            UserParticipationEvent, \
                            UserParticipationGroup

class UserParticipationAdmin(admin.ModelAdmin):
    list_display = ('user', 'is_superadmin', 'is_admin', 'is_approved', 'participated_at')
    list_filter = ('is_superadmin', 'is_admin', 'is_approved', 'participated_at')
    search_fields = ['user__username']
    readonly_fields = ('participated_at',)