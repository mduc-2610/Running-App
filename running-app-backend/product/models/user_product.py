import uuid
from django.db import models

class UserProduct(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.ForeignKey(
        "account.Activity", on_delete=models.CASCADE, null=True, blank=True)
    product = models.ForeignKey(
        "product.Product", on_delete=models.CASCADE)
    owned_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    # def __str__(self):
    #     return f"{self.user}"