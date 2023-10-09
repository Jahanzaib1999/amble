import 'package:flutter/material.dart';

import '../../models/recreation_data_model.dart';

class RecreationDetailScreen extends StatelessWidget {
  static const routeName = '/recreation-detail';

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  RecreationDetailScreen();

  @override
  Widget build(BuildContext context) {
    Features spaceId = ModalRoute.of(context)!.settings.arguments as Features;
    // ignore: unused_local_variable
    return Scaffold(
      appBar: AppBar(
        title: Text(spaceId.properties!.name.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Container(
                color: Colors.red,
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
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.5,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Address: ${spaceId.properties!.address}, ${spaceId.properties!.suburb}, ${spaceId.properties!.postcode}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Phone Number: ${spaceId.properties!.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      color: const Color.fromARGB(255, 240, 144, 144),
                      child: const Text(
                        'Recreation Centre',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.grey,
                      child: Text(
                        'Opening Hours: ${spaceId.properties!.openingHours}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
