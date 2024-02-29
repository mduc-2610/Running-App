import datetime, uuid
from datetime import timedelta, datetime

from django.db import models
from django.db.models import Sum

class Performance(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    user = models.OneToOneField("account.User", related_name="performance", on_delete=models.CASCADE)

    def get_username(self):
        return self.user.username
    
    def total_steps(self):
        return sum([act.step() for act in self.user.activity_record.all()])   

    def step_to_level_up(self):
        base_step = 1000
        return base_step + self.level * 1000 + (self.level // 5 * 10000)

    def level_up(self):
        cnt = 1
        step = self.total_steps()
        steps_remaining = 0
        base_step = 1000
        while True:
            total_steps = base_step + cnt * 1000 + (cnt // 5 * 10000)
            if step >= total_steps:
                step -= total_steps
            else:
                steps_remaining = total_steps - step
                break
            cnt += 1
        return cnt, steps_remaining
    
    def level(self):
        return self.level_up()[0]
    
    def steps_remaining(self):
        return self.level_up()[1]
    
    def point(self):
        return self.total_steps() // 100

    def star(self):
        # root_url = "static/images/stars/star_"
        return int(self.level / 5);

    def week_stats(self, col):
        today = datetime.now().date()
        start_of_week = today - timedelta(days=today.weekday())
        end_of_week = start_of_week + timedelta(days=6)

        week_distance = self.user.activity_record \
                            .filter(completed_at__date__range=[start_of_week, end_of_week]) \
                            .aggregate(total=Sum(col))['total'] or 0
        return week_distance

    def month_stats(self, col):
        today = datetime.now().date()
        start_of_month = today.replace(day=1)
        next_month = today.replace(day=28) + timedelta(days=4)
        end_of_month = next_month - timedelta(days=next_month.day)

        month_distance = self.user.activity_record \
                            .filter(completed_at__date__range=[start_of_month, end_of_month]) \
                            .aggregate(total=Sum(col))['total'] or 0
        return month_distance

    def year_stats(self, col):
        today = datetime.now().date()
        start_of_year = today.replace(month=1, day=1)
        end_of_year = today.replace(month=12, day=31)

        year_distance = self.user.activity_record \
                            .filter(completed_at__date__range=[start_of_year, end_of_year]) \
                            .aggregate(total=Sum(col))['total'] or 0
        return year_distance
    
    def __str__(self):
        return f"{self.user} {self.point()}"