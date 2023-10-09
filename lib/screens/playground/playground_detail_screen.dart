import 'package:flutter/material.dart';

import '../../models/playground_data_model.dart';

// ignore: use_key_in_widget_constructors
class PlaygroundDetailScreen extends StatelessWidget {
  static const routeName = '/playground-detail';

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  PlaygroundDetailScreen();

  @override
  Widget build(BuildContext context) {
    Features spaceId = ModalRoute.of(context)!.settings.arguments as Features;
    // ignore: unused_local_variable
    return Scaffold(
      appBar: AppBar(
        title: Text(spaceId.properties!.name.toString()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Container(
              color: const Color.fromARGB(255, 32, 130, 35),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spaceId.properties!.name.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 17, 7),
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5,
                    overflow: TextOverflow.clip,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: const Color.fromARGB(255, 175, 223, 148),
                    child: Text(
                      spaceId.properties!.type.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 65, 61, 61),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
