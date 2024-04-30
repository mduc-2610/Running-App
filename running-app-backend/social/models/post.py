import uuid
from django.db import models
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver


class Post(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    title = models.CharField(max_length=100)
    content = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    total_likes = models.IntegerField(default=0, null=True)
    total_comments = models.IntegerField(default=0, null=True)
    # likes = models.ManyToManyField("account.activity")
    
    class Meta:
        abstract = True
        ordering = ['-created_at']
        
    def __str__(self):
        return f"{self.title}"

class ClubPost(Post):
    RELATED_NAME = "club_posts"
    club = models.ForeignKey(
        "activity.Club", related_name=RELATED_NAME, on_delete=models.CASCADE)
    user = models.ForeignKey(
        "account.Activity", related_name=RELATED_NAME, on_delete=models.CASCADE)
    likes = models.ManyToManyField(
        "account.Activity", blank=True, through="social.ClubPostLike")
    
    def __str__(self):
        return f"{self.title}"

class EventPost(Post):
    RELATED_NAME = "event_posts"
    event = models.ForeignKey(
        "activity.Event", related_name=RELATED_NAME, on_delete=models.CASCADE)
    user = models.ForeignKey(
        "account.Activity", related_name=RELATED_NAME, on_delete=models.CASCADE)
    likes = models.ManyToManyField(
        "account.Activity", blank=True, through="social.EventPostLike")


    def __str__(self):
        return f"{self.title}"


@receiver(post_save, sender=ClubPost)
def update_club_post(sender, instance, created, **kwargs):
    if created:
        club = instance.club
        club.total_posts += 1
        club.save()

@receiver(post_delete, sender=ClubPost)
def delete_club_post(sender, instance, **kwargs):
    club = instance.club
    club.total_posts -= 1
    club.save()

@receiver(post_save, sender=EventPost)
def update_event_post(sender, instance, created, **kwargs):
    if created:
        event = instance.event
        event.total_posts += 1
        event.save()

@receiver(post_delete, sender=EventPost)
def delete_event_post(sender, instance, **kwargs):
    event = instance.event
    event.total_posts -= 1
    event.save()