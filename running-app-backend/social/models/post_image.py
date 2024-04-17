import uuid
from django.db import models

class PostImage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    image = models.ImageField(upload_to='post_images/', null=True)

    class Meta:
        abstract = True

class EventPostImage(PostImage):
    post = models.ForeignKey("activity.Event", related_name='images', on_delete=models.CASCADE)

class ClubPostImage(PostImage):
    post = models.ForeignKey("activity.Club", related_name='images', on_delete=models.CASCADE)