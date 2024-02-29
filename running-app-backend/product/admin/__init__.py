from django.contrib import admin
from .brand import BrandAdmin
from .category import CategoryAdmin
from .product import ProductAdmin

from product.models import Brand, \
                            Category, \
                            Product

admin.site.register(Brand, BrandAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Product, ProductAdmin)