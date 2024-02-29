from django.contrib import admin

class ActivityRecordAdmin(admin.ModelAdmin):
    list_display = ('id', 'distance', 'duration', 'completed_at', 'sport_type', 'user')
    list_filter = ('sport_type', 'user')
    search_fields = ('id', 'user__username')
