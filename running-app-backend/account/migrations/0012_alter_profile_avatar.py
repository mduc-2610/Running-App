# Generated by Django 3.2.7 on 2024-04-19 13:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0011_activity_follow'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='avatar',
            field=models.ImageField(default='', null=True, upload_to='images'),
        ),
    ]
