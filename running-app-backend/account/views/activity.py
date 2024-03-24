from rest_framework import generics, \
                            viewsets, \
                            permissions, \
                            mixins, \
                            response

# from activity.models import Event, \
#                             Club
# from product.models import Product

# from activity.serializers import EventSerializer, \
#                                 ClubSerializer
# from product.serializers import ProductSerializer


from account.models import Activity
from account.serializers import ActivitySerializer

class ActivityViewSet(
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        state = request.query_params.get('state', None)
        serializer = self.get_serializer(instance, context={'state': state})
        return response.Response(serializer.data)



    