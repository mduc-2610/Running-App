from rest_framework import serializers

from account.models import Performance
from account.serializers.user import UserSerializer

class PerformanceSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    level = serializers.SerializerMethodField()
    total_distance = serializers.SerializerMethodField()
    total_steps = serializers.SerializerMethodField()
    total_points = serializers.SerializerMethodField()
    total_duration = serializers.SerializerMethodField()
    avg_total_cadence = serializers.SerializerMethodField()
    avg_total_heart_rate = serializers.SerializerMethodField()
    steps_done_this_level = serializers.SerializerMethodField()
    total_steps_this_level = serializers.SerializerMethodField()
    
    daily_distance = serializers.SerializerMethodField()
    weekly_distance = serializers.SerializerMethodField()
    monthly_distance = serializers.SerializerMethodField()
    yearly_distance = serializers.SerializerMethodField()
    
    daily_steps = serializers.SerializerMethodField()
    weekly_steps = serializers.SerializerMethodField()
    monthly_steps = serializers.SerializerMethodField()
    yearly_steps = serializers.SerializerMethodField()
    
    daily_points = serializers.SerializerMethodField()
    weekly_points = serializers.SerializerMethodField()
    monthly_points = serializers.SerializerMethodField()
    yearly_points = serializers.SerializerMethodField()
    
    daily_duration = serializers.SerializerMethodField()
    weekly_duration = serializers.SerializerMethodField()
    monthly_duration = serializers.SerializerMethodField()
    yearly_duration = serializers.SerializerMethodField()
    
    daily_avg_total_cadence = serializers.SerializerMethodField()
    weekly_avg_total_cadence = serializers.SerializerMethodField()
    monthly_avg_total_cadence = serializers.SerializerMethodField()
    yearly_avg_total_cadence = serializers.SerializerMethodField()
    
    daily_avg_total_heart_rate = serializers.SerializerMethodField()
    weekly_avg_total_heart_rate = serializers.SerializerMethodField()
    monthly_avg_total_heart_rate = serializers.SerializerMethodField()
    yearly_avg_total_heart_rate = serializers.SerializerMethodField()
    
    weekly_active_days = serializers.SerializerMethodField()
    monthly_active_days = serializers.SerializerMethodField()
    yearly_active_days = serializers.SerializerMethodField()

    def get_total_distance(self, instance):
        return instance.total_distance()
    
    def get_total_steps(self, instance):
        return instance.total_steps()
    
    def get_total_points(self, instance):
        return instance.total_points()
    
    def get_total_duration(self, instance):
        return instance.total_duration()

    def get_avg_total_cadence(self, instance):
        return instance.avg_total_cadence()

    def get_avg_total_heart_rate(self, instance):
        return instance.avg_total_heart_rate()

    def get_level(self, instance):
        return instance.level()

    def get_steps_done_this_level(self, instance):
        return instance.steps_done_this_level()
    
    def get_total_steps_this_level(self, instance):
        return instance.total_steps_this_level()    

    def get_daily_distance(self, instance):
        return instance.daily_stats()[0]
    
    def get_weekly_distance(self, instance):
        return instance.weekly_stats()[0]
    
    def get_monthly_distance(self, instance):
        return instance.monthly_stats()[0]
    
    def get_yearly_distance(self, instance):
        return instance.yearly_stats()[0]


    def get_daily_steps(self, instance):
        return instance.daily_stats()[1]
    
    def get_weekly_steps(self, instance):
        return instance.weekly_stats()[1]
    
    def get_monthly_steps(self, instance):
        return instance.monthly_stats()[1]
    
    def get_yearly_steps(self, instance):
        return instance.yearly_stats()[1]
    

    def get_daily_points(self, instance):
        return instance.daily_stats()[2]
    
    def get_weekly_points(self, instance):
        return instance.weekly_stats()[2]
    
    def get_monthly_points(self, instance):
        return instance.monthly_stats()[2]
    
    def get_yearly_points(self, instance):
        return instance.yearly_stats()[2]


    def get_daily_duration(self, instance):
        return format(instance.daily_stats()[3])
    
    def get_weekly_duration(self, instance):
        return format(instance.monthly_stats()[3])
    
    def get_monthly_duration(self, instance):
        return format(instance.weekly_stats()[3])
    
    def get_yearly_duration(self, instance):
        return format(instance.yearly_stats()[3])


    def get_daily_avg_total_cadence(self, instance):
        return instance.daily_stats()[4]

    def get_weekly_avg_total_cadence(self, instance):
        return instance.weekly_stats()[4]

    def get_monthly_avg_total_cadence(self, instance):
        return instance.monthly_stats()[4]

    def get_yearly_avg_total_cadence(self, instance):
        return instance.yearly_stats()[4]
    

    def get_daily_avg_total_heart_rate(self, instance):
        return instance.daily_stats()[5]

    def get_weekly_avg_total_heart_rate(self, instance):
        return instance.weekly_stats()[5]

    def get_monthly_avg_total_heart_rate(self, instance):
        return instance.monthly_stats()[5]

    def get_yearly_avg_total_heart_rate(self, instance):
        return instance.yearly_stats()[5]  
        

    def get_weekly_active_days(self, instance):
        return instance.yearly_stats()[6]
    
    def get_monthly_active_days(self, instance):
        return instance.yearly_stats()[6]
    
    def get_yearly_active_days(self, instance):
        return instance.yearly_stats()[6]

    class Meta:
        model = Performance
        # fields = "__all__"
        exclude = ("activity",)
        extra_kwargs = {
            "id": {"read_only": True},
        }

class CreatePerformanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Performance
        fields = "__all__"
        extra_kwargs = {
            "id": {"read_only": True},
        }