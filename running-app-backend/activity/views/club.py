from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response
from rest_framework.permissions import IsAuthenticated


from activity.models import Club
from activity.serializers import ClubSerializer, \
                                DetailClubSerializer, \
                                CreateUpdateClubSerializer

from utils.function import get_start_of_day, \
                            get_end_of_day, \
                            get_start_date_of_week, \
                            get_end_date_of_week, \
                            get_start_date_of_month, \
                            get_end_date_of_month, \
                            get_start_date_of_year, \
                            get_end_date_of_year

class ClubViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
):
    queryset = Club.objects.all()
    serializer_class = ClubSerializer
    # permission_classes = [IsAuthenticated]

    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateClubSerializer
        elif self.action == "retrieve":
            return DetailClubSerializer
        return super().get_serializer_class()
    
    def retrieve(self, request, * args, **kwargs):
        query_params = self.request.query_params
        start_date = query_params.get('start_date', get_start_date_of_month())
        end_date = query_params.get('end_date', get_end_date_of_month())
        sort_by = query_params.get('sort_by', 'Distance')
        gender = query_params.get('gender', None)
        limit_user = query_params.get('limit_user', None)

        instance = self.get_object()
        serializer = self.get_serializer(instance, context={
            'start_date': start_date, 
            'end_date': end_date,
            'sort_by': sort_by,
            'gender': gender,
            'limit_user': limit_user
        })
        return response.Response(serializer.data, status=status.HTTP_200_OK)
    