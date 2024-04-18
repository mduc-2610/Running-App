from django.contrib import admin

class EventPostImageAdmin(admin.ModelAdmin):
    list_display = ('id', 'post', 'image')
    list_filter = ('post',)
    search_fields = ['post__title']
    readonly_fields = ('id',)

class ClubPostImageAdmin(admin.ModelAdmin):
    list_display = ('id', 'post', 'image')
    list_filter = ('post',)
    search_fields = ['post__title']
    readonly_fields = ('id',)
