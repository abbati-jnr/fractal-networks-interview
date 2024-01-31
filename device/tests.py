from django.test import TestCase
from django.contrib.gis.geos import Point
from device.models import Device

# Create your tests here.


class DeviceTestCase(TestCase):
    def setUp(self):
        sample_location = '{ "type": "Point", "coordinates": [ 88.39, 11.02 ] }'
        Device.objects.create(name="Pi", location=sample_location)

    def test_device_location(self):
        """Testing device location"""
        sample_location = '{ "type": "Point", "coordinates": [ 88.39, 11.02 ] }'
        device = Device.objects.get(id=1)
        self.assertEqual(device.location.json, sample_location)
