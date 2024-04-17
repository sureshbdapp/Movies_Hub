import 'package:flutter/material.dart';

const String baseUrl = " https://api.themoviedb.org/3";
navigation(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

Route createRoute(Widget className) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => className,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
