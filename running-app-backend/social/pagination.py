from rest_framework import pagination

class SocialPagination(pagination.PageNumberPagination):
    page_size = 10
    page_size_query_param = 'pg_sz'
    max_page_size = 100