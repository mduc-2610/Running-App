import uuid
import datetime

from django.db import models
from django.core.validators import MaxLengthValidator

class Club(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    name = models.CharField(max_length=150)
    avatar = models.ImageField(upload_to="", default="")
    cover_photo = models.ImageField(upload_to="", default="")
    SPORT_CHOICES = (
        ("RUNNING", "Running"),
        ("CYCLING", "Cycling"),
        ("SWIMMING", "Swimming"),
    )
    sport_type = models.CharField(max_length=15, choices=SPORT_CHOICES)
    description = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(255, 'The field can contain at most 200 characters')]
    )
    participate_freely = models.BooleanField(default=True)
    ORGANIZATION_CHOICES = (
        ("SPORT_CLUB", "Sport Club"),
        ("BUSINESS", "Business"),
        ("SCHOOL", "School")
    )
    organization = models.CharField(max_length=15, choices=ORGANIZATION_CHOICES, default="")
    
    def week_activities(self):
        # last_week = datetime.datetime.now() - datetime.timedelta(days=7)
        return 0

    def number_of_participants(self):
        return 0
    
    def __str__(self):
        return self.name