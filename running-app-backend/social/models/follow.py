import uuid
from django.db import models
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver


class Follow(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    follower = models.ForeignKey("account.Activity", on_delete=models.CASCADE, related_name='following')
    followee = models.ForeignKey("account.Activity", on_delete=models.CASCADE, related_name='followers')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('follower', 'followee')
        ordering = ('-created_at',)

    def __str__(self):
        return f'{self.follower} follows {self.followee}'
    
@receiver(post_save, sender=Follow)
def update_follow(sender, instance, created, **kwargs):
    if created:
        follower = instance.follower
        followee = instance.followee
        follower.total_followees += 1
        followee.total_followers += 1
        follower.save()

@receiver(post_delete, sender=Follow)
def delete_follow(sender, instance, **kwargs):
    follower = instance.follower
    followee = instance.followee
    follower.total_followees -= 1
    followee.total_followers -= 1
    follower.save()
        



