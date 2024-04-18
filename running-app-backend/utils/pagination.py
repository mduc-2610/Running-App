
from rest_framework import response, \
                            pagination

from rest_framework import pagination

class CommonPagination(pagination.PageNumberPagination):
    def __init__(self, page_size=10, max_page_size=100):
        super().__init__()
        self.page_size = page_size
        self.max_page_size = max_page_size

    def paginate_queryset(self, queryset, request, view=None):
        if 'pg_sz' in request.query_params:
            self.page_size = int(request.query_params['pg_sz'])
        if 'max_pg_sz' in request.query_params:
            self.max_page_size = int(request.query_params['max_pg_sz'])
        
        return super().paginate_queryset(queryset, request, view)

    def get_paginated_response(self, data):
        return response.Response({
            'pagination': {
                'next': self.get_next_link(),
                'previous': self.get_previous_link(),
                'total_pages': self.page.paginator.num_pages,
                'current_page': self.page.number,
                'count': self.page.paginator.count
            },
            'results': data
        })
