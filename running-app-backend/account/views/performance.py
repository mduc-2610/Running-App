from datetime import datetime, timedelta

from rest_framework import viewsets, \
                            mixins, \
                            response, \
                            status

from account.models import Performance

from account.serializers import PerformanceSerializer, \
                                CreatePerformanceSerializer, \
                                LeaderboardSerializer

from utils.function import get_start_of_day, \
                            get_end_of_day, \
                            get_start_date_of_week, \
                            get_end_date_of_week, \
                            get_start_date_of_month, \
                            get_end_date_of_month, \
                            get_start_date_of_year, \
                            get_end_date_of_year

from rest_framework.decorators import action
from functools import cmp_to_key
from utils.pagination import CommonPagination

class PerformanceViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    queryset = Performance.objects.all()
    serializer_class = PerformanceSerializer
    
    def get_queryset(self):
        queryset = super().get_queryset()
        if self.action == 'leaderboard':
            query_params = self.request.query_params
            gender = query_params.get('gender', None)
            start_date = query_params.get('start_date', get_start_date_of_week())
            end_date = query_params.get('end_date', get_end_date_of_week())
            sort_by = query_params.get('sort_by', 'Distance')

            if gender: 
                queryset = queryset.filter(user__profile__gender=gender)

            def sort_cmp(x, sort_by):
                stats = x.range_stats(start_date, end_date, sport_type="RUNNING")
                if sort_by == 'Time':
                    return (-stats[3], -stats[0])
                return (-stats[0], -stats[3])
            queryset = sorted(queryset, key=lambda x: sort_cmp(x, sort_by))

        return queryset

    def get_serializer_class(self):
        print("Acessing User:", self.request.user)
        if self.action == "create":
            return CreatePerformanceSerializer
        elif self.action == 'leaderboard': 
            return LeaderboardSerializer
        return super().get_serializer_class()
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        query_params = self.request.query_params
        if self.action == 'leaderboard':
            start_date = query_params.get('start_date', None)
            end_date = query_params.get('end_date', None)
            context.update({
                'start_date': start_date, 
                'end_date': end_date
            })
        elif self.action == 'retrieve':
            sport_type = self.request.query_params.get('sport_type', None)
            start_date = self.request.query_params.get('start_date', None)
            end_date = self.request.query_params.get('end_date', None)
            period = self.request.query_params.get('period', None)
            context.update({
                'sport_type': sport_type,
                'start_date': start_date, 
                'end_date': end_date,
                'period': period
            })

        context['request'] = self.request
        return context
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)
    
    @action(detail=False, methods=['GET'], url_path='leaderboard', name='leaderboard')
    def leaderboard(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        paginator = CommonPagination(page_size=20)
        paginated_queryset = paginator.paginate_queryset(queryset, self.request)
        serializer = self.get_serializer(paginated_queryset, many=True)
        return response.Response(serializer.data, status=status.HTTP_200_OK)
    
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return response.Response(serializer.data, status=status.HTTP_200_OK)
    
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return response.Response(serializer.data, status=status.HTTP_200_OK)
    