# Generated by Django 3.2.7 on 2024-04-03 13:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('activity', '0008_auto_20240403_2033'),
    ]

    operations = [
        migrations.AlterField(
            model_name='activityrecord',
            name='avg_heart_rate',
            field=models.IntegerField(default=135, null=True),
        ),
    ]
