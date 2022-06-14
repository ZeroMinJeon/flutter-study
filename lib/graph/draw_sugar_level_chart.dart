import 'dart:ui';

import 'package:flutter/material.dart';

class DrawSugarLevelChartScreen extends StatelessWidget {
  DrawSugarLevelChartScreen({Key? key}) : super(key: key);

  List<Offset> spots1 = [
    const Offset(0, 250),
    const Offset(30, 220),
    const Offset(20, 160),
    const Offset(40, 100),
    const Offset(10, 90),
    const Offset(60, 180),
    const Offset(50, 140),
    const Offset(80, 70),
    const Offset(70, 60),
    const Offset(90, 100),
    const Offset(100, 130),
    const Offset(110, 60),
    const Offset(120, 180),
    const Offset(130, 180),
    const Offset(140, 120),
    const Offset(150, 60),
    const Offset(160, 55),
    const Offset(170, 120),
    const Offset(190, 115),
    const Offset(180, 110),
  ];
  List<Offset> spots2 = [
    const Offset(0, 230),
    const Offset(30, 210),
    const Offset(20, 120),
    const Offset(40, 90),
    const Offset(10, 70),
    const Offset(60, 160),
    const Offset(50, 120),
    const Offset(80, 70),
    const Offset(70, 50),
    const Offset(90, 85),
    const Offset(100, 114),
    const Offset(110, 55),
    const Offset(120, 170),
    const Offset(130, 175),
    const Offset(140, 115),
    const Offset(150, 55),
    const Offset(160, 50),
    const Offset(170, 115),
    const Offset(190, 110),
    const Offset(180, 105),
  ];
  List<Offset> spots3 = [
    const Offset(0, 160),
    const Offset(30, 180),
    const Offset(20, 100),
    const Offset(40, 40),
    const Offset(10, 45),
    const Offset(60, 140),
    const Offset(50, 80),
    const Offset(80, 60),
    const Offset(70, 40),
    const Offset(90, 65),
    const Offset(100, 104),
    const Offset(110, 50),
    const Offset(120, 165),
    const Offset(130, 170),
    const Offset(140, 110),
    const Offset(150, 50),
    const Offset(160, 49),
    const Offset(170, 110),
    const Offset(190, 105),
    const Offset(180, 100),
  ];
  List<Offset> spots4 = [
    const Offset(0, 140),
    const Offset(30, 120),
    const Offset(20, 90),
    const Offset(40, 30),
    const Offset(10, 35),
    const Offset(60, 100),
    const Offset(50, 70),
    const Offset(80, 50),
    const Offset(70, 35),
    const Offset(90, 60),
    const Offset(100, 95),
    const Offset(110, 40),
    const Offset(120, 150),
    const Offset(130, 155),
    const Offset(140, 100),
    const Offset(150, 40),
    const Offset(160, 40),
    const Offset(170, 105),
    const Offset(190, 100),
    const Offset(180, 95),
  ];
  List<Offset> spots5 = [
    const Offset(0, 100),
    const Offset(30, 100),
    const Offset(20, 60),
    const Offset(40, 20),
    const Offset(10, 15),
    const Offset(60, 80),
    const Offset(50, 50),
    const Offset(80, 35),
    const Offset(70, 25),
    const Offset(90, 50),
    const Offset(100, 80),
    const Offset(110, 30),
    const Offset(120, 140),
    const Offset(130, 140),
    const Offset(140, 90),
    const Offset(150, 30),
    const Offset(160, 30),
    const Offset(170, 100),
    const Offset(190, 95),
    const Offset(180, 90),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width + 400,
          height: 400,
          child: CustomPaint(
            painter: _SugarLevelDrawChart(
              valueSpots1: spots1,
              valueSpots2: spots2,
              valueSpots3: spots3,
              valueSpots4: spots4,
              valueSpots5: spots5,
              upperThreshold: 130,
              lowerThreshold: 70,
            ),
          ),
        ),
      ),
    );
  }
}

class _SugarLevelDrawChart extends CustomPainter {
  final List<Offset> valueSpots1;
  final List<Offset> valueSpots2;
  final List<Offset> valueSpots3;
  final List<Offset> valueSpots4;
  final List<Offset> valueSpots5;
  final double upperThreshold;
  final double lowerThreshold;

  double xSeperatedNum = 0;
  double ySeperatedNum = 350;
  double bottomWidgetSize = 100;
  double leftPaddingSize = 100;

  _SugarLevelDrawChart(
      {required this.valueSpots1,
      required this.valueSpots2,
      required this.valueSpots3,
      required this.valueSpots4,
      required this.valueSpots5,
      required this.upperThreshold,
      required this.lowerThreshold});

