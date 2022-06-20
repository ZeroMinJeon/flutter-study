import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3study/graph/sugar_level/data.dart';

class DrawSugarLevelChartScreen extends StatelessWidget {
  DrawSugarLevelChartScreen({Key? key}) : super(key: key);

  List<SugarLevelData> upperSugarLevelDataList1 = [
    SugarLevelData(DateTime(2022, 5, 1, 0), 190),
    SugarLevelData(DateTime(2022, 5, 1, 0, 20), 190),
    SugarLevelData(DateTime(2022, 5, 1, 1), 200),
    SugarLevelData(DateTime(2022, 5, 1, 1, 30), 190),
    SugarLevelData(DateTime(2022, 5, 1, 2), 180),
    SugarLevelData(DateTime(2022, 5, 1, 2, 40), 170),
    SugarLevelData(DateTime(2022, 5, 1, 3), 160),
    SugarLevelData(DateTime(2022, 5, 1, 4), 150),
    SugarLevelData(DateTime(2022, 5, 1, 5), 140),
    SugarLevelData(DateTime(2022, 5, 1, 5, 50), 130),
    SugarLevelData(DateTime(2022, 5, 1, 6), 150),
    SugarLevelData(DateTime(2022, 5, 1, 6, 10), 180),
    SugarLevelData(DateTime(2022, 5, 1, 6, 20), 140),
    SugarLevelData(DateTime(2022, 5, 1, 7), 130),
    SugarLevelData(DateTime(2022, 5, 1, 8), 120),
    SugarLevelData(DateTime(2022, 5, 1, 9), 110),
    SugarLevelData(DateTime(2022, 5, 1, 10), 110),
    SugarLevelData(DateTime(2022, 5, 1, 13), 100),
    SugarLevelData(DateTime(2022, 5, 1, 14), 80),
    SugarLevelData(DateTime(2022, 5, 1, 15), 70),
    SugarLevelData(DateTime(2022, 5, 1, 19), 50),
    SugarLevelData(DateTime(2022, 5, 1, 20), 60),
    SugarLevelData(DateTime(2022, 5, 1, 21), 60),
    SugarLevelData(DateTime(2022, 5, 1, 23), 100),
    SugarLevelData(DateTime(2022, 5, 1, 24), 100),
    SugarLevelData(DateTime(2022, 5, 2, 2), 120),
    SugarLevelData(DateTime(2022, 5, 2, 3), 120),
    SugarLevelData(DateTime(2022, 5, 2, 5), 120),
    SugarLevelData(DateTime(2022, 5, 2, 9), 120),
    SugarLevelData(DateTime(2022, 5, 2, 10), 120),
    SugarLevelData(DateTime(2022, 5, 2, 14), 120),
  ];
  List<SugarLevelData> upperSugarLevelDataList2 = [
    SugarLevelData(DateTime(2022, 5, 1, 0), 170),
    SugarLevelData(DateTime(2022, 5, 1, 0, 20), 170),
    SugarLevelData(DateTime(2022, 5, 1, 1), 180),
    SugarLevelData(DateTime(2022, 5, 1, 1, 30), 170),
    SugarLevelData(DateTime(2022, 5, 1, 2), 170),
    SugarLevelData(DateTime(2022, 5, 1, 2, 40), 160),
    SugarLevelData(DateTime(2022, 5, 1, 3), 150),
    SugarLevelData(DateTime(2022, 5, 1, 4), 140),
    SugarLevelData(DateTime(2022, 5, 1, 5), 130),
    SugarLevelData(DateTime(2022, 5, 1, 5, 50), 120),
    SugarLevelData(DateTime(2022, 5, 1, 6), 140),
    SugarLevelData(DateTime(2022, 5, 1, 6, 10), 175),
    SugarLevelData(DateTime(2022, 5, 1, 6, 20), 135),
    SugarLevelData(DateTime(2022, 5, 1, 7), 125),
    SugarLevelData(DateTime(2022, 5, 1, 8), 115),
    SugarLevelData(DateTime(2022, 5, 1, 9), 100),
    SugarLevelData(DateTime(2022, 5, 1, 10), 100),
    SugarLevelData(DateTime(2022, 5, 1, 13), 80),
    SugarLevelData(DateTime(2022, 5, 1, 14), 70),
    SugarLevelData(DateTime(2022, 5, 1, 15), 63),
    SugarLevelData(DateTime(2022, 5, 1, 19), 48),
    SugarLevelData(DateTime(2022, 5, 1, 20), 58),
    SugarLevelData(DateTime(2022, 5, 1, 21), 55),
    SugarLevelData(DateTime(2022, 5, 1, 23), 95),
    SugarLevelData(DateTime(2022, 5, 1, 24), 90),
    SugarLevelData(DateTime(2022, 5, 2, 2), 110),
    SugarLevelData(DateTime(2022, 5, 2, 3), 110),
    SugarLevelData(DateTime(2022, 5, 2, 5), 110),
    SugarLevelData(DateTime(2022, 5, 2, 9), 110),
    SugarLevelData(DateTime(2022, 5, 2, 10), 110),
    SugarLevelData(DateTime(2022, 5, 2, 14), 110),
  ];

