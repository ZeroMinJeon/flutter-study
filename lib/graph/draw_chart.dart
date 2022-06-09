import 'package:flutter/material.dart';

class DrawChartScreen extends StatelessWidget {
  DrawChartScreen({Key? key}) : super(key: key);

  List<Offset> spots1 = [
    Offset(0, 200),
    Offset(30, 120),
    Offset(20, 160),
    Offset(40, 80),
    Offset(10, 90),
    Offset(60, 180),
    Offset(50, 140),
  ];
  List<Offset> spots2 = [
    Offset(0, 180),
    Offset(30, 70),
    Offset(20, 120),
    Offset(40, 50),
    Offset(10, 50),
    Offset(60, 140),
    Offset(50, 90),
  ];
  List<Offset> spots3 = [
    Offset(0, 160),
    Offset(30, 50),
    Offset(20, 100),
    Offset(40, 40),
    Offset(10, 45),
    Offset(60, 120),
    Offset(50, 80),
  ];
  List<Offset> spots4 = [
    Offset(0, 140),
    Offset(30, 40),
    Offset(20, 90),
    Offset(40, 30),
    Offset(10, 35),
    Offset(60, 100),
    Offset(50, 70),
  ];
  List<Offset> spots5 = [
    Offset(0, 100),
    Offset(30, 30),
    Offset(20, 60),
    Offset(40, 20),
    Offset(10, 15),
    Offset(60, 80),
    Offset(50, 50),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: CustomPaint(
          painter: _DrawChart(
            valueSpots1: spots1,
            valueSpots2: spots2,
            valueSpots3: spots3,
            valueSpots4: spots4,
            valueSpots5: spots5,
            upperThreshold: 140,
            lowerThreshold: 70,
          ),
        ),
      ),
    );
  }
}

class _DrawChart extends CustomPainter {
  final List<Offset> valueSpots1;
  final List<Offset> valueSpots2;
  final List<Offset> valueSpots3;
  final List<Offset> valueSpots4;
  final List<Offset> valueSpots5;
  final double upperThreshold;
  final double lowerThreshold;

  double maxWidth = 0;

  _DrawChart(
      {required this.valueSpots1,
      required this.valueSpots2,
      required this.valueSpots3,
      required this.valueSpots4,
      required this.valueSpots5,
      required this.upperThreshold,
      required this.lowerThreshold});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var upperSpots1 = calculatedAndAddNewSpot(valueSpots1);
    var upperSpots2 = calculatedAndAddNewSpot(valueSpots2);
    var centerSpots = calculatedAndAddNewSpot(valueSpots3);
    var lowerSpots1 = calculatedAndAddNewSpot(valueSpots4);
    var lowerSpots2 = calculatedAndAddNewSpot(valueSpots5);

    Paint paint = Paint()
      ..color = Colors.indigoAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path1 = Path();

    //upper1 - lower 2
    paint..color = Colors.blueAccent.shade100;
    paint..style = PaintingStyle.fill;
    path1 = Path()
      ..addPolygon(collectMediumPolygon(upperSpots1, lowerSpots2, size), true);
    canvas.drawPath(path1, paint);

    paint..color = Colors.redAccent.shade100;
    for (var polygon
        in collectUpperPolygon(upperSpots1, size, upperThreshold)) {
      Path path = Path();
      paint..style = PaintingStyle.fill;
      path.addPolygon(polygon, true);
      canvas.drawPath(path, paint);
    }

    paint..color = Colors.yellowAccent.shade100;
    for (var polygon
        in collectLowerPolygon(lowerSpots2, size, lowerThreshold)) {
      Path path = Path();
      paint..style = PaintingStyle.fill;
      path.addPolygon(polygon, true);
      canvas.drawPath(path, paint);
    }

    //upper2 - lower 1
    paint..color = Colors.blueAccent.shade400;
    paint..style = PaintingStyle.fill;
    path1 = Path()
      ..addPolygon(collectMediumPolygon(upperSpots2, lowerSpots1, size), true);
    canvas.drawPath(path1, paint);

    paint..color = Colors.redAccent.shade400;
    for (var polygon
        in collectUpperPolygon(upperSpots2, size, upperThreshold)) {
      Path path = Path();
      paint..style = PaintingStyle.fill;
      path.addPolygon(polygon, true);
      canvas.drawPath(path, paint);
    }

    paint..color = Colors.yellowAccent.shade400;
    for (var polygon
        in collectLowerPolygon(lowerSpots1, size, lowerThreshold)) {
      Path path = Path();
      paint..style = PaintingStyle.fill;
      path.addPolygon(polygon, true);
      canvas.drawPath(path, paint);
    }

    //center
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    path1 = Path()
      ..addPolygon(calculatedPositionOfSpotList(centerSpots, size), false);
    canvas.drawPath(path1, paint);
    // paint..color = Colors.redAccent;
    paint.color = Colors.black;
    for (var polygon
        in collectUpperPolygon(centerSpots, size, upperThreshold)) {
      Path path = Path();
      paint..style = PaintingStyle.stroke;
      path.addPolygon(polygon, false);
      canvas.drawPath(path, paint);
    }
    // paint..color = Colors.yellowAccent;
    paint.color = Colors.black;
    for (var polygon
        in collectLowerPolygon(centerSpots, size, lowerThreshold)) {
      Path path = Path();
      paint..style = PaintingStyle.stroke;
      path.addPolygon(polygon, false);
      canvas.drawPath(path, paint);
    }

