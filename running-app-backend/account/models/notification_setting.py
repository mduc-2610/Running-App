import uuid
from django.db import models

class NotificationSetting(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.OneToOneField('account.User', related_name="notification_setting", on_delete=models.CASCADE)
    finished_workout = models.BooleanField(default=False)
    comment = models.BooleanField(default=False)
    like = models.BooleanField(default=False)
    mentions_on_activities = models.BooleanField(default=False)
    respond_to_comments = models.BooleanField(default=False)
    new_follower = models.BooleanField(default=False)
    following_activity = models.BooleanField(default=False)
    request_to_follow = models.BooleanField(default=False)
    approved_follow_request = models.BooleanField(default=False)
    pending_join_requests = models.BooleanField(default=False)
    invited_to_club = models.BooleanField(default=False)
