import uuid
from django.db import models

class PostLike(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        abstract = True
        ordering = ['-created_at']
        
    def __str__(self):
        return f""

class EventPostLike(PostLike):
    RELATED_NAME = "event_post_likes"
    post = models.ForeignKey(
        "social.EventPost", related_name=RELATED_NAME, on_delete=models.CASCADE)
    user = models.ForeignKey(
        "account.Activity", related_name=RELATED_NAME, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.post} {self.user}"

class ClubPostLike(PostLike):
    RELATED_NAME = "club_post_likes"
    post = models.ForeignKey(
        "social.ClubPost", related_name=RELATED_NAME, on_delete=models.CASCADE)
    user = models.ForeignKey(
        "account.Activity", related_name=RELATED_NAME, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.post} - {self.user}"

class ActivityRecordPostLike(PostLike):
    RELATED_NAME = "act_rec_post_likes"
    post = models.ForeignKey(
        "activity.ActivityRecord", related_name=RELATED_NAME, on_delete=models.CASCADE)
    user = models.ForeignKey(
        "account.Activity", related_name=RELATED_NAME, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.post} - {self.user}"
