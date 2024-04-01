import uuid

from django.db import models
from django.core.validators import MaxLengthValidator

class ActivityRecord(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    image = models.ImageField(upload_to="", null=True, blank=True)
    distance = models.DecimalField(max_digits=6, decimal_places=3)
    duration = models.DurationField()
    completed_at = models.DateTimeField(auto_now_add=True)
    SPORT_CHOICES = (
        ("RUNNING", "Running"),
        ("WALKING", "Walking"),
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
            "account.Activity", related_name="activity_records", on_delete=models.CASCADE)

    def description_lines(self):
        count = 0
        lines = self.description.split("\n")
        for line in lines:
            count += len(line) // 47 + 1
        return count

    def avg_moving_pace(self):
        if self.duration.total_seconds() > 0 and self.distance > 0:
            pace = (self.duration.total_seconds() / 60) / float(self.distance)
            pace_minutes = int(pace)
            pace_seconds = round((pace - pace_minutes) * 60)
            return f"{pace_minutes:02d}:{pace_seconds:02d}/km"
        else:
            return "N/A"
        
    def points_earned(self):
        points_per_100_steps = 1
        points = self.steps() // 100 * points_per_100_steps
        return points
    
    def steps(self):
        conversion_data = {
            "CYCLING": 800,
            "RUNNING": 1300,
            "WALKING": 1300,
            "SWIMMING": 1900,
        }
        return int(self.distance * conversion_data[self.sport_type])

    def kcal(self):
        kcal_per_unit_distance = {
            "CYCLING": 50,
            "RUNNING": 70,
            "WALKING": 70,
            "SWIMMING": 180,
        }
        kcal_per_km = kcal_per_unit_distance[self.sport_type]
        total_kcal = self.distance * kcal_per_km
        return round(total_kcal)
    
    def get_readable_date(self, col):
        return self[col].strftime('%d %b')
    
    def get_readable_date_time(self, col):
        return self.completed_at.strftime('%b %d, %Y at %I:%M %p')

    def __getitem__(self, key):
        if hasattr(self, key):
            return getattr(self, key)
        else:
            raise KeyError(f"{key} attribute not found")