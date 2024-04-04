# Generated by Django 3.2.7 on 2024-04-04 06:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('activity', '0011_auto_20240404_1257'),
    ]

    operations = [
        migrations.AddField(
            model_name='activityrecord',
            name='title',
            field=models.CharField(default='', max_length=100),
        ),
        migrations.AlterField(
            model_name='activityrecord',
            name='avg_heart_rate',
            field=models.IntegerField(default=129, null=True),
        ),
    ]
