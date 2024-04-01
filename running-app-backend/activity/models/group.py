import uuid
from django.db import models
from django.core.validators import MaxLengthValidator

class Group(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    name = models.CharField(max_length=100, db_index=True)
    description = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(255, 'The field can contain at most 200 characters')]
    )
    avatar = models.ImageField(upload_to="", default="", null=True)
    banner = models.ImageField(upload_to="", default="", null=True)
    PRIVACY_CHOICES = (
        ("PUBLIC", "Public"),
        ("PRIVATE", "Private"),
    )
    privacy = models.CharField(max_length=15, choices=PRIVACY_CHOICES, default="PUBLIC")
    event = models.ForeignKey(
        "activity.Event", related_name="groups", on_delete=models.CASCADE)
    users = models.ManyToManyField(
        "account.Activity", through="activity.UserParticipationGroup", blank=True)
    
    def total_distance(self):
        return 0
    
    def total_duration(self):
        return ""
    
    def number_of_participants(self):
        return self.users.count()
    
    def rank(self):
        return 0
    
    def __str__(self):
        return self.name

