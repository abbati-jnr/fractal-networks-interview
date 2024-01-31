from django.db import models
from django.contrib.gis.db.models import PointField

# Create your models here.

from django.contrib.postgres.operations import CreateExtension
from django.db import migrations


# Enabling PostGIS extension for geospatial data support
class Migration(migrations.Migration):
    operations = [CreateExtension("postgis"), ...]


class Device(models.Model):
    name = models.CharField(max_length=250)
    location = PointField()
