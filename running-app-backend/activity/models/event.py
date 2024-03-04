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
        validators=[MaxLengthValidator(255, 'The field can contain at most 200 characters')]
    )
    contact_information = models.CharField(max_length=16, blank=True, null=True)
    banner = models.ImageField(upload_to="", default="")
    SPORT_CHOICES = (
        ("RUNNING", "Running"),
        ("CYCLING", "Cycling"),
        ("SWIMMING", "Swimming"),
    )
    sport_type = models.CharField(max_length=15, choices=SPORT_CHOICES, default="RUNNING")
    is_group = models.BooleanField(default=False)
    
    def days_remain(self):
        return (self.ended_at.date() - self.started_at.date()).days
    
    def number_of_participants(self):
        return self.events.count()
    
    def __str__(self):
        return self.name

