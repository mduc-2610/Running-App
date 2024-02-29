from django.db import models

class UserActivity(models.Model):
    user = models.OneToOneField(
        "account.User", related_name="user_activity", on_delete=models.CASCADE)
    clubs = models.ManyToManyField(
        "activity.Club", through="activity.UserParticipationClub", blank=True)
    events = models.ManyToManyField(
        "activity.Event", through="activity.UserParticipationEvent", blank=True)
    
    def __str__(self):
        return self.user.profile.full_name()