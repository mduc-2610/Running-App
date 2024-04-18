import uuid
from django.db import models
from django.core.validators import MaxLengthValidator

class PostComment(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.ForeignKey("account.Activity", on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        abstract = True
        ordering = ['-created_at']

    def __str__(self):
        return f'{self.user} - {self.created_at}'

class ClubPostComment(PostComment):
    post = models.ForeignKey('social.ClubPost', on_delete=models.CASCADE, related_name='comments')
    
    def __str__(self):
        return f'{self.user.user.name} - {self.created_at} - Post: {self.post.id}'

class EventPostComment(PostComment):
    post = models.ForeignKey('social.EventPost', on_delete=models.CASCADE, related_name='comments')

    def __str__(self):
        return f'{self.user.user.name} - {self.created_at} - Post: {self.post.id}'

class ActivityRecordPostComment(PostComment):
    # activity_record = models.ForeignKey('activity.ActivityRecord', on_delete=models.CASCADE, related_name='comments')
    post = models.ForeignKey('activity.ActivityRecord', on_delete=models.CASCADE, related_name='comments')
        
    def __str__(self):
        return f'{self.user.user.name} - {self.created_at} - Activity Record: {self.post.id}'