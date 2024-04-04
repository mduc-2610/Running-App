from django.contrib import admin

from account.models import Performance


# class LevelFilter(admin.SimpleListFilter):
#     title = 'Level'
#     parameter_name = 'level'

#     def lookups(self, request, model_admin):
#         # Define the options for the filter
#         return (
#             ('1', 'Level 1'),
#             ('2', 'Level 2'),
#             ('3', 'Level 3'),
#             # Add more levels as needed
#         )

#     def queryset(self, request, queryset):
#         if self.value():
#             level = int(self.value())
#             # Filter performances based on the selected level
#             # queryset = queryset.filter(level__gte=level, level__lt=level + 1)
#         return queryset

# class StepRemainingToLevelUpFilter(admin.SimpleListFilter):
#     title = 'Step Remaining to Level Up'
#     parameter_name = 'steps_remaining'

#     def lookups(self, request, model_admin):
#         # Define the filter options
#         return (
#             ('0', '0 Steps Remaining'),
#             ('1-999', '1-999 Steps Remaining'),
#             ('1000-1999', '1000-1999 Steps Remaining'),
#             # Add more ranges as needed
#         )

#     def queryset(self, request, queryset):
#         # Filter queryset based on the selected step remaining range
#         if self.value() == '0':
#             return queryset.filter(steps_remaining=0)
#         elif self.value() == '1-999':
#             return queryset.filter(steps_remaining_to_lev=(1, 999))
#         elif self.value() == '1000-1999':
#             return queryset.filter(steps_remaining_to_lev=(1000, 1999))
#         # Add more conditions for other ranges
#         else:
#             return queryset

# class PointFilter(admin.SimpleListFilter):
#     title = 'Point'
#     parameter_name = 'point'

#     def lookups(self, request, model_admin):
#         # Define the filter options
#         return (
#             ('0-99', '0-99 Points'),
#             ('100-199', '100-199 Points'),
#             ('200-299', '200-299 Points'),
#             # Add more ranges as needed
#         )

#     def queryset(self, request, queryset):
#         # Filter queryset based on the selected point range
#         if self.value() == '0-99':
#             return queryset.filter(point__range=(0, 99))
#         elif self.value() == '100-199':
#             return queryset.filter(point__range=(100, 199))
#         elif self.value() == '200-299':
#             return queryset.filter(point__range=(200, 299))
#         # Add more conditions for other ranges
#         else:
#             return queryset


class PerformanceAdmin(admin.ModelAdmin):
    list_display = (
        # "get_username", "total_steps", "level", 
        # "steps_done_this_level", "total_points", 
        # "get_week_stats", "get_month_stats", "get_year_stats"
    )

    # list_filter = (
    #     "get_week_stats", "get_month_stats", "get_year_stats"
    # )
    list_filter = (
        # LevelFilter,
        # StepRemainingToLevelUpFilter,
        # PointFilter,
    )

    def get_username(self, obj):
        return obj.get_username()

    def get_week_stats(self, obj):
        return obj.week_stats('distance')
    
    def get_month_stats(self, obj):
        return obj.month_stats('distance')
    
    def get_year_stats(self, obj):
        return obj.year_stats('distance')
    
    get_username.short_description = 'username'
    get_week_stats.short_description = 'distance week stats'
    get_month_stats.short_description = 'distance month stats'
    get_year_stats.short_description = 'distance year stats'

