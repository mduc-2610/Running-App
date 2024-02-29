from django.contrib import admin
from activity.models import EventGroup, UserEventGroup

class EventGroupAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'description')
    list_filter = ('name',)
    search_fields = ('name', 'description')

class UserEventGroupAdmin(admin.ModelAdmin):
    list_display = ('user', 'event_group', 'participated_at', 'is_admin')
    list_filter = ('user', 'event_group', 'is_admin')
    search_fields = ('user__username', 'event_group__name')