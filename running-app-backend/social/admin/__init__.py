from django.contrib import admin
from social.models import Follow, EventPost, ClubPost, \
                        EventPostLike, ClubPostLike, ActivityRecordPostLike, \
                        EventPostImage, ClubPostImage, \
                        ClubPostComment, EventPostComment, ActivityRecordPostComment

from .follow import  FollowAdmin 
from .post import EventPostAdmin, \
                ClubPostAdmin
from .post_like import EventPostLikeAdmin, \
                    ClubPostLikeAdmin, \
                    ActivityRecordPostLikeAdmin
from .post_image import EventPostImageAdmin, \
                        ClubPostImageAdmin
from .post_comment import ClubPostCommentAdmin, \
                        EventPostCommentAdmin, \
                        ActivityRecordPostCommentAdmin

admin.site.register(Follow, FollowAdmin)
admin.site.register(EventPost, EventPostAdmin)
admin.site.register(ClubPost, ClubPostAdmin)
admin.site.register(EventPostLike, EventPostLikeAdmin)
admin.site.register(ClubPostLike, ClubPostLikeAdmin)
admin.site.register(ActivityRecordPostLike, ActivityRecordPostLikeAdmin)
admin.site.register(EventPostImage, EventPostImageAdmin)
admin.site.register(ClubPostImage, ClubPostImageAdmin)
admin.site.register(ClubPostComment, ClubPostCommentAdmin)
admin.site.register(EventPostComment, EventPostCommentAdmin)
admin.site.register(ActivityRecordPostComment, ActivityRecordPostCommentAdmin)