  @override
  void paint(Canvas canvas, Size size) {
    var upperSpots1 = calculatedAndAddNewSpot(valueSpots1);
    var upperSpots2 = calculatedAndAddNewSpot(valueSpots2);
    // var centerSpots = calculatedAndAddNewSpot(valueSpots3);
    var lowerSpots1 = calculatedAndAddNewSpot(valueSpots4);
    var lowerSpots2 = calculatedAndAddNewSpot(valueSpots5);
    var chartHeight = size.height - bottomWidgetSize;
    var upperLineThreshold = [
      Offset(leftPaddingSize,
          (chartHeight - upperThreshold) * chartHeight / ySeperatedNum),
      Offset(size.width,
          (chartHeight - upperThreshold) * chartHeight / ySeperatedNum)
    ];
    var lowerLineThreshold = [
      Offset(leftPaddingSize,
          (chartHeight - lowerThreshold) * chartHeight / ySeperatedNum),
      Offset(size.width,
          (chartHeight - lowerThreshold) * chartHeight / ySeperatedNum)
    ];
    var zeroLineSpots = [
      Offset(leftPaddingSize, 0),
      Offset(leftPaddingSize, chartHeight)
    ];
    var startLineSpots = [
      Offset(0, size.height - bottomWidgetSize),
      Offset(size.width, size.height - bottomWidgetSize)
    ];
    var groundLineSpots = [
      Offset(0, size.height),
      Offset(size.width, size.height)
    ];

    Paint paint = Paint()
      ..color = Colors.indigoAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path1 = Path();

    //upper1 - lower 2
    paint.color = Colors.blueAccent.shade100;
    paint.style = PaintingStyle.fill;
    path1 = Path()
      ..addPolygon(collectMediumPolygon(upperSpots1, lowerSpots2, size), true);
    canvas.drawPath(path1, paint);

    collectUpperPolygon(upperSpots1, lowerSpots2, size, upperThreshold).forEach(
        (polygon) => drawArea(canvas,
            points: polygon, color: Colors.redAccent.shade100));

    collectLowerPolygon(lowerSpots2, lowerSpots1, size, lowerThreshold).forEach(
        (polygon) => drawArea(canvas,
            points: polygon, color: Colors.yellowAccent.shade100));

    //upper2 - lower 1
    paint.color = Colors.blueAccent.shade400;
    paint.style = PaintingStyle.fill;
    path1 = Path()
      ..addPolygon(collectMediumPolygon(upperSpots2, lowerSpots1, size), true);
    canvas.drawPath(path1, paint);
    collectUpperPolygon(upperSpots2, lowerSpots1, size, upperThreshold,
            isOnlyThreshold: false)
        .forEach((polygon) => drawArea(canvas,
            points: polygon, color: Colors.redAccent.shade400));

    collectLowerPolygon(lowerSpots1, upperSpots2, size, lowerThreshold,
            isOnlyThreshold: false)
        .forEach((polygon) => drawArea(canvas,
            points: polygon, color: Colors.yellowAccent.shade400));

    //center
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawPoints(
        PointMode.polygon,
        calculatedPositionOfSpotList(
            [...valueSpots3]..sort((a, b) => a.dx < b.dx ? 0 : 1), size),
        paint);

    //draw threshold line
    paint.color = Colors.blue;
    canvas.drawPoints(PointMode.lines, upperLineThreshold, paint);
    paint.color = Colors.orangeAccent;
    canvas.drawPoints(PointMode.lines, lowerLineThreshold, paint);
    //
    paint.color = Colors.purpleAccent;
    canvas.drawPoints(PointMode.polygon, zeroLineSpots, paint);
    //
    // paint.color = Colors.cyanAccent;
    // canvas.drawPoints(PointMode.polygon, startLineSpots, paint);

    paint.color = Colors.black;
    canvas.drawPoints(PointMode.lines, groundLineSpots, paint);
  }

