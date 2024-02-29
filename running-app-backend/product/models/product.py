import uuid

from django.db import models 
from django.core.validators import MaxLengthValidator

class Product(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    name = models.CharField(max_length=100)
    brand = models.ForeignKey(
        "product.Brand", related_name="brand", on_delete=models.CASCADE)
    category = models.ForeignKey(
        "product.Category", related_name="category", on_delete=models.CASCADE)
    price = models.IntegerField()
    description = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(255, 'The field can contain at most 200 characters')]
    )
    uploaded_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.name} {self.brand} {self.category}"
    
class ProductImage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    product = models.ForeignKey("product.Product", related_name="product_image", on_delete=models.CASCADE)
    image = models.ImageField(upload_to="", default="")
    
    def __str__(self):
        return f"{self.product.name} {self.image}"