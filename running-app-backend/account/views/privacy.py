from rest_framework import viewsets, \
                            mixins, \
                            response, \
                            status

from account.models import Privacy
from account.serializers import PrivacySerializer, \
                                CreatePrivacySerializer 

class PrivacyViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    queryset = Privacy.objects.all()
    serializer_class = PrivacySerializer

    def get_serializer_class(self):
        if self.action == "create":
            return CreatePrivacySerializer
        return super().get_serializer_class()
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
    
    # def create(self, request, *args, **kwargs):
    #     serializer = self.get_serializer(data=request.data)
    #     serializer.is_valid(raise_exception=True)
    #     serializer.save()
        
    #     return response.Response(serializer.data, status=status.HTTP_200_OK)
        