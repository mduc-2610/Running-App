from django.contrib import admin
from activity.models import Group

class GroupAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'privacy', 'event', 
                    'total_distance', 'total_duration', 
                    'number_of_participants', 'rank', 'is_approved')
    list_filter = ('privacy', 'event', 'is_approved')
    search_fields = ['name']
    readonly_fields = ('id', 'total_distance', 'total_duration', 'number_of_participants', 'rank')

