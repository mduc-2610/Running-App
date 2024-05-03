from django.contrib import admin
from activity.models import Event

class EventAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'started_at', 'ended_at', 
                    'sport_type', 'privacy', 'competition', 
                    'ranking_type', 'completion_goal', 'total_accumulated_distance', 
                    'total_money_donated', 'days_remain', 'total_participants')
    list_filter = ('sport_type', 'privacy', 'competition', 'ranking_type', 
                   'total_accumulated_distance', 'total_money_donated')
    search_fields = ['name']
    readonly_fields = ('id', 'days_remain', 'total_participants', 'get_readable_time')

