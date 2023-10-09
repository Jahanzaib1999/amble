import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../Services/utilities/states_services.dart';
import '../../models/venue_data_model.dart';
import 'venue_detail_screen.dart';

class VenueListView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const VenueListView();

  @override
  State<VenueListView> createState() => _VenueListViewState();
}

class _VenueListViewState extends State<VenueListView> {
  List<Features>? venues = [];
  Position? _position;
  Future<VenueDataModel> statesServices = StatesServices().fetchVenueData();

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  getDistance(double spaceLat, double spaceLng) {
    double? distance = 0.0;

    distance = Geolocator.distanceBetween(
      _position!.latitude,
      _position!.longitude,
      spaceLat,
      spaceLng,
    );

    return (distance / 1000);
  }

  @override
  void initState() {
    _determinePosition();
    _getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VenueDataModel>(
      future: statesServices,
      builder: (context, AsyncSnapshot<VenueDataModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          for (var i in snapshot.data!.features!) {
            i.distance = getDistance(
              i.geometry!.coordinates![1],
              i.geometry!.coordinates![0],
            );
            venues!.add(i);
          }
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                venues!.sort(
                  (a, b) {
                    return a.distance!.compareTo(b.distance!);
                  },
                );
                return GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushNamed(
                      VenueDetailScreen.routeName,
                      arguments: venues![index],
                    );
                  },
                  child: Card(
                    borderOnForeground: true,
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            color: Colors.blueGrey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    venues![index].properties!.name.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.blueGrey,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Venue in ${venues![index].properties!.suburb.toString()}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Approx. distance ${venues![index].distance!.toStringAsFixed(2)} KM',
                                  style: const TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: venues!.length,
              shrinkWrap: true,
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
