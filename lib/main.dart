import 'package:flutter/material.dart';
import 'package:get_see/screens/favourites_screen.dart';
import 'package:get_see/screens/fresh_detaily_screen.dart';
import 'package:get_see/screens/fresh_films_screen.dart';
import 'package:get_see/screens/policy_screen.dart';
import 'package:get_see/screens/random_screen.dart';
import 'package:get_see/screens/splash_screen.dart';
import 'package:get_see/screens/start_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: StartScreen(),
    routes: {
      Splash.routeName: (context) => Splash(),
      StartScreen.routeName: (context) => StartScreen(),
      RandomScreen.routeName: (context) => RandomScreen(),
      FreshFilmsScreen.routeName: (context) => FreshFilmsScreen(),
      DetailedScreen.routeName: (context) => DetailedScreen(),
      FavouriteScreen.routeName: (context) => FavouriteScreen(),
      PolicyScreen.routeName: (context) => PolicyScreen(),
    },
  ));
}
