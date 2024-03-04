from rest_framework import generics, \
                            viewsets

# from activity.models import Event, \
#                             Club
# from product.models import Product

# from activity.serializers import EventSerializer, \
#                                 ClubSerializer
# from product.serializers import ProductSerializer


from account.models import Activity
from account.serializers import ActivitySerializer

class ActivityViewSet(
    viewsets.ModelViewSet
):
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer