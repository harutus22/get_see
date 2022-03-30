import 'package:flutter/material.dart';
import 'package:get_see/db_helper.dart';
import 'package:get_see/movie_model.dart';

class Heart extends StatefulWidget {
  MovieModel movie;
  bool isFavorite = false;
  Heart({this.movie, this.isFavorite});

  @override
  _HeartState createState() => _HeartState(movieModel: movie, passedFromFav: isFavorite);
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  MovieModel movieModel;
  bool passedFromFav = false;

  _HeartState({this.movieModel, this.passedFromFav});

  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  bool isFav = false;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.blue)
        .animate(_controller);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_controller);

    _controller.addListener(() {
      print(_controller.value);
      print(_colorAnimation.value);

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {

          setState(() {
            isFav = true;
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            isFav = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(passedFromFav) {
      _controller.forward();
      passedFromFav = false;
    }
    return AnimatedBuilder(
      key: _formKey,
      animation: _controller,
      builder: (BuildContext context, _) {
        return Transform.scale(
          scale: 1.5,
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: _sizeAnimation.value,
            ),
            onPressed: () {
              if(isFav) {
                var dbHelper = DBHelper();
                dbHelper.deleteMovie(movieModel);
                _controller.reverse();
              } else {
                var dbHelper = DBHelper();
                dbHelper.addNewMovie(movieModel);
                _controller.forward();
              }
            },
          ),
        );
      },
    );
  }
}
