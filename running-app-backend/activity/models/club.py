import uuid
import datetime

from django.db import models
from django.core.validators import MaxLengthValidator
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver

class Club(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    name = models.CharField(max_length=150)
    avatar = models.ImageField(upload_to="", default="", null=True)
    cover_photo = models.ImageField(upload_to="", default="", null=True)
    SPORT_CHOICES = (
        ("RUNNING", "Running"),
        ("CYCLING", "Cycling"),
        ("SWIMMING", "Swimming"),
    )
    ORGANIZATION_CHOICES = (
        ("SPORT_CLUB", "Sport Club"),
        ("COMPANY", "Company"),
        ("SCHOOL", "School")
    )
    PRIVACY_CHOICES = (
        ("PUBLIC", "Public"),
        ("PRIVATE", "Private"),
    )
    
    sport_type = models.CharField(max_length=15, choices=SPORT_CHOICES)
    organization = models.CharField(max_length=15, choices=ORGANIZATION_CHOICES, default="")
    privacy = models.CharField(max_length=15, choices=PRIVACY_CHOICES, default="PUBLIC")

    description = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(255, 'The field can contain at most 200 characters')]
    )
    total_posts = models.IntegerField(default=0, null=True)
    total_participants = models.IntegerField(default=0, null=True)

    def week_activities(self):
        # last_week = datetime.datetime.now() - datetime.timedelta(days=7)
        return 0
    
    def __str__(self):
        return self.name
    