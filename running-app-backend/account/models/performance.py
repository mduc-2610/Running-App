import datetime, uuid
from datetime import timedelta, datetime

from django.db import models
from django.db.models import Sum

from utils.function import get_start_of_day, \
                            get_end_of_day, \
                            get_start_date_of_week, \
                            get_end_date_of_week, \
                            get_start_date_of_month, \
                            get_end_date_of_month, \
                            get_start_date_of_year, \
                            get_end_date_of_year

class Performance(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.OneToOneField("account.User", related_name="performance", on_delete=models.CASCADE)
    activity = models.OneToOneField("account.Activity", related_name="activity_performances", on_delete=models.CASCADE)
    total_points = models.IntegerField(default=0, null=True)
    total_steps = models.IntegerField(default=0, null=True)
    
    def get_username(self):
        return self.user.username
    
    def format_duration(self, seconds):
        hours = seconds // 3600
        minutes = (seconds % 3600) // 60
        seconds = seconds % 60
        return "{:02d}:{:02d}:{:02d}".format(round(hours), round(minutes), round(seconds))

    def pace_readable(self, avg_moving_pace):
        if avg_moving_pace == 0: return "00:00"
        pace_minutes = int(avg_moving_pace)
        pace_seconds = round((avg_moving_pace - pace_minutes) * 60)
        return f"{pace_minutes:02d}:{pace_seconds:02d}"
    
    # def total_steps(self):
    #     return sum([act.steps() for act in self.activity.activity_records.all()]) 
    
    def total_distance(self):
        return self.total_stats()[0]
    
    def total_duration(self):
        return self.total_stats()[3]

    def level_up(self):
        cnt = 1
        steps = self.total_steps
        base_step = 1000
        steps_done_this_level = 0
        total_steps_this_level = 0
        while True:
            total_steps_this_level = base_step + cnt * 1000 + (cnt // 5 * 10000)
            if steps >= total_steps_this_level:
                steps -= total_steps_this_level
            else:
                # steps_done_this_level = steps - total_steps_this_level
                steps_done_this_level = steps
                break
            cnt += 1
        return cnt, steps_done_this_level, total_steps_this_level
    
    def level(self):
        return self.level_up()[0]
    
    def steps_done_this_level(self):
        return self.level_up()[1]
    
    def total_steps_this_level(self):
        return self.level_up()[2]

    def star(self):
        return int(self.level / 5);

    def get_activities_in_range(self, start_date, end_date):
        return self.activity.activity_records.filter(completed_at__date__range=[start_date, end_date])

    def calculate_stats(self, activities, sport_type=None):
        activities_run_walk = activities.filter(sport_type__in=['RUNNING', 'WALKING'])
        if sport_type:
            activities = activities.filter(sport_type=sport_type)
            activities_run_walk = activities
            
        total_distance = activities.aggregate(total_distance=Sum('distance'))['total_distance'] or 0
        total_steps = sum([act.steps() for act in activities])
        total_points = sum([act.points() for act in activities])
        total_duration = activities.aggregate(total_duration=Sum('duration'))['total_duration'] or timedelta(seconds=0)
        avg_total_moving_pace = sum([act.avg_moving_pace() for act in activities]) / (len(activities) if len(activities) != 0 else 1)
        avg_total_cadence = sum([act.avg_cadence() for act in activities_run_walk]) / (len(activities_run_walk) if len(activities_run_walk) != 0 else 1)
        avg_total_heart_rate = sum([act.avg_heart_rate for act in activities]) / (len(activities) if len(activities) != 0 else 1)
        active_days = activities.values('completed_at__date').distinct().count()
        
        return float(total_distance), \
                total_steps, \
                total_points, \
                total_duration.total_seconds(), \
                self.pace_readable(avg_total_moving_pace), \
                round(avg_total_cadence), \
                round(avg_total_heart_rate), \
                active_days

    def daily_stats(self, sport_type=None):
        start_of_day = get_start_of_day()
        end_of_day = get_end_of_day()

        daily_activities = self.get_activities_in_range(start_of_day, end_of_day)
        return self.calculate_stats(daily_activities, sport_type)

    def weekly_stats(self, sport_type=None):
        start_of_week = get_start_date_of_week()
        end_of_week = get_end_date_of_week()

        weekly_activities = self.get_activities_in_range(start_of_week, end_of_week)
        return self.calculate_stats(weekly_activities, sport_type)

    def monthly_stats(self, sport_type=None):
        start_of_month = get_start_date_of_month()
        end_of_month = get_end_date_of_month()

        monthly_activities = self.get_activities_in_range(start_of_month, end_of_month)
        return self.calculate_stats(monthly_activities, sport_type)

    def yearly_stats(self, sport_type=None):
        today = datetime.now().date()
        start_of_year = get_start_date_of_year()
        end_of_year = get_end_date_of_year()

        yearly_activities = self.get_activities_in_range(start_of_year, end_of_year)
        return self.calculate_stats(yearly_activities, sport_type)

    def range_stats(self, start_date, end_date, sport_type=None):
        activities = self.get_activities_in_range(start_date, end_date)
        return self.calculate_stats(activities, sport_type)

    def total_stats(self, sport_type=None):
        activities = self.activity.activity_records.all()
        return self.calculate_stats(activities, sport_type)

    def __str__(self):
        return f"{self.user}"
    


    # 
    
    # def total_points(self):
    #     return sum([act.points() for act in self.activity.activity_records.all()]) 

    # def avg_total_moving_pace(self):
    #     length = self.activity.activity_records.count()
    #     return self.pace_readable(sum([act.avg_moving_pace() for act in self.activity.activity_records.all()]) / (length if length != 0 else 1))
    
    # def avg_total_cadence(self):
    #     length = self.activity.activity_records.count()
    #     return round(sum([act.avg_cadence() for act in self.activity.activity_records.all()]) / (length if length != 0 else 1))
    
    # def avg_total_heart_rate(self):
    #     length = self.activity.activity_records.count()
    #     return round(self.total_stats('avg_heart_rate') / (length if length != 0 else 1))

    # def total_active_days(self):
    #     return self.activity.activity_records.values('completed_at__date').distinct().count()
    

    # def total_stats(self, col):
    #     return self.activity.activity_records.aggregate(total=Sum(col))['total'] or 0