from django.contrib import admin

from product.models import Brand

class BrandAdmin(admin.ModelAdmin):
    list_display = ('name', 'logo')
    search_fields = ('name',)