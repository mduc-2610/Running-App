from django.contrib import admin

class ClubPostCommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'content', 'created_at', 'post')
    list_filter = ('created_at',)
    search_fields = ['user__username', 'content']
    readonly_fields = ('id', 'created_at')

class EventPostCommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'content', 'created_at', 'post')
    list_filter = ('created_at',)
    search_fields = ['user__username', 'content']
    readonly_fields = ('id', 'created_at')


class ActivityRecordPostCommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'content', 'created_at', 'post')
    list_filter = ('created_at',)
    search_fields = ['user__username', 'content']
    readonly_fields = ('id', 'created_at')

