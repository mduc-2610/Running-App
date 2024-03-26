import uuid
from django.db import models

class Activity(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.OneToOneField(
        "account.User", related_name="activity", on_delete=models.CASCADE)
    clubs = models.ManyToManyField(
        "activity.Club", through="activity.UserParticipationClub", related_name="clubs", blank=True)
    events = models.ManyToManyField(
        "activity.Event", through="activity.UserParticipationEvent", related_name="events", blank=True)
    products = models.ManyToManyField(
        "product.Product", through="product.UserProduct", related_name="products", blank=True)
    
    def __str__(self):
        return f"{self.user}"