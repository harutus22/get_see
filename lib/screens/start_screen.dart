import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_see/screens/favourites_screen.dart';
import 'package:get_see/screens/fresh_films_screen.dart';
import 'package:get_see/screens/policy_screen.dart';
import 'package:get_see/screens/random_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/start_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Image.asset(
              "assets/images/name_top.png",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RandomScreen.routeName);
                  },
                  child: Image.asset("assets/images/what_see.png")),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FreshFilmsScreen.routeName);
                  },
                  child: Image.asset("assets/images/new.png")),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FavouriteScreen.routeName);
                  },
                  child: Image.asset("assets/images/favourites.png")),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FlatButton(
                            onPressed: () {},
                            height: 20,
                            child: Image.asset("assets/images/vk.png")),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FlatButton(
                            onPressed: () {},
                            height: 20,
                            child: Image.asset("assets/images/google.png")),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
              child: Text("Вход / Регистрация"),
            onTap: (){

            },
          ),
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, PolicyScreen.routeName);
                  },
                  child: Text(
                    "Политика Конфиденциальности",
                    style: TextStyle(
                    decoration: TextDecoration.underline
                  ),),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
