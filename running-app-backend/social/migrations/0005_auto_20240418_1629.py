# Generated by Django 3.2.7 on 2024-04-18 09:29

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('social', '0004_auto_20240418_1620'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='clubpost',
            name='likes',
        ),
        migrations.RemoveField(
            model_name='eventpost',
            name='likes',
        ),
    ]
