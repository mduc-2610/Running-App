# Generated by Django 3.2.7 on 2024-05-05 03:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0016_activity_total_activity_records'),
        ('activity', '0053_alter_activityrecord_avg_heart_rate'),
    ]

    operations = [
        migrations.AddField(
            model_name='club',
            name='total_activity_records',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AlterField(
            model_name='activityrecord',
            name='avg_heart_rate',
            field=models.IntegerField(default=105, null=True),
        ),
        migrations.AlterUniqueTogether(
            name='userparticipationclub',
            unique_together={('user', 'club')},
        ),
        migrations.AlterUniqueTogether(
            name='userparticipationevent',
            unique_together={('user', 'event')},
        ),
        migrations.AlterUniqueTogether(
            name='userparticipationgroup',
            unique_together={('user', 'group')},
        ),
    ]