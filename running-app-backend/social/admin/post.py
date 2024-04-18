from django.contrib import admin
from social.models import EventPostImage,\
                        ClubPostImage

class EventPostImageInline(admin.TabularInline):
    model = EventPostImage
    extra = 1

class ClubPostImageInline(admin.TabularInline):
    model = ClubPostImage
    extra = 1

class EventPostAdmin(admin.ModelAdmin):
    inlines = [EventPostImageInline]
    list_display = ('id', 'title', 'event', 
                    'user', 'created_at', 'total_comments')
    list_filter = ('created_at', 'event', 'user')
    search_fields = ['title', 'content']
    readonly_fields = ('id', 'created_at', 'total_comments')

class ClubPostAdmin(admin.ModelAdmin):
    inlines = [ClubPostImageInline]
    list_display = ('id', 'title', 'club', 
                    'user', 'created_at', 'total_comments')
    list_filter = ('created_at', 'club', 'user')
    search_fields = ['title', 'content']
    readonly_fields = ('id', 'created_at', 'total_comments')

