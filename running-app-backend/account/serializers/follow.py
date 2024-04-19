# from rest_framework import serializers
# from social.models import Follow

# class LikeSerializer(serializers.ModelSerializer):
#     id = serializers.SerializerMethodField()
#     name = serializers.SerializerMethodField()

#     def get_id(self, instance):
#         return instance.user.id
    
#     def get_name(self, instance):
#         return instance.user.name
#     class Meta:
#         model = Follow
#         fields = (
#             "id",
#             "name"
#         )
#         extra_kwargs = {
#             "id": {"read_only" : True}
#         }
