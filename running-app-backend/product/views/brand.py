from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from product.models import Brand

from product.serializers import BrandSerializer

class BrandViewSet(
    viewsets.ModelViewSet
):
    queryset = Brand.objects.all()
    serializer_class = BrandSerializer

    def get_queryset(self):
        queryset = super().get_queryset()
        params = self.request.query_params
        limit = params.get('limit', None)

        if limit:
            queryset = queryset[:int(limit)]
        
        return queryset