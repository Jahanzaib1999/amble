import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Services/utilities/states_services.dart';
import '../../models/recreation_data_model.dart';
import '../../sydney_lga_data.dart';
import 'recreation_detail_screen.dart';

class RecreationMapView extends StatefulWidget {
  static const routeName = '/recreation-map';

  // ignore: use_key_in_widget_constructors
  const RecreationMapView();

  @override
  State<RecreationMapView> createState() => _RecreationMapViewState();
}

class _RecreationMapViewState extends State<RecreationMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-33.880678, 151.212720),
    zoom: 12.5,
  );

  Set<Marker> markers = {};

  Set<Polygon> polygon = <Polygon>{};

  List<LatLng> points = [];

  late BitmapDescriptor icon;

  // late Uint8 markerImage;

  // Future<Uint8> getBytesfromAssets(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(
  //     data.buffer.asUint8List(),
  //     targetHeight: width,
  //   );
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.;
  // }

  // getIcons() async {
  //   var icon = await BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration(size: Size(0.1, 0.1)),
  //     "assets/images/park.png",
  //   );
  //   setState(() {
  //     this.icon = icon;
  //   });
  // }

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
        fillColor: Colors.red.withOpacity(0.25),
        points: points,
        strokeWidth: 2,
        consumeTapEvents: true,
        strokeColor: Colors.red,
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
      child: FutureBuilder<RecreationDataModel>(
        future: statesServices.fetchRecreationData(),
        builder: (context, AsyncSnapshot<RecreationDataModel> snapshot) {
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
                        RecreationDetailScreen.routeName,
                        arguments: snapshot.data!.features as Features,
                      );
                    },
                    title: i.properties?.name,
                    snippet: 'Recreation Centre in ${i.properties!.suburb}',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
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
