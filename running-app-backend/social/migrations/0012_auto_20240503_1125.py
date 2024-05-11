# Generated by Django 3.2.7 on 2024-05-03 04:25

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0014_auto_20240427_0947'),
        ('activity', '0045_alter_activityrecord_avg_heart_rate'),
        ('social', '0011_auto_20240430_0855'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='activityrecordpostcomment',
            unique_together={('post', 'user')},
        ),
        migrations.AlterUniqueTogether(
            name='activityrecordpostlike',
            unique_together={('post', 'user')},
        ),
        migrations.AlterUniqueTogether(
            name='clubpostcomment',
            unique_together={('post', 'user')},
        ),
        migrations.AlterUniqueTogether(
            name='clubpostlike',
            unique_together={('post', 'user')},
        ),
        migrations.AlterUniqueTogether(
            name='eventpostcomment',
            unique_together={('post', 'user')},
        ),
        migrations.AlterUniqueTogether(
            name='eventpostlike',
            unique_together={('post', 'user')},
        ),
    ]