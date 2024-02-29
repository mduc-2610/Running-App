from django.contrib import admin

class ClubAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'sport_type', 'week_activities', 'number_of_participants')
    list_filter = ('sport_type', 'organization')
    search_fields = ('id', 'name')
        
