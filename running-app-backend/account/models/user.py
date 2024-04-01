import uuid
from django.db import models
from django.contrib.auth.models import AbstractUser, UnicodeUsernameValidator
from rest_framework.authtoken.models import Token

class User(AbstractUser):
    id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
    name = models.CharField(max_length=150, default="", null=True)
    email = models.EmailField(unique=True)
    is_verified_email = models.BooleanField(default=False, db_index=True)
    username_validator = UnicodeUsernameValidator()
    username = models.CharField(
        max_length=150, 
        unique=True,
        blank=True, 
        null=True, 
        validators=[username_validator],
        db_index=True)
    phone_number = models.CharField(
        max_length=16,
        default=None,
        unique=True,
        null=True,
        blank=True,
        db_index=True
    )
    is_verified_phone = models.BooleanField(default=False, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return self.username
    