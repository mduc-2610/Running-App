import uuid
from django.db import models
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver

class PostLike(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
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

# @receiver(post_save, sender=PostLike)
# def update_post_total_likes(sender, instance, created, **kwargs):
#     if created:
#         post = instance.post
#         post.total_likes += 1
#         post.save()

@receiver(post_save, sender=ClubPostLike)
def update_club_post_likes(sender, instance, created, **kwargs):
    if created:
        post = instance.post
        post.total_likes += 1
        post.save()

@receiver(post_save, sender=EventPostLike)
def update_event_post_likes(sender, instance, created, **kwargs):
    if created:
        post = instance.post
        post.total_likes += 1
        post.save()

@receiver(post_save, sender=ActivityRecordPostLike)
def update_activity_record_post_likes(sender, instance, created, **kwargs):
    if created:
        post = instance.post
        post.total_likes += 1
        post.save()

@receiver(post_delete, sender=ClubPostLike)
def update_club_post_likes_on_delete(sender, instance, **kwargs):
    post = instance.post
    post.total_likes -= 1
    post.save()

@receiver(post_delete, sender=EventPostLike)
def update_event_post_likes_on_delete(sender, instance, **kwargs):
    post = instance.post
    post.total_likes -= 1
    post.save()

@receiver(post_delete, sender=ActivityRecordPostLike)
def update_activity_record_post_likes_on_delete(sender, instance, **kwargs):
    post = instance.post
    post.total_likes -= 1
    post.save()