  List<SugarLevelData> averageSugarLevelDataList = [
    SugarLevelData(DateTime(2022, 5, 1, 0), 160),
    SugarLevelData(DateTime(2022, 5, 1, 0, 20), 160),
    SugarLevelData(DateTime(2022, 5, 1, 1), 170),
    SugarLevelData(DateTime(2022, 5, 1, 1, 30), 165),
    SugarLevelData(DateTime(2022, 5, 1, 2), 165),
    SugarLevelData(DateTime(2022, 5, 1, 2, 40), 155),
    SugarLevelData(DateTime(2022, 5, 1, 3), 140),
    SugarLevelData(DateTime(2022, 5, 1, 4), 135),
    SugarLevelData(DateTime(2022, 5, 1, 5), 120),
    SugarLevelData(DateTime(2022, 5, 1, 5, 50), 115),
    SugarLevelData(DateTime(2022, 5, 1, 6), 130),
    SugarLevelData(DateTime(2022, 5, 1, 6, 10), 165),
    SugarLevelData(DateTime(2022, 5, 1, 6, 20), 125),
    SugarLevelData(DateTime(2022, 5, 1, 7), 115),
    SugarLevelData(DateTime(2022, 5, 1, 8), 105),
    SugarLevelData(DateTime(2022, 5, 1, 9), 99),
    SugarLevelData(DateTime(2022, 5, 1, 10), 95),
    SugarLevelData(DateTime(2022, 5, 1, 13), 70),
    SugarLevelData(DateTime(2022, 5, 1, 14), 60),
    SugarLevelData(DateTime(2022, 5, 1, 15), 55),
    SugarLevelData(DateTime(2022, 5, 1, 19), 44),
    SugarLevelData(DateTime(2022, 5, 1, 20), 55),
    SugarLevelData(DateTime(2022, 5, 1, 21), 52),
    SugarLevelData(DateTime(2022, 5, 1, 23), 90),
    SugarLevelData(DateTime(2022, 5, 1, 24), 83),
    SugarLevelData(DateTime(2022, 5, 2, 2), 100),
    SugarLevelData(DateTime(2022, 5, 2, 3), 100),
    SugarLevelData(DateTime(2022, 5, 2, 5), 100),
    SugarLevelData(DateTime(2022, 5, 2, 9), 100),
    SugarLevelData(DateTime(2022, 5, 2, 10), 100),
    SugarLevelData(DateTime(2022, 5, 2, 14), 100),
  ];

