from rest_framework import viewsets, \
                            mixins, \
                            response, \
                            status

from account.models import Performance
from account.serializers import PerformanceSerializer, \
                                CreatePerformanceSerializer 

class PerformanceViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    queryset = Performance.objects.all()
    serializer_class = PerformanceSerializer

    def get_serializer_class(self):
        if self.action == "create":
            return CreatePerformanceSerializer
        return super().get_serializer_class()
    
    # def get_serializer(self, *args, **kwargs):
    #     serializer_class = self.get_serializer_class()
    #     kwargs["context"] = self.get_serializer_context()
    #     return serializer_class(*args, **kwargs)
    
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        start_date = self.request.query_params.get('start_date', None)
        end_date = self.request.query_params.get('end_date', None)
        period = self.request.query_params.get('period', None)
        
        serializer = self.get_serializer(
            instance, 
            context={
                'start_date': start_date, 
                'end_date': end_date,
                'period': period
            }
        )

        return response.Response(serializer.data, status=status.HTTP_200_OK)
    
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        
        return response.Response(serializer.data, status=status.HTTP_200_OK)
    