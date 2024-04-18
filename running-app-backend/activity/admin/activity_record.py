from django.contrib import admin
from activity.models import ActivityRecord, ActivityRecordImage

class ActivityRecordImageInline(admin.TabularInline):
    model = ActivityRecordImage
    extra = 1

class ActivityRecordAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'distance', 'duration', 'avg_heart_rate', 'completed_at', 'sport_type')
    list_filter = ('completed_at', 'sport_type')
    search_fields = ['user__username', 'title']
    readonly_fields = ('id', 'avg_moving_pace_readable', 'avg_cadence', 'points', 'steps', 'kcal', 'get_readable_date_time')

    inlines = [ActivityRecordImageInline]

class ActivityRecordImageAdmin(admin.ModelAdmin):
    list_display = ('id', 'activity_record', 'image')


