import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:partner/controllers/map_controller.dart';
import 'package:partner/map/destination_list_widget.dart';
import 'package:partner/models/destination_model.dart';

class MapScreen extends StatefulWidget {
  final List<DestinationModel> destinations;
  const MapScreen({super.key, required this.destinations});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController mapController;
  final MapsController mapState = Get.put(MapsController());

  @override
  void initState() {
    super.initState();
    mapState.updateAddress(widget.destinations.first);
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            final driverLocation = mapState.driverLocation.value;
            if (driverLocation == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: driverLocation,
                initialZoom: 14.0,
                maxZoom: 18.0,
                minZoom: 5.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                  retinaMode: true,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: driverLocation,
                      child: Tooltip(
                        message: "Tài xế",
                        child: Icon(
                          Icons.person_pin_circle,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    ...widget.destinations.map((destination) {
                      return Marker(
                        point:
                            LatLng(destination.latitude, destination.longitude),
                        child: GestureDetector(
                          onTap: () =>
                              mapState.fetchRouteToDestination(destination),
                          child: Tooltip(
                            message: destination.companyName,
                            child: Icon(
                              Icons.location_pin,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Obx(() {
                  return mapState.selectedRoute.isNotEmpty
                      ? PolylineLayer(
                          polylines: [
                            Polyline(
                              points: mapState.selectedRoute,
                              strokeWidth: 4.0,
                              color: Colors.blue,
                            ),
                          ],
                        )
                      : const SizedBox();
                }),
              ],
            );
          }),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Theo dõi điểm đến",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => DestinationListWidget(
                                destinations: widget.destinations,
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text("Xem",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              mapState.clearRoute();
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.clear, color: Colors.red),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              if (mapState.driverLocation.value != null) {
                mapController.moveAndRotate(
                  mapState.driverLocation.value!,
                  15.0,
                  0,
                );
              }
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.person_pin_circle, color: Colors.blue),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              if (widget.destinations.isNotEmpty) {
                final firstDestination = widget.destinations.first;
                mapController.moveAndRotate(
                  LatLng(firstDestination.latitude, firstDestination.longitude),
                  14.0,
                  0,
                );
              }
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.location_on, color: Colors.green),
          ),
          SizedBox(height: 150),
        ],
      ),
    );
  }
}
