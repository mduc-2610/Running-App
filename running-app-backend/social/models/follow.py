from django.db import models

class Follow(models.Model):
    follower = models.ForeignKey("account.Activity", on_delete=models.CASCADE, related_name='following')
    followee = models.ForeignKey("account.Activity", on_delete=models.CASCADE, related_name='followers')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ['follower', 'followee']

    def __str__(self):
        return f'{self.follower} follows {self.followee}'


