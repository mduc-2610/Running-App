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
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    queryset = Performance.objects.all()
    serializer_class = PerformanceSerializer

    def get_serializer_class(self):
        if self.action == "create":
            return CreatePerformanceSerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
    
    def create(self, request, *args, **kwargs):
        serializer_ = self.get_serializer(data=request.data)
        serializer_.is_valid(raise_exception=True)
        serializer_.save()
        
        return response.Response(serializer_.data, status=status.HTTP_200_OK)
    