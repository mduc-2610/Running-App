# Generated by Django 3.2.7 on 2024-04-18 09:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0011_activity_follow'),
        ('social', '0003_auto_20240418_1413'),
    ]

    operations = [
        migrations.AddField(
            model_name='clubpost',
            name='likes',
            field=models.ManyToManyField(to='account.Activity'),
        ),
        migrations.AddField(
            model_name='eventpost',
            name='likes',
            field=models.ManyToManyField(to='account.Activity'),
        ),
    ]
