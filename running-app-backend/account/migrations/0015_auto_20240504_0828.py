# Generated by Django 3.2.7 on 2024-05-04 01:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0014_auto_20240427_0947'),
    ]

    operations = [
        migrations.AddField(
            model_name='activity',
            name='total_followees',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AddField(
            model_name='activity',
            name='total_followers',
            field=models.IntegerField(default=0, null=True),
        ),
    ]