  List<SugarLevelData> lowerSugarLevelDataList1 = [
    SugarLevelData(DateTime(2022, 5, 1, 0), 150),
    SugarLevelData(DateTime(2022, 5, 1, 0, 20), 155),
    SugarLevelData(DateTime(2022, 5, 1, 1), 160),
    SugarLevelData(DateTime(2022, 5, 1, 1, 30), 155),
    SugarLevelData(DateTime(2022, 5, 1, 2), 155),
    SugarLevelData(DateTime(2022, 5, 1, 2, 40), 145),
    SugarLevelData(DateTime(2022, 5, 1, 3), 135),
    SugarLevelData(DateTime(2022, 5, 1, 4), 130),
    SugarLevelData(DateTime(2022, 5, 1, 5), 115),
    SugarLevelData(DateTime(2022, 5, 1, 5, 50), 110),
    SugarLevelData(DateTime(2022, 5, 1, 6), 120),
    SugarLevelData(DateTime(2022, 5, 1, 6, 10), 155),
    SugarLevelData(DateTime(2022, 5, 1, 6, 20), 115),
    SugarLevelData(DateTime(2022, 5, 1, 7), 105),
    SugarLevelData(DateTime(2022, 5, 1, 8), 95),
    SugarLevelData(DateTime(2022, 5, 1, 9), 94),
    SugarLevelData(DateTime(2022, 5, 1, 10), 90),
    SugarLevelData(DateTime(2022, 5, 1, 13), 60),
    SugarLevelData(DateTime(2022, 5, 1, 14), 55),
    SugarLevelData(DateTime(2022, 5, 1, 15), 50),
    SugarLevelData(DateTime(2022, 5, 1, 19), 40),
    SugarLevelData(DateTime(2022, 5, 1, 20), 50),
    SugarLevelData(DateTime(2022, 5, 1, 21), 50),
    SugarLevelData(DateTime(2022, 5, 1, 23), 80),
    SugarLevelData(DateTime(2022, 5, 1, 24), 80),
    SugarLevelData(DateTime(2022, 5, 2, 2), 95),
    SugarLevelData(DateTime(2022, 5, 2, 3), 95),
    SugarLevelData(DateTime(2022, 5, 2, 5), 95),
    SugarLevelData(DateTime(2022, 5, 2, 9), 95),
    SugarLevelData(DateTime(2022, 5, 2, 10), 95),
    SugarLevelData(DateTime(2022, 5, 2, 14), 90),
  ];

  List<SugarLevelData> lowerSugarLevelDataList2 = [
    SugarLevelData(DateTime(2022, 5, 1, 0), 145),
    SugarLevelData(DateTime(2022, 5, 1, 0, 20), 145),
    SugarLevelData(DateTime(2022, 5, 1, 1), 150),
    SugarLevelData(DateTime(2022, 5, 1, 1, 30), 150),
    SugarLevelData(DateTime(2022, 5, 1, 2), 150),
    SugarLevelData(DateTime(2022, 5, 1, 2, 40), 140),
    SugarLevelData(DateTime(2022, 5, 1, 3), 130),
    SugarLevelData(DateTime(2022, 5, 1, 4), 120),
    SugarLevelData(DateTime(2022, 5, 1, 5), 110),
    SugarLevelData(DateTime(2022, 5, 1, 5, 50), 100),
    SugarLevelData(DateTime(2022, 5, 1, 6), 115),
    SugarLevelData(DateTime(2022, 5, 1, 6, 10), 135),
    SugarLevelData(DateTime(2022, 5, 1, 6, 20), 105),
    SugarLevelData(DateTime(2022, 5, 1, 7), 100),
    SugarLevelData(DateTime(2022, 5, 1, 8), 90),
    SugarLevelData(DateTime(2022, 5, 1, 9), 70),
    SugarLevelData(DateTime(2022, 5, 1, 10), 60),
    SugarLevelData(DateTime(2022, 5, 1, 13), 40),
    SugarLevelData(DateTime(2022, 5, 1, 14), 35),
    SugarLevelData(DateTime(2022, 5, 1, 15), 40),
    SugarLevelData(DateTime(2022, 5, 1, 19), 30),
    SugarLevelData(DateTime(2022, 5, 1, 20), 40),
    SugarLevelData(DateTime(2022, 5, 1, 21), 40),
    SugarLevelData(DateTime(2022, 5, 1, 23), 70),
    SugarLevelData(DateTime(2022, 5, 1, 24), 50),
    SugarLevelData(DateTime(2022, 5, 2, 2), 85),
    SugarLevelData(DateTime(2022, 5, 2, 3), 85),
    SugarLevelData(DateTime(2022, 5, 2, 5), 85),
    SugarLevelData(DateTime(2022, 5, 2, 9), 85),
    SugarLevelData(DateTime(2022, 5, 2, 10), 85),
    SugarLevelData(DateTime(2022, 5, 2, 14), 60),
  ];

  DateTime date = DateTime(2022, 5, 1);

