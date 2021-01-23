import 'package:flutter/material.dart';

class RouteAnimation extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  RouteAnimation({this.enterPage, this.exitPage})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => exitPage,
          transitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              Stack(
            children: [
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              ),
            ],
          ),
        );
}
