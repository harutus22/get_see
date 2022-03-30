import 'package:flutter/material.dart';
import 'package:get_see/screens/start_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {

  static const routeName = '/splash_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SplashScreen(
          seconds: 3,
          imageBackground: AssetImage("assets/images/splash.png"),
          useLoader: false,
          navigateAfterSeconds: StartScreen(),
      ),
    );
  }
}
