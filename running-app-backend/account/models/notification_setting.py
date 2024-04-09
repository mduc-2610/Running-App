import uuid
from django.db import models

class NotificationSetting(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.OneToOneField('account.User', related_name="notification_setting", on_delete=models.CASCADE)
    finished_workout = models.BooleanField(default=True)
    comment = models.BooleanField(default=True)
    like = models.BooleanField(default=True)
    mentions_on_activities = models.BooleanField(default=True)
    respond_to_comments = models.BooleanField(default=True)
    new_follower = models.BooleanField(default=True)
    following_activity = models.BooleanField(default=True)
    request_to_follow = models.BooleanField(default=True)
    approved_follow_request = models.BooleanField(default=True)
    pending_join_requests = models.BooleanField(default=True)
    invited_to_club = models.BooleanField(default=True)
