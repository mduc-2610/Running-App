from django.contrib import admin
from django.contrib.admin.helpers import ActionForm
from django import forms

from account.models import Profile
from utils.decorators import action_form

class ProfileAdmin(admin.ModelAdmin):
    list_display = (
        "full_name", "gender", "country", 
        "city", "date_of_birth", "height", 
        "weight", "shirt_size", "trouser_size", 
        "shoe_size", "updated_at"
    )
    list_filter = (
        "gender", "country", 
        "city", "date_of_birth", "height", 
        "weight", "shirt_size", "trouser_size", 
        "shoe_size", "updated_at"
    )
    search_fields = (
        "gender", "country", 
        "city", "date_of_birth", "height", 
        "weight", "shirt_size", "trouser_size", 
        "shoe_size", "updated_at"
    )
    odering = ("shoe_size",)
