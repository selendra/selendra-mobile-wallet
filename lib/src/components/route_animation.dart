import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class RouteAnimation extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  final String routeName;
  RouteAnimation({this.enterPage, this.exitPage, this.routeName})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => exitPage,
            transitionDuration: Duration(milliseconds: 300),
            settings: RouteSettings(name: routeName),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeThroughTransition(
                      child: enterPage,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,

                      //     Stack(
                      //   children: [
                      //     SlideTransition(
                      //       position: new Tween<Offset>(
                      //         begin: const Offset(0.0, 0.0),
                      //         end: const Offset(-1.0, 0.0),
                      //       ).animate(animation),
                      //       child: exitPage,
                      //     ),
                      //     SlideTransition(
                      //       position: Tween<Offset>(
                      //         begin: const Offset(1.0, 0.0),
                      //         end: Offset.zero,
                      //       ).animate(animation),
                      //       child: enterPage,
                      //     ),
                      //   ],
                      // ),
                    ));
}