  List<SugarLevelData> getList(List<SugarLevelData> list) =>
      list.fold([], (previousValue, data) {
        if (data.date.isAtSameMomentAs(date) ||
            (data.date.isAfter(date) &&
                data.date.isBefore(date.add(const Duration(days: 1))))) {
          previousValue.add(data);
        }
        return previousValue;
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FittedBox(
          child: SizedBox(
            width: MediaQuery.of(context).size.width + 800,
            height: 400,
            child: CustomPaint(
              painter: _SugarLevelDrawChart(
                valueSpots1: getList(upperSugarLevelDataList1),
                valueSpots2: getList(upperSugarLevelDataList2),
                valueSpots3: getList(averageSugarLevelDataList),
                valueSpots4: getList(lowerSugarLevelDataList1),
                valueSpots5: getList(lowerSugarLevelDataList2),
                upperThreshold: 160,
                lowerThreshold: 70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SugarLevelDrawChart extends CustomPainter {
  final List<SugarLevelData> valueSpots1;
  final List<SugarLevelData> valueSpots2;
  final List<SugarLevelData> valueSpots3;
  final List<SugarLevelData> valueSpots4;
  final List<SugarLevelData> valueSpots5;
  final double upperThreshold;
  final double lowerThreshold;
  final double leftMargin;
  final double rightMargin;
  final double topPadding;
  final double bottomPadding;

  double xSeperateSize = 86400;
  double ySeperateSize = 250;

  _SugarLevelDrawChart({
    required this.valueSpots1,
    required this.valueSpots2,
    required this.valueSpots3,
    required this.valueSpots4,
    required this.valueSpots5,
    required this.upperThreshold,
    required this.lowerThreshold,
    this.leftMargin = 50,
    this.rightMargin = 50,
    this.topPadding = 0,
    this.bottomPadding = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var upperSpots1 = calculatedAndAddNewData(valueSpots1, size);
    var upperSpots2 = calculatedAndAddNewData(valueSpots2, size);
    var centerSpots = calculatedAndAddNewData(valueSpots3, size);
    var lowerSpots1 = calculatedAndAddNewData(valueSpots4, size);
    var lowerSpots2 = calculatedAndAddNewData(valueSpots5, size);
    var chartHeight = size.height - bottomPadding - topPadding;

    var upperThresholdDy =
        chartHeight + topPadding - upperThreshold * chartHeight / ySeperateSize;
    var lowerThresholdDy =
        chartHeight + topPadding - lowerThreshold * chartHeight / ySeperateSize;
    var upperLineThreshold = [
      Offset(leftMargin, upperThresholdDy),
      Offset(size.width, upperThresholdDy)
    ];
    var lowerLineThreshold = [
      Offset(leftMargin, lowerThresholdDy),
      Offset(size.width, lowerThresholdDy),
    ];
    var zeroLineSpots = [
      Offset(leftMargin, 0),
      Offset(leftMargin, chartHeight)
    ];
    var startLineSpots = [
      Offset(0, chartHeight),
      Offset(size.width, chartHeight)
    ];
    var groundLineSpots = [
      Offset(0, size.height - bottomPadding),
      Offset(size.width, size.height - bottomPadding)
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

    collectUpperPolygon(upperSpots1, upperSpots2, size, upperThresholdDy)
        .forEach((polygon) => drawArea(canvas,
            points: polygon, color: Colors.redAccent.shade100));

    collectLowerPolygon(lowerSpots2, lowerSpots1, size, lowerThresholdDy).forEach(
        (polygon) => drawArea(canvas,
            points: polygon, color: Colors.yellowAccent.shade100));

    //upper2 - lower 1
    paint.color = Colors.blueAccent.shade400;
    paint.style = PaintingStyle.fill;
    path1 = Path()
      ..addPolygon(collectMediumPolygon(upperSpots2, lowerSpots1, size), true);
    canvas.drawPath(path1, paint);
    collectUpperPolygon(upperSpots2, lowerSpots1, size, upperThresholdDy,
            isOnlyThreshold: false)
        .forEach((polygon) => drawArea(canvas,
            points: polygon, color: Colors.redAccent.shade400));

    collectLowerPolygon(lowerSpots1, upperSpots2, size, lowerThresholdDy,
            isOnlyThreshold: false)
        .forEach((polygon) => drawArea(canvas,
            points: polygon, color: Colors.yellowAccent.shade400));

    //center
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawPoints(
        PointMode.polygon,
        centerSpots.map((data) => data.offset).toList(),
        //         valueSpots3.map((data) => )..sort((a, b) => a.dx < b.dx ? 0 : 1),
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
    paint.color = Colors.black;
    canvas.drawPoints(PointMode.polygon, startLineSpots, paint);

    paint.color = Colors.black;
    canvas.drawPoints(PointMode.lines, groundLineSpots, paint);
  }

  List<SugarLevelChartData> calculatedAndAddNewData(
      List<SugarLevelData> sugarLevelDataList, Size size) {
    List<SugarLevelChartData> newSugarLevelChartDataList = [];

    List<SugarLevelChartData> sugarLevelChartDataList = sugarLevelDataList
        .map((data) => SugarLevelChartData.fromSugarLevelData(data, size,
            leftMargin: leftMargin,
            rightMargin: rightMargin,
            leftPadding: 0,
            rightPadding: 0,
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            ySeperateSize: ySeperateSize))
        .toList()
      ..sort((a, b) => a.dx < b.dx ? 0 : 1);
    var highThresholdDy = calculateDy(size, upperThreshold);
    var lowThresholdDy = calculateDy(size, lowerThreshold);
    for (int i = 0; i < sugarLevelChartDataList.length - 1; i++) {
      var a = (sugarLevelChartDataList[i].dy -
              sugarLevelChartDataList[i + 1].dy) /
          (sugarLevelChartDataList[i].dx - sugarLevelChartDataList[i + 1].dx);
      var b = sugarLevelChartDataList[i].dy - a * sugarLevelChartDataList[i].dx;
      var x1 = (highThresholdDy - b) / a;
      var x2 = (lowThresholdDy - b) / a;

      if (sugarLevelChartDataList[i].dx < x1 &&
          x1 < sugarLevelChartDataList[i + 1].dx) {
        newSugarLevelChartDataList.add(SugarLevelChartData.fromOffsetThreshold(
            x1, upperThreshold, sugarLevelChartDataList[i].date, size,
            leftMargin: leftMargin,
            rightMargin: rightMargin,
            leftPadding: 0,
            rightPadding: 0,
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            ySeperateSize: ySeperateSize));
      }

      if (sugarLevelChartDataList[i].dx < x2 &&
          x2 < sugarLevelChartDataList[i + 1].dx) {
        newSugarLevelChartDataList.add(SugarLevelChartData.fromOffsetThreshold(
            x2, lowerThreshold, sugarLevelChartDataList[i].date, size,
            leftMargin: leftMargin,
            rightMargin: rightMargin,
            leftPadding: 0,
            rightPadding: 0,
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            ySeperateSize: ySeperateSize));
      }
    }

    newSugarLevelChartDataList.addAll(sugarLevelChartDataList);
    newSugarLevelChartDataList.sort((a, b) => a.dx < b.dx ? 0 : 1);
    xSeperateSize = newSugarLevelChartDataList.last.dx > xSeperateSize
        ? newSugarLevelChartDataList.last.dx
        : xSeperateSize;
    return newSugarLevelChartDataList;
  }

  void drawArea(Canvas canvas,
      {required List<Offset> points, required Color color}) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawPath(Path()..addPolygon(points, true), paint);
  }

  List<List<Offset>> collectUpperPolygon(
      List<SugarLevelChartData> upperSugarLevelChartDataList,
      List<SugarLevelChartData> lowerSugarLevelChartDataList,
      Size size,
      double thresholdDy,
      {bool isOnlyThreshold = true}) {
    List<List<Offset>> polygons = [];
    var startStatus = true;
    var isFirst = true;
    List<Offset> polygon = [];

    for (int i = 0; i < upperSugarLevelChartDataList.length; i++) {
      if (startStatus) {
        if (upperSugarLevelChartDataList[i].dy <= thresholdDy) {
          polygon.add(upperSugarLevelChartDataList[i].offset);
          startStatus = false;
        }
        continue;
      }

      if (polygon.length == 1) {
        if (upperSugarLevelChartDataList[i].dy > thresholdDy) {
          startStatus = true;
          polygon = [];
        } else {
          polygon.add(upperSugarLevelChartDataList[i].offset);
        }
        continue;
      } else {
        if (upperSugarLevelChartDataList[i].dy > thresholdDy) {
          if (isFirst) {
            polygon.add(Offset(calculateDx(size, 0), thresholdDy));
            isFirst = false;
          }
          polygons.add(polygon);
          startStatus = true;
          polygon = [];
        } else {
          polygon.add(upperSugarLevelChartDataList[i].offset);
        }
      }
    }
    if (polygon.isNotEmpty) {
      polygon.add(Offset(upperSugarLevelChartDataList.last.dx, thresholdDy));
      polygons.add(polygon);
    }
    if (!isOnlyThreshold) {
      List<Offset> lower =
          lowerSugarLevelChartDataList.map((data) => data.offset).toList();
      for (var i = 0; i < polygons.length; i++) {
        var first = polygons[i].first;
        var last = polygons[i].last;
        List<Offset> spots = [];
        for (var spot in lower) {
          if (spot.dx >= first.dx &&
              spot.dx <= last.dx &&
              spot.dy <= thresholdDy) {
            spots.add(spot);
          }
        }
        polygons[i].addAll(spots.reversed);
      }
    }
    return polygons;
  }

  List<Offset> collectMediumPolygon(List<SugarLevelChartData> spots,
      List<SugarLevelChartData> centerSpots, Size size) {
    List<Offset> polygon = [];
    List<Offset> backSortedCenterSpots = centerSpots
        .map((data) => Offset(data.dx, data.dy))
        .toList()
      ..sort((a, b) => a.dx < b.dx ? 1 : 0);
    polygon.addAll(spots.map((data) => data.offset).toList());
    polygon.addAll(backSortedCenterSpots);
    return polygon;
  }

  List<List<Offset>> collectLowerPolygon(
      List<SugarLevelChartData> lowerSugarLevelChartDataList,
      List<SugarLevelChartData> upperSugarLevelChartList,
      Size size,
      double thresholdDy,
      {bool isOnlyThreshold = true}) {
    List<List<Offset>> polygons = [];
    var startStatus = true;
    var isFirst = true;
    List<Offset> polygon = [];

    for (int i = 0; i < lowerSugarLevelChartDataList.length; i++) {
      if (startStatus) {
        if (lowerSugarLevelChartDataList[i].dy >= thresholdDy) {
          polygon.add(lowerSugarLevelChartDataList[i].offset);
          startStatus = false;
        }
        continue;
      }

      if (polygon.length == 1) {
        if (lowerSugarLevelChartDataList[i].dy < thresholdDy) {
          isFirst = true;
          polygon = [];
        } else {
          polygon.add(lowerSugarLevelChartDataList[i].offset);
        }
        continue;
      } else {
        if (lowerSugarLevelChartDataList[i].dy < thresholdDy) {
          if (isFirst) {
            polygon.add(Offset(calculateDx(size, 0), thresholdDy));
            isFirst = false;
          }
          polygons.add(polygon);
          startStatus = true;
          polygon = [];
        } else {
          polygon.add(lowerSugarLevelChartDataList[i].offset);
        }
      }
    }
    if (polygon.isNotEmpty) {
      polygon.add(
          Offset(lowerSugarLevelChartDataList.last.dx, thresholdDy));
      polygons.add(polygon);
    }
    if (!isOnlyThreshold) {
      List<Offset> upper =
          upperSugarLevelChartList.map((data) => data.offset).toList();
      for (var i = 0; i < polygons.length; i++) {
        var first = polygons[i].first;
        var last = polygons[i].last;
        List<Offset> spots = [];
        for (var spot in upper) {
          if (spot.dx >= first.dx &&
              spot.dx <= last.dx &&
              spot.dy >= thresholdDy) {
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
            spot.dx * (size.width - leftMargin) / (xSeperateSize) + leftMargin,
            calculateDy(size, spot.dy)))
        .toList();
  }

  Offset calculatedPositionSpot(Offset spot, Size size) {
    return Offset(
        spot.dx * (size.width - leftMargin - rightMargin) / (xSeperateSize) +
            leftMargin,
        calculateDy(size, spot.dy));
  }

  double calculateDx(Size size, double x) {
    var width = size.width - leftMargin - rightMargin;
    return leftMargin - x * width / xSeperateSize;
  }

  double calculateDy(Size size, double y) {
    var height = size.height - bottomPadding - topPadding;
    return height + topPadding - (height / ySeperateSize) * y;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
