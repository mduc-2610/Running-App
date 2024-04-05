import uuid

from django.utils import timezone
from django.db import models

class Profile(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.OneToOneField(
        "account.User", related_name="profile", on_delete=models.CASCADE)
    avatar = models.ImageField(upload_to="", default="", null=True)
    updated_at = models.DateTimeField(auto_now=True)
    country = models.CharField(max_length=150, null=True, blank=True, db_index=True)
    city = models.CharField(max_length=150, null=True, blank=True, db_index=True)
    GENDER_CHOICES = [
        ("MALE", "male"),
        ("FEMALE", "female"),
    ]
    gender = models.CharField(max_length=10, choices=GENDER_CHOICES)
    date_of_birth = models.DateField()
    height = models.IntegerField()
    weight = models.IntegerField()
    SIZE_CHOICES = [
        ("XS", "extra small"),
        ("S", "small"),
        ("M", "medium"),
        ("L", "large"),
        ("XL", "extra large"),
        ("XXL", "extra extra large"),
    ]
    shirt_size = models.CharField(max_length=10, choices=SIZE_CHOICES)
    trouser_size = models.CharField(max_length=10, choices=SIZE_CHOICES)
    shoe_size = models.IntegerField()

    
    def name(self):
        return self.user.name
    
    def __str__(self):
        return f"{self.name()} {self.gender}"