import uuid
from django.db import models

class Post(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    title = models.CharField(max_length=100)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    def total_comments(self):
        return self.comments.count()
    
    class Meta:
        abstract = True
        ordering = ['-created_at']
        
    def __str__(self):
        return self.title

class EventPost(Post):
    event = models.ForeignKey("activity.Event", related_name="event_posts", on_delete=models.CASCADE)
    user = models.ForeignKey("account.Activity", related_name="event_posts", on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.title}"

class ClubPost(Post):
    club = models.ForeignKey("activity.Club", related_name="club_posts", on_delete=models.CASCADE)
    user = models.ForeignKey("account.Activity", related_name="club_posts", on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.title} - Club:"
