import uuid
from django.db import models

class PostImage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    image = models.ImageField(upload_to='post_images/', null=True)

    class Meta:
        abstract = True

class EventPostImage(PostImage):
    post = models.ForeignKey(
        "social.EventPost", related_name='images', on_delete=models.CASCADE, null=True)

class ClubPostImage(PostImage):
    post = models.ForeignKey(
        "social.ClubPost", related_name='images', on_delete=models.CASCADE, null=True)