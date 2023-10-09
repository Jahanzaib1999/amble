import 'package:flutter/material.dart';

import '../../widgets/custom_switch.dart';
import 'venue_list_view.dart';
import 'venue_map_view.dart';

enum View {
  listView,
  mapView,
}

class VenueSpaceScreen extends StatefulWidget {
  static const routeName = '/venue-spaces-screen';
  final String cardText;

  const VenueSpaceScreen({super.key, required this.cardText});

  @override
  State<VenueSpaceScreen> createState() => _VenueSpaceScreenState();
}

class _VenueSpaceScreenState extends State<VenueSpaceScreen> {
  bool _listMapSwitch = false;
  // ignore: prefer_final_fields
  bool _recommendNearSwitch = false;

  Widget viewContainer = const VenueListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: widget.cardText,
            child: Card(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey,
                      Colors.lightBlueAccent,
                      Colors.blueGrey,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 40,
                alignment: Alignment.center,
                //color: Colors.teal[100 * (index % 9)],
                child: Text(
                  widget.cardText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Card(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Text('List'),
                    CustomSwitch.customSwitch(
                        context: context,
                        value: _listMapSwitch,
                        onToggle: (bool value) {
                          _listMapSwitch = value;
                          selectView(
                            value,
                          );
                        }),
                    const Text('Map'),
                    const Spacer(),
                    if (!_listMapSwitch)
                      const VerticalDivider(
                        color: Colors.grey,
                        endIndent: 5,
                        indent: 5,
                        thickness: 1.5,
                      ),
                    if (!_listMapSwitch) const Spacer(),
                    if (!_listMapSwitch) const Text('Nearest'),
                    if (!_listMapSwitch)
                      CustomSwitch.customSwitch(
                        context: context,
                        value: _recommendNearSwitch,
                        onToggle: (bool value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(
                                seconds: 2,
                              ),
                              backgroundColor: Colors.grey,
                              content: Text(
                                'This feature is coming soon',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    if (!_listMapSwitch) const Text('Ratings'),
                  ],
                ),
              ),
            ),
          ),
          viewContainer,
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    selectView(_listMapSwitch);
  }

  void selectView(
    bool value,
  ) {
    if (value == true) {
      setState(() {
        viewContainer = const VenueMapView();
      });
    } else {
      setState(() {
        viewContainer = const VenueListView();
      });
    }
  }
}
