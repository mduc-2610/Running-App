import uuid
from django.db import models

class Category(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name