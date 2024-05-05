import datetime, uuid
from datetime import timedelta

from django.db import models
from django.db.models import Sum
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver

class UserParticipation(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.ForeignKey(
        "account.Activity", on_delete=models.CASCADE, null=True)
    is_superadmin = models.BooleanField(default=False,)
    is_admin = models.BooleanField(default=False, null=True)
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
    
    class Meta:
        unique_together = ("user", "club")
    
class UserParticipationEvent(UserParticipation):
    event = models.ForeignKey(
        "activity.Event", on_delete=models.CASCADE)
    
    class Meta:
        unique_together = ("user", "event")

class UserParticipationGroup(UserParticipation):
    group = models.ForeignKey(
        "activity.Group", on_delete=models.CASCADE)

    class Meta:
        unique_together = ("user", "group")

@receiver(post_save, sender=UserParticipationClub)
def update_club_participant(sender, instance, created, **kwargs):
    if created:
        club = instance.club
        club.total_participants += 1
        club.save()

@receiver(post_delete, sender=UserParticipationClub)
def delete_club_participant(sender, instance, **kwargs):
    club = instance.club
    club.total_participants -= 1
    club.save()

@receiver(post_save, sender=UserParticipationClub)
def update_club_activity_record(sender, instance, created, **kwargs):
    if created:
        user = instance.user
        club = instance.club
        club.total_activity_records += user.total_activity_records
        club.save()

@receiver(post_delete, sender=UserParticipationClub)
def delete_club_activity_record(sender, instance, **kwargs):
    user = instance.user
    club = instance.club
    club.total_activity_records -= user.total_activity_records
    club.save()

@receiver(post_save, sender=UserParticipationEvent)
def update_event_participant(sender, instance, created, **kwargs):
    if created:
        event = instance.event
        event.total_participants += 1
        event.save()

@receiver(post_delete, sender=UserParticipationEvent)
def delete_event_participant(sender, instance, **kwargs):
    event = instance.event
    event.total_participants -= 1
    event.save()

@receiver(post_save, sender=UserParticipationGroup)
def update_group_participant(sender, instance, created, **kwargs):
    if created:
        group = instance.group
        group.total_participants += 1
        group.save()

@receiver(post_delete, sender=UserParticipationGroup)
def delete_group_participant(sender, instance, **kwargs):
    group = instance.group
    group.total_participants -= 1
    group.save()