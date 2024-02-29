from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/account/", include("account.urls")),
    path("api/activity/", include("activity.urls")),
    path("api/product/", include("product.urls")),
]
