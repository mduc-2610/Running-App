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

        event_params = {
            "state": format_choice_query_params(
                query_params.get("event_state", "")),
            "name": query_params.get("event_name", ""),   
        }

        club_params = {
            "name": query_params.get("club_name", ""),
            "sport_type": format_choice_query_params(
                query_params.get("club_sport_type", "")),
            "mode": format_choice_query_params(
                query_params.get("club_mode", "")),
            "org_type" : format_choice_query_params(
                query_params.get("club_org_type", "")),
        }
        print(event_params)
        print(club_params)
        
        serializer = self.get_serializer(instance, context={
            "event_params": event_params, 
            "club_params": club_params,
        })
        return response.Response(serializer.data)



    