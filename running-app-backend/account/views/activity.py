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

from utils.function import format_choice_query_params

class ActivityViewSet(
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        query_params = request.query_params
        state = query_params.get("state", None)
        club_params = {
            "club_name": format_choice_query_params(
                query_params.get("club_name", "")),
            "club_sport_type": format_choice_query_params(
                query_params.get("club_sport_type", "")),
            "club_mode": format_choice_query_params(
                query_params.get("club_mode", "")),
            "club_org_type" : format_choice_query_params(
                query_params.get("club_org_type", "")),
        }
        print(club_params)
        
        serializer = self.get_serializer(instance, context={
            "state": state, 
            "club_params": club_params,
        })
        return response.Response(serializer.data)



    