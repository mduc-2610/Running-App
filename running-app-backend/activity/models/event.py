import uuid

from django.db import models
from django.core.validators import MaxLengthValidator

class Event(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    name = models.CharField(max_length=100, unique=True, db_index=True)
    started_at = models.DateTimeField()
    ended_at = models.DateTimeField()
    regulations = models.JSONField(default=dict, blank=True)
    description = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(1500, 'The field can contain at most 200 characters')]
    )
    contact_information = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(500, 'The field can contain at most 200 characters')]
    )
    banner = models.ImageField(upload_to="", default="")
    SPORT_CHOICES = (
        ("RUNNING", "Running"),
        ("CYCLING", "Cycling"),
        ("SWIMMING", "Swimming"),
    )
    PRIVACY_CHOICES = (
        ("PUBLIC", "Public"),
        ("PRIVATE", "Private"),
    )
    COMPETITION_CHOICES = (
        ("INDIVIDUAL", "Individual"),
        ("GROUP", "Group"),
    )
    sport_type = models.CharField(max_length=15, choices=SPORT_CHOICES, default="RUNNING")
    privacy = models.CharField(max_length=15, choices=PRIVACY_CHOICES, default="PUBLIC")
    competition = models.CharField(max_length=15, choices=COMPETITION_CHOICES, default="INDIVIDUAL")
    
    def days_remain(self):
        return (self.ended_at.date() - self.started_at.date()).days
    
    def number_of_participants(self):
        return self.events.count()
    
    def get_readable_time(self, col):
        return self[col].strftime("%Y-%m-%d %H:%M")
    
    def __getitem__(self, key):
        if hasattr(self, key):
            return getattr(self, key)
        else:
            raise KeyError(f"{key} attribute not found")

    def __str__(self):
        return self.name

