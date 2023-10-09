import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../screens/drawer_screens/about_us_screen.dart';
import '../screens/drawer_screens/contact_us_screen.dart';
import '../screens/drawer_screens/faq_screen.dart';
import '../screens/drawer_screens/policies_screen.dart';
import '../screens/drawer_screens/profile_screen.dart';
import '../screens/main_grid_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late Future<DocumentSnapshot> dataFuture;

  CollectionReference? user = FirebaseFirestore.instance.collection('users');
  String? docId = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      dataFuture = user!.doc(docId).get();
      buildHeader(context);
      buildMenuItems(context);
    });
  }

  Widget buildHeader(BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      return Container(
        color: Colors.lightGreen[700],
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 70,
          bottom: 14,
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 70,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Not Logged In',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  text: 'Login/SignUp',
                  style: const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      FirebaseAuth.instance.signOut();
                    }),
            ),
          ],
        ),
      );
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future: dataFuture,
        builder:
            ((BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (snapshot.hasError) {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Text([snapshot.error.toString()] as String),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(
                  ProfileScreen.routeName,
                );
              },
              child: Container(
                color: Colors.lightGreen[700],
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 26,
                  bottom: 14,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      data['name'],
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${FirebaseAuth.instance.currentUser!.email.toString()} ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

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
        }),
      );
    }
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Wrap(
        runSpacing: 1,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                MainGridScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                AboutUsScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                ContactUsScreen.routeName,
              );
            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: const Text('Policies'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                PoliciesScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('FAQs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                FaqScreen.routeName,
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                ),
              ),
            ],
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Color.fromARGB(255, 116, 18, 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
