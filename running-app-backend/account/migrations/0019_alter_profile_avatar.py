# Generated by Django 3.2.7 on 2024-05-27 03:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0018_auto_20240507_1210'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='avatar',
            field=models.ImageField(blank=True, default='avatar4', null=True, upload_to='images'),
        ),
    ]
