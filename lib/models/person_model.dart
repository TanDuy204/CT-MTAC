import 'package:latlong2/latlong.dart';

class PersonModel {
  final String name;
  final String licensePlate;
  final String msx;
  LatLng? driverLocation;

  PersonModel({
    required this.name,
    required this.licensePlate,
    required this.msx,
    this.driverLocation,
  });
}
