from rest_framework import viewsets, response, status
from social.models import EventPost, ClubPost
from social.serializers import EventPostSerializer, \
                                ClubPostSerializer, \
                                DetailClubPostSerializer, \
                                DetailEventPostSerializer, \
                                CreateClubPostSerializer, \
                                CreateEventPostSerializer, \
                                UpdateClubPostSerializer, \
                                UpdateEventPostSerializer

from utils.pagination import CommonPagination

class ClubPostViewSet(viewsets.ModelViewSet):
    queryset = ClubPost.objects.all()
    serializer_class = ClubPostSerializer
    pagination_class = CommonPagination
    
    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailClubPostSerializer
        elif self.action == "create":
            return CreateClubPostSerializer
        elif self.action == "update":
            return UpdateClubPostSerializer
        return ClubPostSerializer
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        context.update({
            'request': self.request,
            'user': self.request.user.activity
        })
        return context

    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
    
class EventPostViewSet(viewsets.ModelViewSet):
    queryset = EventPost.objects.all()
    serializer_class = EventPostSerializer
    pagination_class = CommonPagination

    def get_serializer_class(self):
        if self.action == "retrieve":
            return DetailEventPostSerializer
        elif self.action == "create":
            return CreateEventPostSerializer
        elif self.action == "update":
            return UpdateEventPostSerializer
        return EventPostSerializer
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        # if self.action == "retrieve":
        #     query_params = self.request.query_params
        #     context.update({
        #         "page": query_params.get("pg", 1),
        #         "page_size": query_params.get("pg_size", 1)
        #     })
        context.update({
            'request': self.request,
            'user': self.request.user.activity
        })
        return context
        
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
