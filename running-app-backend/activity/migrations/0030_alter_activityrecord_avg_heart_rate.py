# Generated by Django 3.2.7 on 2024-04-18 09:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('activity', '0029_alter_activityrecord_avg_heart_rate'),
    ]

    operations = [
        migrations.AlterField(
            model_name='activityrecord',
            name='avg_heart_rate',
            field=models.IntegerField(default=111, null=True),
        ),
    ]
