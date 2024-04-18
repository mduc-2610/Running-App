import uuid
from django.db import models

class Post(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    title = models.CharField(max_length=100)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    # likes = models.ManyToManyField("account.activity")

    def total_comments(self):
        return self.comments.count()
    
    def total_likes(self):
        return self.likes.count()
    
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