    //draw threshold line
    paint..color = Colors.blue;
    path1 = Path()
      ..addPolygon([
        Offset(0, size.height - 50 - upperThreshold),
        Offset(size.width, size.height - 50 - upperThreshold)
      ], false);
    canvas.drawPath(path1, paint);
    paint..color = Colors.orangeAccent;
    path1 = Path()
      ..addPolygon([
        Offset(0, size.height - 50 - lowerThreshold),
        Offset(size.width, size.height - 50 - lowerThreshold)
      ], false);
    canvas.drawPath(path1, paint);
  }

  List<Offset> calculatedAndAddNewSpot(List<Offset> spots) {
    List<Offset> newSpots = [];
    List<Offset> sortSpots = []..addAll(spots);
    sortSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    for (int i = 0; i < sortSpots.length - 1; i++) {
      var a = (sortSpots[i].dy - sortSpots[i + 1].dy) /
          (sortSpots[i].dx - sortSpots[i + 1].dx);
      var b = sortSpots[i].dy - a * sortSpots[i].dx;
      var x1 = (upperThreshold - b) / a;
      var x2 = (lowerThreshold - b) / a;
      if (sortSpots[i].dx < x1 && x1 < sortSpots[i + 1].dx) {
        newSpots.add(Offset(x1, upperThreshold));
      }
      if (sortSpots[i].dx < x2 && x2 < sortSpots[i + 1].dx) {
        newSpots.add(Offset(x2, lowerThreshold));
      }
    }
    sortSpots.addAll(newSpots);
    sortSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    maxWidth = spots.last.dx > maxWidth ? spots.last.dx : maxWidth;
    return sortSpots;
  }

  List<List<Offset>> collectUpperPolygon(
      List<Offset> spots, Size size, double threshold) {
    List<List<Offset>> polygons = [];
    var startStatus = true;
    var isFirst = true;
    List<Offset> polygon = [];

    for (int i = 0; i < spots.length; i++) {
      if (startStatus) {
        if (spots[i].dy >= threshold) {
          polygon.add(calculatedPositionSpot(spots[i], size));
          startStatus = false;
        }
        continue;
      }

      if (polygon.length == 1) {
        if (spots[i].dy < threshold) {
          startStatus = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(spots[i], size));
        }
        continue;
      } else {
        if (spots[i].dy < threshold) {
          if (isFirst) {
            polygon.add(calculatedPositionSpot(Offset(0, threshold), size));
            isFirst = false;
          }
          polygons.add(polygon);
          startStatus = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(spots[i], size));
        }
      }
      continue;
    }
    if (polygon.isNotEmpty) {
      polygon
          .add(calculatedPositionSpot(Offset(spots.last.dx, threshold), size));
      polygons.add(polygon);
    }
    return polygons;
  }

  List<Offset> collectMediumPolygon(
      List<Offset> spots, List<Offset> centerSpots, Size size) {
    List<Offset> ploygon = [];
    List<Offset> backSortedCenterSpots = []
      ..addAll(centerSpots)
      ..sort((a, b) => a.dx < b.dx ? 1 : 0);
    ploygon.addAll(spots);
    ploygon.addAll(backSortedCenterSpots);
    return calculatedPositionOfSpotList(ploygon, size);
  }

  List<List<Offset>> collectLowerPolygon(
      List<Offset> spots, Size size, double threshold) {
    List<List<Offset>> polygons = [];
    var isFirst = true;
    List<Offset> polygon = [];

    for (int i = 0; i < spots.length; i++) {
      if (isFirst) {
        if (spots[i].dy <= threshold) {
          polygon.add(calculatedPositionSpot(spots[i], size));
          isFirst = false;
        }
        continue;
      }

      if (polygon.length == 1) {
        if (spots[i].dy > threshold) {
          isFirst = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(spots[i], size));
        }
        continue;
      } else {
        if (spots[i].dy > threshold) {
          if (isFirst) {
            polygon.add(calculatedPositionSpot(Offset(0, threshold), size));
            isFirst = false;
          }
          polygons.add(polygon);
          isFirst = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(spots[i], size));
        }
      }
      continue;
    }
    if (polygon.isNotEmpty) {
      polygon
          .add(calculatedPositionSpot(Offset(spots.last.dx, threshold), size));
      polygons.add(polygon);
    }
    return polygons;
  }

  List<Offset> calculatedPositionOfSpotList(List<Offset> spots, Size size) {
    var height = size.height - 50;
    return spots
        .map((spot) =>
            Offset(spot.dx * size.width / (maxWidth + 50), (height - spot.dy)))
        .toList();
  }

  Offset calculatedPositionSpot(Offset spot, Size size) {
    var height = size.height - 50;
    return Offset(spot.dx * size.width / (maxWidth + 50), (height - spot.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
