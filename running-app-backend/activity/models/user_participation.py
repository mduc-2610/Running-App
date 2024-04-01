import datetime
from datetime import timedelta

from django.db import models
from django.db.models import Sum

class UserParticipation(models.Model):
    user = models.ForeignKey(
        "account.Activity", on_delete=models.CASCADE, null=True)
    is_superadmin = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)
    is_approved = models.BooleanField(default=True)
    participated_at = models.DateTimeField(auto_now_add=True)

    def week_stats(self, col):
        return self.user.performance.week_stats(col)
    
    def month_stats(self, col):
        return self.user.performance.month_stats(col)

    def year_stats(self, col):
        return self.user.performance.year_stats(col)
    
    class Meta:
        abstract = True

class UserParticipationClub(UserParticipation):
    club = models.ForeignKey(
        "activity.Club", on_delete=models.CASCADE)
    
class UserParticipationEvent(UserParticipation):
    event = models.ForeignKey(
        "activity.Event", on_delete=models.CASCADE)
    
class UserParticipationGroup(UserParticipation):
    group = models.ForeignKey(
        "activity.Group", on_delete=models.CASCADE)
