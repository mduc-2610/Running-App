from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from rest_framework.pagination import PageNumberPagination
from rest_framework.decorators import action
from activity.models import ActivityRecord
from activity.serializers import ActivityRecordSerializer, \
                            DetailActivityRecordSerializer, \
                            CreateActivityRecordSerializer, \
                            UpdateActivityRecordSerializer

class ActivityRecordPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 1000

class ActivityRecordViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
    # viewsets.ModelViewSet
):
    queryset = ActivityRecord.objects.all()
    serializer_class = ActivityRecordSerializer
    pagination_class = ActivityRecordPagination

    def get_serializer_class(self):
        if self.action == "create":
            return CreateActivityRecordSerializer
        elif self.action == "retrieve" or self.action == "feed":
            return DetailActivityRecordSerializer
        elif self.action == "update":
            return UpdateActivityRecordSerializer
        return super().get_serializer_class()
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "feed":
            exclude = [param.strip().lower() for param in self.request.query_params.get('exclude', "").split(',')]
            context.update({
                'exclude': exclude
            })
        return context
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
    
    
    @action(detail=False, methods=['get'], url_path='feed', name='feed')
    def feed(self, request):
        queryset = self.filter_queryset(self.get_queryset())
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return response.Response(serializer.data, status=status.HTTP_200_OK)