from rest_framework import generics, \
                            viewsets, \
                            permissions, \
                            mixins, \
                            response
from rest_framework.exceptions import NotFound
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

    def get_serializer_context(self):
        context = super().get_serializer_context()
        query_params = self.request.query_params
        fields = query_params.get("fields", "")
        try:
            if fields:
                fields = [field.strip() for field in fields.split(",")] 

            event_params = {
                "state": format_choice_query_params(
                    query_params.get("event_state", "")),
                "name": query_params.get("event_name", ""),   
                "page": int(query_params.get("event_pg", 1)),
                "page_size": int(query_params.get("event_pg_sz", 5)),
            }

            club_params = {
                "name": query_params.get("club_name", ""),
                "sport_type": format_choice_query_params(
                    query_params.get("club_sport_type", "")),
                "mode": format_choice_query_params(
                    query_params.get("club_mode", "")),
                "org_type" : format_choice_query_params(
                    query_params.get("club_org_type", "")),
                "page": int(query_params.get("club_pg", 1)),
                "page_size": int(query_params.get("club_pg_sz", 5)),
            }

            product_params = {
                "product_q": query_params.get("product_q", ""),
            }

            follow_params = {
                "follower_q": query_params.get("follower_q", ""),
                "followee_q": query_params.get("followee_q", ""),
            }
            act_rec_params = {
                'act_rec_exclude': [param.strip().lower() for param in self.request.query_params.get('act_rec_exclude', "").split(',')],
            }
            # activity_record_params = {
            #     "page": int(query_params.get("act_rec_pg", 1)),
            #     "page_size": int(query_params.get("act_rec_pg_sz", 5)),
            # }
        except:
            raise NotFound("Invalid type for page or page_size")
        
        # print(event_params)
        # print(club_params)

        context= {
            "request": self.request,
            "fields": fields,
            "event_params": event_params, 
            "club_params": club_params,
            "product_params": product_params,
            "follow_params": follow_params,
            "act_rec_params": act_rec_params,
    
            "user": self.request.user.activity,
            # "activity_record_params": activity_record_params
        }
        return context
        
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return response.Response(serializer.data)



    