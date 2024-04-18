from django.contrib import admin

class FollowAdmin(admin.ModelAdmin):
    list_display = ('follower', 'followee', 'created_at')
    list_filter = ('created_at',)
    search_fields = ['follower__username', 'followee__username']
    readonly_fields = ('created_at',)

