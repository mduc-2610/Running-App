from django.contrib import admin
from account.models import NotificationSetting

class NotificationSettingAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'finished_workout', 'comment', 'like', 'mentions_on_activities',
                    'respond_to_comments', 'new_follower', 'following_activity', 'request_to_follow',
                    'approved_follow_request', 'pending_join_requests', 'invited_to_club')
    list_filter = ('finished_workout', 'comment', 'like', 'mentions_on_activities',
                   'respond_to_comments', 'new_follower', 'following_activity', 'request_to_follow',
                   'approved_follow_request', 'pending_join_requests', 'invited_to_club')
    search_fields = ['user__username']