  List<Offset> calculatedAndAddNewSpot(List<Offset> spots) {
    List<Offset> newSpots = [];
    List<Offset> sortSpots = [...spots];
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
      while (ySeperatedNum <= sortSpots[i].dy) {
        ySeperatedNum += 50;
      }
    }
    // sortSpots.addAll(newSpots);
    // print(sortSpots);
    // sortSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    newSpots.addAll(sortSpots);
    newSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    xSeperatedNum =
        newSpots.last.dx > xSeperatedNum ? newSpots.last.dx : xSeperatedNum;
    while (ySeperatedNum <= sortSpots.last.dy) {
      ySeperatedNum += 50;
    }
    return newSpots;
  }

  void drawArea(Canvas canvas,
      {required List<Offset> points, required Color color}) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawPath(Path()..addPolygon(points, true), paint);
  }

  List<List<Offset>> collectUpperPolygon(List<Offset> upperSpots,
      List<Offset> lowerSpots, Size size, double threshold,
      {bool isOnlyThreshold = true}) {
    List<List<Offset>> polygons = [];
    var startStatus = true;
    var isFirst = true;
    List<Offset> polygon = [];

    for (int i = 0; i < upperSpots.length; i++) {
      if (startStatus) {
        if (upperSpots[i].dy >= threshold) {
          polygon.add(calculatedPositionSpot(upperSpots[i], size));
          startStatus = false;
        }
        continue;
      }

      if (polygon.length == 1) {
        if (upperSpots[i].dy < threshold) {
          startStatus = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(upperSpots[i], size));
        }
        continue;
      } else {
        if (upperSpots[i].dy < threshold) {
          if (isFirst) {
            polygon.add(calculatedPositionSpot(Offset(0, threshold), size));
            isFirst = false;
          }
          polygons.add(polygon);
          startStatus = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(upperSpots[i], size));
        }
      }
      continue;
    }
    if (polygon.isNotEmpty) {
      polygon.add(
          calculatedPositionSpot(Offset(upperSpots.last.dx, threshold), size));
      polygons.add(polygon);
    }
    if (!isOnlyThreshold) {
      List<Offset> lower = [...lowerSpots]
          .map((spot) => calculatedPositionSpot(spot, size))
          .toList();
      var thresholdPosition = calculateHeight(size, threshold);
      for (var i = 0; i < polygons.length; i++) {
        var first = polygons[i].first;
        var last = polygons[i].last;
        List<Offset> spots = [];
        for (var spot in lower) {
          if (spot.dx > first.dx &&
              spot.dx < last.dx &&
              spot.dy <= thresholdPosition) {
            spots.add(spot);
          }
        }
        polygons[i].addAll(spots.reversed);
      }
    }
    return polygons;
  }

  List<Offset> collectMediumPolygon(
      List<Offset> spots, List<Offset> centerSpots, Size size) {
    List<Offset> polygon = [];
    List<Offset> backSortedCenterSpots = [...centerSpots]
      ..sort((a, b) => a.dx < b.dx ? 1 : 0);
    polygon.addAll(spots);
    polygon.addAll(backSortedCenterSpots);
    return calculatedPositionOfSpotList(polygon, size);
  }

  List<List<Offset>> collectLowerPolygon(List<Offset> lowerSpots,
      List<Offset> upperSpots, Size size, double threshold,
      {bool isOnlyThreshold = true}) {
    List<List<Offset>> polygons = [];
    var isFirst = true;
    List<Offset> polygon = [];

    for (int i = 0; i < lowerSpots.length; i++) {
      if (isFirst) {
        if (lowerSpots[i].dy <= threshold) {
          polygon.add(calculatedPositionSpot(lowerSpots[i], size));
          isFirst = false;
        }
        continue;
      }

      if (polygon.length == 1) {
        if (lowerSpots[i].dy > threshold) {
          isFirst = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(lowerSpots[i], size));
        }
        continue;
      } else {
        if (lowerSpots[i].dy > threshold) {
          if (isFirst) {
            polygon.add(calculatedPositionSpot(Offset(0, threshold), size));
            isFirst = false;
          }
          polygons.add(polygon);
          isFirst = true;
          polygon = [];
        } else {
          polygon.add(calculatedPositionSpot(lowerSpots[i], size));
        }
      }
      continue;
    }
    if (polygon.isNotEmpty) {
      polygon.add(
          calculatedPositionSpot(Offset(lowerSpots.last.dx, threshold), size));
      polygons.add(polygon);
    }
    if (!isOnlyThreshold) {
      List<Offset> upper = [...upperSpots]
          .map((spot) => calculatedPositionSpot(spot, size))
          .toList();
      var thresholdPosition = calculateHeight(size, threshold);
      for (var i = 0; i < polygons.length; i++) {
        var first = polygons[i].first;
        var last = polygons[i].last;
        List<Offset> spots = [];
        for (var spot in upper) {
          if (spot.dx > first.dx &&
              spot.dx < last.dx &&
              spot.dy >= thresholdPosition) {
            spots.add(spot);
          }
        }
        polygons[i].addAll(spots.reversed);
      }
    }
    return polygons;
  }

  List<Offset> calculatedPositionOfSpotList(List<Offset> spots, Size size) {
    return spots
        .map((spot) => Offset(
            spot.dx * (size.width - leftPaddingSize) / (xSeperatedNum) +
                leftPaddingSize,
            calculateHeight(size, spot.dy)))
        .toList();
  }

  Offset calculatedPositionSpot(Offset spot, Size size) {
    return Offset(
        spot.dx * (size.width - leftPaddingSize) / (xSeperatedNum) +
            leftPaddingSize,
        calculateHeight(size, spot.dy));
  }

  double calculateHeight(Size size, double y) {
    var height = size.height - bottomWidgetSize;
    return (height - y) / ySeperatedNum * height;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
