import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3study/graph/data.dart';

class DrawWeekSugarLevelChartScreen extends StatefulWidget {
  DrawWeekSugarLevelChartScreen({Key? key}) : super(key: key);

  @override
  State<DrawWeekSugarLevelChartScreen> createState() =>
      _DrawWeekSugarLevelChartScreenState();
}

class _DrawWeekSugarLevelChartScreenState
    extends State<DrawWeekSugarLevelChartScreen> {
  List<Offset> spots1 = [
    Offset(0, 200),
    Offset(30, 120),
    Offset(20, 160),
    Offset(40, 80),
    Offset(10, 90),
    Offset(60, 180),
    Offset(50, 140),
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

  List<Offset> spots5 = [
    Offset(0, 100),
    Offset(30, 30),
    Offset(20, 60),
    Offset(40, 20),
    Offset(10, 15),
    Offset(60, 80),
    Offset(50, 50),
  ];

  double touchDx = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: GestureDetector(
            onTapDown: (detail) {
              setState(() => touchDx = detail.globalPosition.dx);
            },
            onHorizontalDragUpdate: (detail) {
              setState(() => touchDx = detail.globalPosition.dx);
            },
            child: CustomPaint(
              painter: _WeekSugarLevelChart(
                  highValueSpots: spots1,
                  averageValueSpots: spots3,
                  lowValueSpots: spots5,
                  upperThreshold: 160,
                  normalThreshold: 140,
                  lowerThreshold: 60,
                  touchDx: touchDx),
            ),
          ),
        ),
      ),
    );
  }
}

class _WeekSugarLevelChart extends CustomPainter {
  final List<Offset> highValueSpots;
  final List<Offset> averageValueSpots;
  final List<Offset> lowValueSpots;
  final double upperThreshold;
  final double normalThreshold;
  final double lowerThreshold;
  final double touchDx;

  double xSeperatedNum = 0;
  double ySeperatedNum = 350;
  double leftPadding = 100;
  double topWidgetHeight = 100;
  double rightPadding = 100;
  double bottomWidgetHeight = 50;
  double areaWidth = 40;

  double lineWidth = 4;
  double spotWidth = 5;
  double fontSize = 15;

  ChartAreaData? chartAreaData;

  _WeekSugarLevelChart(
      {required this.highValueSpots,
      required this.averageValueSpots,
      required this.lowValueSpots,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      required this.touchDx});

  @override
  void paint(Canvas canvas, Size size) {
    var highSpots = calculatedAndAddNewSpot(highValueSpots, size);
    var averageSpots = calculatedAndAddNewSpot(averageValueSpots, size);
    var lowSpots = calculatedAndAddNewSpot(lowValueSpots, size);
    var areas = calculatedChartAreaData(averageSpots, highSpots);
    var groundLineSpots = [
      Offset(0, size.height),
      Offset(size.width, size.height)
    ];

    Paint paint = Paint()
      ..color = Colors.indigoAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();

    drawThresholdLine(canvas, size);
    drawValueText(canvas, size, areas, Offset(touchDx, 40));
    drawLinesAndSpots(canvas, size, highSpots,
        lineColor: Colors.blueAccent, spotColor: Colors.black);
    drawLinesAndSpots(canvas, size, averageSpots,
        lineColor: Colors.amberAccent, spotColor: Colors.black);
    drawLinesAndSpots(canvas, size, lowSpots,
        lineColor: Colors.orangeAccent, spotColor: Colors.black);

    paint..color = Colors.lightGreenAccent;
    path = Path()..addPolygon(groundLineSpots, false);
    canvas.drawPath(path, paint);
  }

