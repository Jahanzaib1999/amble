import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Services/utilities/states_services.dart';
import '../../models/swimming_data_model.dart';
import '../../sydney_lga_data.dart';

class SwimmingMapView extends StatefulWidget {
  static const routeName = '/swimming-map';

  // ignore: use_key_in_widget_constructors
  const SwimmingMapView();

  @override
  State<SwimmingMapView> createState() => _SwimmingMapViewState();
}

class _SwimmingMapViewState extends State<SwimmingMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-33.880678, 151.21272),
    zoom: 12.5,
  );

  Set<Marker> markers = {};

  late BitmapDescriptor icon;

  Set<Polygon> polygon = <Polygon>{};

  List<LatLng> points = [];

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    for (var i in SydneyLgaData.data) {
      points.add(
        LatLng(
          i[1],
          i[0],
        ),
      );
    }
    polygon.add(
      Polygon(
        polygonId: const PolygonId('Sydney LGA'),
        geodesic: true,
        fillColor: Colors.lightBlueAccent.withOpacity(0.3),
        points: points,
        strokeWidth: 2,
        consumeTapEvents: true,
        strokeColor: Colors.blue,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Sydney LGA',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.teal,
              elevation: 10,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(20),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Expanded(
      child: FutureBuilder<SwimmingDataModel>(
        future: statesServices.fetchSwimmingPoolData(),
        builder: ((context, AsyncSnapshot<SwimmingDataModel> snapshot) {
          if (snapshot.hasData) {
            for (var i in snapshot.data!.features!) {
              markers.add(
                Marker(
                  markerId: MarkerId(i.properties!.objectid.toString()),
                  position: LatLng(
                    i.geometry!.coordinates![1],
                    i.geometry!.coordinates![0],
                  ),
                  infoWindow: InfoWindow(
                    title: i.properties?.name,
                    snippet: i.properties?.details,
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                ),
              );
            }

            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _cameraPosition,
              markers: markers,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              compassEnabled: true,
              myLocationEnabled: true,
              polygons: polygon,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
