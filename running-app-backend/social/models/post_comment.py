import uuid
from django.db import models
from django.core.validators import MaxLengthValidator
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver

class PostComment(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.ForeignKey("account.Activity", on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        abstract = True
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.user} - {self.created_at}"

class ClubPostComment(PostComment):
    post = models.ForeignKey(
        "social.ClubPost", on_delete=models.CASCADE, related_name="comments")
    
    def __str__(self):
        return f"{self.user.user.name} - {self.created_at} - Post: {self.post.id}"

class EventPostComment(PostComment):
    post = models.ForeignKey(
        "social.EventPost", on_delete=models.CASCADE, related_name="comments")

    def __str__(self):
        return f"{self.user.user.name} - {self.created_at} - Post: {self.post.id}"

class ActivityRecordPostComment(PostComment):
    # activity_record = models.ForeignKey(
    #     "activity.ActivityRecord", on_delete=models.CASCADE, related_name="comments")
    post = models.ForeignKey(
        "activity.ActivityRecord", on_delete=models.CASCADE, related_name="comments")
        
    def __str__(self):
        return f"{self.user.user.name} - {self.created_at} - Activity Record: {self.post.id}"

@receiver(post_save, sender=ClubPostComment)
def update_club_post_comments(sender, instance, created, **kwargs):
    if created:
        post = instance.post
        post.total_comments += 1
        post.save()

@receiver(post_save, sender=EventPostComment)
def update_event_post_comments(sender, instance, created, **kwargs):
    if created:
        post = instance.post
        post.total_comments += 1
        post.save()

@receiver(post_save, sender=ActivityRecordPostComment)
def update_activity_record_post_comments(sender, instance, created, **kwargs):
    if created:
        post = instance.post
        post.total_comments += 1
        post.save()

@receiver(post_delete, sender=ClubPostComment)
def delete_club_post_comments(sender, instance, **kwargs):
    post = instance.post
    post.total_comments -= 1
    post.save()

@receiver(post_delete, sender=EventPostComment)
def delete_event_post_comments(sender, instance, **kwargs):
    post = instance.post
    post.total_comments -= 1
    post.save()

@receiver(post_delete, sender=ActivityRecordPostComment)
def delete_activity_record_post_comments(sender, instance, **kwargs):
    post = instance.post
    post.total_comments -= 1
    post.save()