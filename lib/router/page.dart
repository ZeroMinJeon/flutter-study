import 'package:flutter/material.dart';
import 'package:flutter3study/detail_screen/detail_screen.dart';

class DetailsPage extends Page {
  final int index;

  DetailsPage({
    required this.index,
  }) : super(key: ValueKey(index));

  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
        final curveTween = CurveTween(curve: Curves.easeInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: DetailScreen(
            key: ValueKey(index),
            index: index,
          ),
        );
      },
    );
  }
}