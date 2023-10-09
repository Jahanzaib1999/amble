import 'package:flutter/material.dart';

import '../../widgets/custom_switch.dart';
import 'playground_list_view.dart';
import 'playground_map_view.dart';

// ignore: camel_case_types
enum view {
  listView,
  mapView,
}

class PlaygroundSpaceScreen extends StatefulWidget {
  static const routeName = '/playground-spaces-screen';
  final String cardText;

  const PlaygroundSpaceScreen({super.key, required this.cardText});

  @override
  State<PlaygroundSpaceScreen> createState() => _PlaygroundSpaceScreenState();
}

class _PlaygroundSpaceScreenState extends State<PlaygroundSpaceScreen> {
  bool _listMapSwitch = false;
  // ignore: prefer_final_fields
  bool _recommendNearSwitch = false;

  Widget viewContainer = const PlaygroundListView();

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
                      Colors.green,
                      Colors.yellow,
                      Colors.green,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 40,
                alignment: Alignment.center,
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
        viewContainer = const PlaygroundMapView();
      });
    } else {
      setState(() {
        viewContainer = const PlaygroundListView();
      });
    }
  }
}
