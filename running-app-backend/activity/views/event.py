from rest_framework import viewsets, \
                            mixins, \
                            status, \
                            response

from django.db.models import Count, Sum, Q
from django.utils import timezone

from activity.models import Event
from activity.serializers import EventSerializer, \
                                DetailEventSerializer, \
                                CreateUpdateEventSerializer

from utils.function import get_start_of_day, \
                            get_end_of_day, \
                            get_start_date_of_week, \
                            get_end_date_of_week, \
                            get_start_date_of_month, \
                            get_end_date_of_month, \
                            get_start_date_of_year, \
                            get_end_date_of_year, \
                            format_choice_query_params

class EventViewSet(
    mixins.ListModelMixin, 
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    viewsets.GenericViewSet
):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    
    def get_queryset(self):
        now = timezone.now()
        queryset =  super().get_queryset()
        query_params = self.request.query_params

        sort_by = query_params.get("sort", None)
        sort_params = [x.strip() for x in sort_by.split(",")] if sort_by else []
        if sort_params and ("participants" in sort_params or "-participants" in sort_params):
            queryset = queryset.annotate(participants=Count("events"))
            participants_param = [x for x in sort_params if x.endswith("participants")]
            sort_params.remove(participants_param[0])
            queryset = queryset.order_by(participants_param[0], *sort_params)
        
        extra_params = {
            "name": query_params.get("name", ""),
            "state": format_choice_query_params(
                query_params.get("state", "")),
            "mode": format_choice_query_params(
                query_params.get("mode", "")),
            "competition" : format_choice_query_params(
                query_params.get("competition", "")),
        }

        print(extra_params)

        filters = Q()

        if extra_params["state"]:
            if extra_params["state"] == "UPCOMING":
                filters &= Q(started_at__gt=now)
            elif extra_params["state"] == "ONGOING":
                filters &= Q(started_at__lte=now, ended_at__gte=now)
            elif extra_params["state"] == "ENDED":
                filters &= Q(ended_at__lt=now)

        if extra_params["name"]:
            filters &= Q(name__icontains=extra_params["name"])

        if extra_params["mode"]:
            filters &= Q(privacy=extra_params["mode"])

        if extra_params["competition"]:
            filters &= Q(competition=extra_params["competition"])
        queryset = queryset.filter(filters)
        
        limit = query_params.get("limit", None)
        queryset = queryset[:int(limit)] if limit else queryset

        return queryset
    
    def get_serializer_class(self):
        if self.action == "create" or self.action == "update":
            return CreateUpdateEventSerializer
        elif self.action == "retrieve":
            return DetailEventSerializer
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
            print("event exclude", exclude)
            context.update({
                'request': self.request,
                'start_date': start_date, 
                'end_date': end_date,
                'sort_by': sort_by,
                'gender': gender,
                'limit_user': limit_user,
                'exclude': exclude
            })
        return context
    
    def get_serializer(self, *args, **kwargs):
        serializer_class = self.get_serializer_class()
        kwargs["context"] = self.get_serializer_context()
        return serializer_class(*args, **kwargs)

    def retrieve(self, request, * args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return response.Response(serializer.data, status=status.HTTP_200_OK)
