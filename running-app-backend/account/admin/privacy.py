from django.contrib import admin

from account.models import Privacy

class PrivacyAdmin(admin.ModelAdmin):
    list_display = ("get_username", "follow_privacy", "activity_privacy")
    list_filter = ("follow_privacy", "activity_privacy")
    search_fields = ("follow_privacy", "activity_privacy")