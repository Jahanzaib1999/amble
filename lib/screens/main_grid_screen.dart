import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';
import 'gardens/garden_space_screen.dart';
import 'libraryScreens/library_space_screen.dart';
import 'playground/playground_space_screen.dart';
import 'recreation/recreation_space_screen.dart';
import 'swimming/swimming_space_screen.dart';
import 'venues/venue_space_screen.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class MainGridScreen extends StatelessWidget {
  static const routeName = '/main-grid-screen';

  List<String> spaceList = [
    'Playgrounds',
    'Swimming Pools',
    'Community Gardens',
    'Libraries',
    'Venues For Hire',
    'Recreation Centers',
  ];

  // ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black.withOpacity(0.1),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
        title: Image.asset(
          'assets/images/logo/amble.png',
          fit: BoxFit.fitHeight,
          height: kToolbarHeight * 0.9,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                //shadowColor: Colors.purpleAccent,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.yellow,
                        Colors.lightGreen,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'EXPLORE SPACES AROUND YOU',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
              ),
              buildImageCard(
                context,
                spaceList[0],
                'assets/images/playground.jpg',
                spaceList.indexOf(
                  spaceList[0],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
              ),
              buildImageCard(
                context,
                spaceList[1],
                'assets/images/swimming.png',
                spaceList.indexOf(
                  spaceList[1],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
              ),
              buildImageCard(
                context,
                spaceList[2],
                'assets/images/garden.jpg',
                spaceList.indexOf(
                  spaceList[2],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
              ),
              buildImageCard(
                context,
                spaceList[3],
                'assets/images/library.jfif',
                spaceList.indexOf(
                  spaceList[3],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
              ),
              buildImageCard(
                context,
                spaceList[4],
                'assets/images/venue.jpg',
                spaceList.indexOf(
                  spaceList[4],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
              ),
              buildImageCard(
                context,
                spaceList[5],
                'assets/images/recreation.jpeg',
                spaceList.indexOf(
                  spaceList[5],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
              ),
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      //backgroundColor: Colors.grey,
    );
  }
}

Widget buildImageCard(
  BuildContext context,
  String cardText,
  String imagePath,
  int index,
) {
  return InkWell(
    onTap: () {
      if (index == 0) {
        Navigator.of(context).pushNamed(
          PlaygroundSpaceScreen.routeName,
          arguments: cardText,
        );
      } else if (index == 1) {
        Navigator.of(context).pushNamed(
          SwimmingSpaceScreen.routeName,
          arguments: cardText,
        );
      } else if (index == 2) {
        Navigator.of(context).pushNamed(
          GardenSpaceScreen.routeName,
          arguments: cardText,
        );
      } else if (index == 3) {
        Navigator.of(context).pushNamed(
          LibrarySpaceScreen.routeName,
          arguments: cardText,
        );
      } else if (index == 4) {
        Navigator.of(context).pushNamed(
          VenueSpaceScreen.routeName,
          arguments: cardText,
        );
      } else if (index == 5) {
        Navigator.of(context).pushNamed(
          RecreationSpaceScreen.routeName,
          arguments: cardText,
        );
      }
    },
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      elevation: 8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(imagePath),
            colorFilter: ColorFilter.mode(
              Colors.grey.withOpacity(0.4),
              BlendMode.saturation,
            ),
            height: 180,
            fit: BoxFit.cover,
            child: Center(
              child: Container(
                color: Colors.grey.withOpacity(0.6),
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                child: Text(
                  cardText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                    //backgroundColor: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
