from django.contrib import admin
from product.models import Product, ProductImage

class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'brand', 'category', 'price', 'uploaded_at', 'updated_at')
    list_filter = ('brand', 'category')
    search_fields = ('name', 'brand__name', 'category__name')
    readonly_fields = ('uploaded_at', 'updated_at')

class ProductImageAdmin(admin.ModelAdmin):
    list_display = ('product', 'image')
    list_filter = ('product',)
    search_fields = ('product__name',)