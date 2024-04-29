from django.db.models import Q
from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response
from rest_framework.permissions import IsAuthenticated
from rest_framework.pagination import PageNumberPagination

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
                            get_end_date_of_year, \
                            format_choice_query_params

class ActivityRecordPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 1000

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
    # pagination_class = ActivityRecordPagination

    # permission_classes = [IsAuthenticated]

    def get_queryset(self):
        queryset = super().get_queryset()
        query_params = self.request.query_params

        params = {
            "name": query_params.get("name", ""),
            "sport_type": format_choice_query_params(
                query_params.get("sport_type", "")),
            "mode": format_choice_query_params(
                query_params.get("mode", "")),
            "org_type" : format_choice_query_params(
                query_params.get("org_type", "")),
        }

        print(params)

        filters = Q()

        if params["name"]:
            filters &= Q(name__icontains=params["name"])

        if params["sport_type"]:
            filters &= Q(sport_type=params["sport_type"])

        if params["mode"]:
            filters &= Q(privacy=params["mode"])

        if params["org_type"]:
            filters &= Q(organization=params["org_type"])

        return queryset.filter(filters)

    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateClubSerializer
        elif self.action == "retrieve":
            return DetailClubSerializer
        return super().get_serializer_class()
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        if self.action == "retrieve":
            query_params = self.request.query_params
            start_date = query_params.get('start_date', get_start_date_of_month())
            end_date = query_params.get('end_date', get_end_date_of_month())
            sort_by = query_params.get('sort_by', 'Distance')
            gender = query_params.get('gender', None)
            limit_user = query_params.get('limit_user', None)
            exclude = [x.strip().lower() for x in query_params.get('exclude', '').split(',')]

            context.update({
                'start_date': start_date, 
                'end_date': end_date,
                'sort_by': sort_by,
                'gender': gender,
                'limit_user': limit_user,
                'exclude': exclude
            })
            
        context.update({'request': self.request,})
        return context
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)

    def retrieve(self, request, * args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return response.Response(serializer.data, status=status.HTTP_200_OK)
    
    # def get_queryset(self):
    #     queryset = super().get_queryset()
    #     query_params = self.request.query_params

    #     club_params = {
    #         "club_name": format_choice_query_params(
    #             query_params.get("club_name", "")),
    #         "club_sport_type": format_choice_query_params(
    #             query_params.get("club_sport_type", "")),
    #         "club_mode": format_choice_query_params(
    #             query_params.get("club_mode", "")),
    #         "club_org_type" : format_choice_query_params(
    #             query_params.get("club_org_type", "")),
    #     }

    #     filters = Q()

    #     if club_params["club_name"]:
    #         filters &= Q(name__icontains=club_params["club_name"])

    #     if club_params["club_sport_type"]:
    #         filters &= Q(sport_type=club_params["club_sport_type"])

    #     if club_params["club_mode"]:
    #         filters &= Q(privacy=club_params["club_mode"])

    #     if club_params["club_org_type"]:
    #         filters &= Q(organization=club_params["club_org_type"])

    #     return queryset.filter(filters)