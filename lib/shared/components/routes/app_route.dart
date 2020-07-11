import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static PageRoute<T> getAppRoute<T>(Widget page) {
    return CupertinoPageRoute<T>(builder: (BuildContext context) => page);
  }

  static PageRoute<T> getSlideUpRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (BuildContext context, animation, _) => page,
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 1.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
  }
}