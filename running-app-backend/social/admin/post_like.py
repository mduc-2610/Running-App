from django.contrib import admin
from social.models import EventPostLike, \
                        ClubPostLike,\
                        ActivityRecordPostLike

class EventPostLikeAdmin(admin.ModelAdmin):
    list_display = ['post', 'user', 'created_at']
    search_fields = ['post__title', 'user__username']
    list_filter = ['created_at']

class ClubPostLikeAdmin(admin.ModelAdmin):
    list_display = ['post', 'user', 'created_at']
    search_fields = ['post__title', 'user__username']
    list_filter = ['created_at']

class ActivityRecordPostLikeAdmin(admin.ModelAdmin):
    list_display = ['post', 'user', 'created_at']
    search_fields = ['post__title', 'user__username']
    list_filter = ['created_at']
