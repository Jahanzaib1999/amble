import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Services/utilities/states_services.dart';
import '../../models/venue_data_model.dart';
import '../../sydney_lga_data.dart';
import 'venue_detail_screen.dart';

class VenueMapView extends StatefulWidget {
  static const routeName = '/venue-map';

  // ignore: use_key_in_widget_constructors
  const VenueMapView();

  @override
  State<VenueMapView> createState() => _VenueMapViewState();
}

class _VenueMapViewState extends State<VenueMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-33.880678, 151.212720),
    zoom: 12.5,
  );

  Set<Marker> markers = {};

  Set<Polygon> polygon = <Polygon>{};

  List<LatLng> points = [];

  late BitmapDescriptor icon;

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
        fillColor: Colors.cyan.withOpacity(0.2),
        points: points,
        strokeWidth: 2,
        visible: true,
        strokeColor: Colors.cyan,
        consumeTapEvents: true,
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
      child: FutureBuilder<VenueDataModel>(
        future: statesServices.fetchVenueData(),
        builder: (context, AsyncSnapshot<VenueDataModel> snapshot) {
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
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        VenueDetailScreen.routeName,
                        arguments: snapshot.data!.features as Features,
                      );
                    },
                    title: i.properties?.name,
                    snippet: 'Venue in  ${i.properties!.suburb}',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueCyan),
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
        },
      ),
    );
  }
}
