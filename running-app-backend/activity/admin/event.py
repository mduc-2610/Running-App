from django.contrib import admin
from activity.models import Event

class EventAdmin(admin.ModelAdmin):
    list_display = ('name', 'started_at', 'ended_at', 'sport_type', 'is_group')
    list_filter = ('sport_type', 'is_group')
    search_fields = ('name',)
    date_hierarchy = 'started_at'
    ordering = ('-started_at',)