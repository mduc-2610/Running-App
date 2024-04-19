import uuid
import random
from django.db import models
from django.core.validators import MaxLengthValidator

class ActivityRecord(models.Model):
    class Meta:
        ordering = ['-completed_at']

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    image = models.ImageField(upload_to="", null=True, blank=True)
    distance = models.DecimalField(max_digits=6, decimal_places=3)
    duration = models.DurationField()
    avg_heart_rate = models.IntegerField(null=True, default=random.randint(100, 160))
    # completed_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField()
    SPORT_CHOICES = (
        ("RUNNING", "Running"),
        ("WALKING", "Walking"),
        ("CYCLING", "Cycling"),
        ("SWIMMING", "Swimming"),
    )
    PRIVACY_CHOICES = (
        ("ANYONE", "Anyone"),
        ("FOLLOWERS", "Followers"),
        ("ONLY_ME", "Only me"),
    )
    
    privacy = models.CharField(max_length=15, choices=PRIVACY_CHOICES, default="ANYONE")
    sport_type = models.CharField(max_length=15, choices=SPORT_CHOICES, default="RUNNING")
    title = models.CharField(max_length=100, default="")
    description = models.TextField(
        blank=True, 
        null=True,
        validators=[MaxLengthValidator(255, 'The field can contain at most 200 characters')]
    )
    user = models.ForeignKey(
            "account.Activity", related_name="activity_records", on_delete=models.CASCADE)
    likes = models.ManyToManyField(
        "account.Activity", blank=True, through="social.ActivityRecordPostLike")

    def avg_moving_pace(self):
        total_seconds = self.duration.total_seconds()
        distance = self.distance

        return (total_seconds / 60) / float(distance) if total_seconds > 0 and distance > 0 else 0
        
    def avg_moving_pace_readable(self):
        avg_moving_pace = self.avg_moving_pace()
        if avg_moving_pace == 0: return "00:00"
        pace_minutes = int(avg_moving_pace)
        pace_seconds = round((avg_moving_pace - pace_minutes) * 60)
        return f"{pace_minutes:02d}:{pace_seconds:02d}"
    
    def avg_cadence(self):
        if self.duration.total_seconds() > 0 and self.distance > 0:
            cadence_adjustment = {
                "SWIMMING": 250,
                "RUNNING": 160,
                "WALKING": 120,
                "CYCLING": 90,
            }
            pace = (self.duration.total_seconds() / 60) / float(self.distance)
            estimated_cadence = cadence_adjustment.get(self.sport_type, 0) + int(60 / (pace * 2))
            return round(estimated_cadence) if estimated_cadence > 0 else 0
        else:
            return 0
        
    def points(self):
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
        return round(self.distance * conversion_data[self.sport_type])

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

    def total_likes(self):
        return self.likes.count()
    
    def total_comments(self):
        return self.comments.count()
    
    def get_readable_date(self, col):
        return self[col].strftime('%d %b')
    
    def get_readable_date_time(self, col):
        return self.completed_at.strftime('%b %d, %Y at %I:%M %p')

    def __getitem__(self, key):
        if hasattr(self, key):
            return getattr(self, key)
        else:
            raise KeyError(f"{key} attribute not found")
    
class ActivityRecordImage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, db_index=True)
    activity_record = models.ForeignKey('activity.ActivityRecord', related_name='activity_record_images', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='')