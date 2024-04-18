from rest_framework import viewsets
from social.models import EventPost, ClubPost
from social.serializers import EventPostSerializer, \
                                ClubPostSerializer, \
                                DetailClubPostSerializer, \
                                DetailEventPostSerializer
from utils.pagination import CommonPagination

class EventPostViewSet(viewsets.ModelViewSet):
    queryset = EventPost.objects.all()
    serializer_class = EventPostSerializer
    pagination_class = CommonPagination

    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailEventPostSerializer
        return EventPostSerializer
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        # if self.action == "retrieve":
        #     query_params = self.request.query_params
        #     context.update({
        #         "page": query_params.get("pg", 1),
        #         "page_size": query_params.get("pg_size", 1)
        #     })
        return context
        
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
        
class ClubPostViewSet(viewsets.ModelViewSet):
    queryset = ClubPost.objects.all()
    serializer_class = ClubPostSerializer
    pagination_class = CommonPagination
    
    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailClubPostSerializer
        return ClubPostSerializer
