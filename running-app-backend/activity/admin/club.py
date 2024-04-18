from django.contrib import admin
from activity.models import Club

class ClubAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'sport_type', 'organization', 'privacy', 'description', 'number_of_participants', 'week_activities')
    list_filter = ('sport_type', 'organization', 'privacy')
    search_fields = ['name']
    readonly_fields = ('id', 'number_of_participants', 'week_activities')

