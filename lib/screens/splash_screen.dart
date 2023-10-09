import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  // static const routeName = '/splash-screen';
  final Widget nextScreen;

  const SplashScreen({
    Key? key,
    required this.nextScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo/amble.png',
          ),
          const Text(
            'Connecting you to\noutdoor spaces, nature\nand activities',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
      splashIconSize: 300,
      centered: true,
      duration: 1000,
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 800),
      backgroundColor: Colors.lightGreen.shade800,
    );
  }
}