  void drawLinesAndSpots(Canvas canvas, Size size, List<ChartData> chartData,
      {required Color lineColor, required Color spotColor}) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineWidth
      ..color = lineColor;
    var offsets = chartData.map((data) => data.offset).toList();
    canvas.drawPoints(PointMode.polygon, offsets, paint);
    paint.color = spotColor;
    paint.strokeWidth = spotWidth;
    canvas.drawPoints(PointMode.points, offsets, paint);
  }

  List<ChartData> calculatedAndAddNewSpot(List<Offset> spots, Size size) {
    List<Offset> sortSpots = [...spots];
    sortSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    for (int i = 0; i < sortSpots.length - 1; i++) {
      while (ySeperatedNum <= sortSpots[i].dy) {
        ySeperatedNum += 25;
      }
    }
    xSeperatedNum =
        sortSpots.last.dx >= xSeperatedNum ? sortSpots.last.dx : xSeperatedNum;
    while (ySeperatedNum <= sortSpots.last.dy) {
      ySeperatedNum += 25;
    }
    List<ChartData> result = [];
    for (var spot in sortSpots) {
      var calOffset = calculatedPositionSpot(spot, size);
      result.add(ChartData(calOffset, spot.dy));
    }
    return result;
  }

  // 터치 했을 때에 그 영역에 있는 값 디스플레이 해주기.
  void drawValueText(
      Canvas canvas, Size size, List<ChartAreaData> areas, Offset pos) {
    ChartAreaData? result;
    var listOfDx = [];
    for (var data in areas) {
      if (data.lowDx < pos.dx && pos.dx < data.highDx) {
        result = data;
        break;
      }
      listOfDx.add(data.dx);
    }
    // 터치 영역에서 제일 가까운 값 찾기.
    if (result == null) {
      listOfDx.add(pos.dx);
      listOfDx.sort();
      var index = listOfDx.indexOf(pos.dx);
      if (index == 0) {
        result = areas.first;
      } else if (pos.dx == listOfDx.last) {
        result = areas.last;
      } else {
        var abs1 = (listOfDx[index - 1] - pos.dx).abs();
        var abs2 = (pos.dx - listOfDx[index + 1]).abs();
        if (abs1 < abs2) {
          result = areas[index - 1];
        } else {
          result = areas[index];
        }
      }
    }
    TextSpan maxSpan = TextSpan(
      style: TextStyle(
          fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.bold),
      children: [
        TextSpan(text: '최고 ', children: [
          TextSpan(
              text: '${result.highValue.toInt()}  ',
              style: TextStyle(color: _selectTextColor(result.highValue)))
        ]),
        TextSpan(text: '평균 ', children: [
          TextSpan(
              text: '${result.averageValue.toInt()}  ',
              style: TextStyle(color: _selectTextColor(result.averageValue)))
        ]),
        TextSpan(text: '최저 ', children: [
          TextSpan(
              text: '${result.lowValue.toInt()}',
              style: TextStyle(color: _selectTextColor(result.lowValue)))
        ]),
      ],
    );
    TextPainter tp =
        TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
    tp.layout();

    double y = 0; //-tp.height * 0.5; // 텍스트의 방향을 고려해 y축 값을 보정해줍니다.
    double dx = result.lowDx - tp.width * 1.3 / 2 <= 0
        ? leftPadding // tp.width/2*1.3 - result.lowDx
        : result.highDx + tp.width >= size.width
            ? size.width - rightPadding - tp.width
            : result.dx - tp.width / 2; // 텍스트의 위치를 고려해 x축 값을 보정해줍니다.
    double dy = pos.dy + y;

    Offset offset = Offset(dx, dy);
    var rect = Rect.fromCenter(
        center: Offset(dx + tp.width / 2, dy + tp.height / 2),
        width: tp.width * 1.3,
        height: tp.height * 1.5);
    var rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
    Paint paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.black38;
    canvas.drawPath(
        Path()
          ..addPolygon(
              [Offset(result.dx, dy), Offset(result.dx, result.dy)], false),
        paint);
    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    canvas.drawRRect(rrect, paint);
    paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.black38;
    canvas.drawRRect(rrect, paint);
    tp.paint(canvas, offset);
  }

  void drawThresholdLine(Canvas canvas, Size size) {
    List<Offset> upperThresholdOffsets = [];
    List<Offset> normalThresholdOffsets = [];
    List<Offset> lowerThresholdOffsets = [];
    var upperDy = calculatedDy(size, upperThreshold);
    var normalDy = calculatedDy(size, normalThreshold);
    var lowerDy = calculatedDy(size, lowerThreshold);
    var i = size.width - rightPadding;
    while (true) {
      upperThresholdOffsets.add(Offset(i, upperDy));
      normalThresholdOffsets.add(Offset(i, normalDy));
      lowerThresholdOffsets.add(Offset(i, lowerDy));
      i -= 10;
      if (i < leftPadding) {
        i = leftPadding;
        upperThresholdOffsets.add(Offset(i, upperDy));
        normalThresholdOffsets.add(Offset(i, normalDy));
        lowerThresholdOffsets.add(Offset(i, lowerDy));
        break;
      }
    }
    Paint paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.redAccent.shade100;
    canvas.drawPoints(PointMode.lines, upperThresholdOffsets, paint);
    paint.color = Colors.black12;
    canvas.drawPoints(PointMode.lines, normalThresholdOffsets, paint);
    paint.color = Colors.black12;
    canvas.drawPoints(PointMode.lines, lowerThresholdOffsets, paint);
  }

  List<Offset> calculatedPositionOfSpotList(List<Offset> spots, Size size) {
    return spots
        .map((spot) =>
            Offset(calculatedDx(size, spot.dx), calculatedDy(size, spot.dy)))
        .toList();
  }

  Offset calculatedPositionSpot(Offset spot, Size size) {
    return Offset(calculatedDx(size, spot.dx), calculatedDy(size, spot.dy));
  }

  double calculatedDx(Size size, double dx) =>
      dx * (size.width - leftPadding - rightPadding) / xSeperatedNum +
      leftPadding;

  double calculatedDy(Size size, double dy) {
    var height = size.height - topWidgetHeight - bottomWidgetHeight;
    return (height - dy) / ySeperatedNum * height + topWidgetHeight;
  }

  List<ChartAreaData> calculatedChartAreaData(
      List<ChartData> average, List<ChartData> highValue) {
    List<ChartAreaData> result = [];
    List<Offset> sortAverageSpots = [...averageValueSpots];
    List<Offset> sortHighSpots = [...highValueSpots];
    List<Offset> sortLowSpots = [...lowValueSpots];
    sortAverageSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    sortHighSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    sortLowSpots.sort((a, b) => a.dx < b.dx ? 0 : 1);
    for (var i = 0; i < average.length; i++) {
      var lowDx = .0;
      var highDx = .0;
      if (average[i].offset.dx - areaWidth >= 0) {
        lowDx = average[i].offset.dx - areaWidth;
      }
      highDx = average[i].offset.dx + areaWidth;
      result.add(ChartAreaData(
          lowDx,
          average[i].offset.dx,
          highDx,
          sortHighSpots[i].dy,
          averageValueSpots[i].dy,
          sortLowSpots[i].dy,
          highValue[i].offset.dy));
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Color _selectTextColor(double value) {
    return value >= upperThreshold
        ? Colors.redAccent
        : value <= lowerThreshold
            ? Colors.purpleAccent
            : Colors.greenAccent;
  }
}
