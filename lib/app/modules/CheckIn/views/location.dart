import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as ph;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double latitude = 0.0;
  double longitude = 0.0;
  String fullAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Current Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(latitude.toString()),
            Text(longitude.toString()),
            Text(fullAddress),
            ElevatedButton(
              onPressed: () async {
                await requestLocationPermission();
                await getCurrentLocation();
              },
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    final ph.PermissionStatus status = await ph.Permission.location.request();
    if (status.isGranted) {
      // Permission granted; you can now retrieve the location.
    } else if (status.isDenied) {
      // Permission denied.
      print('Location_permission_denied');
    }
  }

  Future<void> getCurrentLocation() async {
    final loc.Location location = loc.Location();
    try {
      final loc.LocationData locationData = await location.getLocation();
      setState(() {
        latitude = locationData.latitude!;
        longitude = locationData.longitude!;
        getAddress(latitude, longitude);
      });
      // Handle the location data as needed.
    } catch (e) {
      // Handle errors, such as permissions not granted or location services disabled.
      print('Error getting location: $e');
    }
  }

  getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      String address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      print(address);
      setState(() {
        fullAddress = address;
      });
    } catch (e) {
      print('No address available');
    }
  }


}