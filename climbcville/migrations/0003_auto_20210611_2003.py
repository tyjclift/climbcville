# Generated by Django 3.1.7 on 2021-06-12 01:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('climbcville', '0002_admin_climber_location_route_route_log_entry_route_setter'),
    ]

    operations = [
        migrations.AlterField(
            model_name='admin',
            name='phone',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='climber',
            name='phone',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='route_setter',
            name='phone',
            field=models.IntegerField(),
        ),
    ]
