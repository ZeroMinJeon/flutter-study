import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  Color colorOne = Colors.red;
  Color colorTwo = Colors.red.shade300;
  Color colorThree = Colors.red.shade100;

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width / 15;
    var height = size.height / 25;
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.strokeCap = StrokeCap.round;
    List<Offset> offsets = [
      Offset(1 * width, 5 * height),
      Offset(2 * width, 10 * height),
      Offset(4 * width, 12 * height),
      Offset(5 * width, 9 * height),
      Offset(6 * width, 3 * height),
      Offset(7 * width, 4 * height),
      Offset(8 * width, 2 * height),
    ];
    offsets = offsets
        .map((offset) => Offset(offset.dx, size.height - offset.dy))
        .toList();
    paint.color = colorTwo;
    for (var index = 0; index < offsets.length; index++) {
      if (index == 0) {
        canvas.drawLine(Offset(0, size.height), offsets[0], paint);
      } else {
        canvas.drawLine(offsets[index - 1], offsets[index], paint);
      }
    }


  }

  void drawPath(List<Offset> offsets, Size size, Canvas canvas, Paint paint) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
