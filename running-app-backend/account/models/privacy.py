import uuid
from django.db import models

class Privacy(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.OneToOneField("account.User", related_name="privacy", on_delete=models.CASCADE)
    FOLLOW_CHOICES = (
        ("APPROVAL", "Approval"),
        ("NO_APPROVAL", "No Approval"),
    )
    
    follow_privacy = models.CharField(max_length=20, choices=FOLLOW_CHOICES)

    ACTIVITY_CHOICES = (
        ("EVERYONE", "Everyone"),
        ("FOLLOWER", "Follower"),
        ("ONLY ME", "Only me"),
    )
    
    activity_privacy = models.CharField(max_length=20, choices=ACTIVITY_CHOICES)

    def get_username(self):
        return self.user.username
    
    def __str__(self):
        return f"{self.follow_privacy} {self.activity_privacy}"