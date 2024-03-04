import uuid

from django.db import models
from django.core.validators import MaxLengthValidator

class ActivityRecord(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    distance = models.DecimalField(max_digits=6, decimal_places=3)
    duration = models.DurationField()
    completed_at = models.DateTimeField(auto_now_add=True)
    SPORT_CHOICES = (
        ("RUNNING", "Running"),
        ("JOGGING", "Jogging"),
        ("CYCLING", "Cycling"),
        ("SWIMMING", "Swimming"),
    )
    sport_type = models.CharField(max_length=15, choices=SPORT_CHOICES, default="RUNNING")
    description = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(255, 'The field can contain at most 200 characters')]
    )
    user = models.ForeignKey(
            "account.User", related_name="activity_record", on_delete=models.CASCADE)

    def pace(self):
        if self.duration.total_seconds() > 0 and self.distance > 0:
            total_minutes = self.duration.total_seconds() / 60
            pace_minutes = total_minutes / self.distance
            pace_seconds = pace_minutes % 1 * 60
            pace_minutes = int(pace_minutes)
            pace_seconds = int(pace_seconds)
            return f"{pace_minutes:02d}:{pace_seconds:02d} per km"
        else:
            return "N/A"
        
    def points_earned(self):
        points_per_100_steps = 1
        points = self.step() or self.step_other_sport() // 100 * points_per_100_steps
        return points
    
    def step(self):
        conversion_data = {
            "CYCLING": 800,
            "RUNNING": 1300,
            "SWIMMING": 1900,
        }
        return int(self.distance * conversion_data[self.sport_type])

    def kcal(self):
        kcal_per_unit_distance = {
            "CYCLING": 50,
            "RUNNING": 70,
            "SWIMMING": 180,
        }
        kcal_per_km = kcal_per_unit_distance[self.sport_type]
        total_kcal = self.distance * kcal_per_km
        return total_kcal