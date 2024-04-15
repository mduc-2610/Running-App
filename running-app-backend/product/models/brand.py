import uuid
from django.db import models

class Brand(models.Model):
    class Meta:
        ordering = ('name',)    
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    name = models.CharField(max_length=100)
    logo = models.ImageField(upload_to="brand/%Y/%m/%d")

    def __str__(self):
        return self.name