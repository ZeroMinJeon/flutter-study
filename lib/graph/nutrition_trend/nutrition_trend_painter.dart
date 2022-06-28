import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3study/graph/nutrition_trend/data.dart';
import 'package:flutter3study/graph/utils/chart_offset_calculation.dart';

class NutritionTrendChartWidget extends StatefulWidget {
  final double width;
  final double height;
  final double xSeperateSize;
  final double ySeperateSize;
  final double upperThreshold;
  final double normalThreshold;
  final double lowerThreshold;
  final double leftMargin;
  final double rightMargin;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  final List<NutritionTrendData> nutritionTrendDataList;
  final bool isWeeklyMode;

  const NutritionTrendChartWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.xSeperateSize,
      required this.ySeperateSize,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      required this.leftMargin,
      required this.rightMargin,
      required this.leftPadding,
      required this.topPadding,
      required this.rightPadding,
      required this.bottomPadding,
      required this.nutritionTrendDataList,
      required this.isWeeklyMode});

  @override
  State<NutritionTrendChartWidget> createState() =>
      _NutritionTrendChartWidgetState();
}

class _NutritionTrendChartWidgetState extends State<NutritionTrendChartWidget> {
  double? touchDx;
  late List<NutritionTrendChartData> data;
  late ChartOffsetCalculator calculator = ChartOffsetCalculator(
    xSeperateSize: widget.xSeperateSize,
    ySeperateSize: widget.ySeperateSize,
    leftPadding: widget.leftPadding,
    rightPadding: widget.rightPadding,
    topPadding: widget.topPadding,
    bottomPadding: widget.bottomPadding,
    leftMargin: widget.leftMargin,
    rightMargin: widget.rightMargin,
  );

  @override
  void initState() {
    super.initState();
    calculatedData();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.width != widget.width) {
      calculatedData();
    } else if (oldWidget.nutritionTrendDataList.isEmpty ||
        widget.nutritionTrendDataList.isEmpty) {
      calculatedData();
    } else if (!oldWidget.nutritionTrendDataList.first.date
            .isAtSameMomentAs(widget.nutritionTrendDataList.first.date) ||
        !oldWidget.nutritionTrendDataList.last.date
            .isAtSameMomentAs(widget.nutritionTrendDataList.last.date)) {
      calculatedData();
    }
    touchDx = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => touchDx = event.localPosition.dx),
      child: GestureDetector(
        onTapDown: (detail) {
          setState(() => touchDx = detail.globalPosition.dx);
        },
        onHorizontalDragUpdate: (detail) {
          setState(() => touchDx = detail.localPosition.dx);
        },
        child: FittedBox(
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: CustomPaint(
              size: Size(widget.width, widget.height),
              painter: _NutritionTrendBackgroundPainter(
                  upperThreshold: widget.upperThreshold,
                  lowerThreshold: widget.lowerThreshold,
                  xSeperateSize: widget.xSeperateSize,
                  ySeperateSize: widget.ySeperateSize,
                  leftMargin: widget.leftMargin,
                  rightMargin: widget.rightMargin,
                  leftPadding: widget.leftPadding,
                  rightPadding: widget.rightPadding,
                  topPadding: widget.topPadding,
                  bottomPadding: widget.bottomPadding,
                  isWeekly: widget.isWeeklyMode),
              foregroundPainter: _NutritionTrendPainter(data,
                  upperThreshold: widget.upperThreshold,
                  lowerThreshold: widget.lowerThreshold,
                  xSeperateSize: widget.xSeperateSize,
                  ySeperateSize: widget.ySeperateSize,
                  leftMargin: widget.leftMargin,
                  rightMargin: widget.rightMargin,
                  leftPadding: widget.leftPadding,
                  rightPadding: widget.rightPadding,
                  topPadding: widget.topPadding,
                  bottomPadding: widget.bottomPadding,
                  touchDx: touchDx,
                  isWeekly: widget.isWeeklyMode),
            ),
          ),
        ),
      ),
    );
  }

  void calculatedData() {
    calculator = ChartOffsetCalculator(
      xSeperateSize: widget.xSeperateSize,
      ySeperateSize: widget.ySeperateSize,
      leftPadding: widget.leftPadding,
      rightPadding: widget.rightPadding,
      topPadding: widget.topPadding,
      bottomPadding: widget.bottomPadding,
      leftMargin: widget.leftMargin,
      rightMargin: widget.rightMargin,
    );
    var size = Size(widget.width, widget.height);
    data = widget.nutritionTrendDataList
        .map((trendData) => NutritionTrendChartData.fromNutritionTrendData(
              trendData,
              offset: calculator.calculateBarChartOffset(
                  size,
                  widget.isWeeklyMode ? trendData.weekDay : (trendData.day - 1),
                  trendData.cal ?? 0),
              width: calculator.calculatedBarPartWidth(size),
              isWeekly: widget.isWeeklyMode,
            ))
        .toList();
  }
}

class _NutritionTrendPainter extends CustomPainter {
  final List<NutritionTrendChartData> nutritionTrendChartData;
  final double upperThreshold;
  final double lowerThreshold;
  final double xSeperateSize;
  final double ySeperateSize;
  final double? touchDx;

  final double leftMargin;
  final double rightMargin;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  final bool isWeekly;
  double areaWidth = 40;

  double lineWidth = 6;
  double spotWidth = 5;
  double fontSize = 15;

  _NutritionTrendPainter(this.nutritionTrendChartData,
      {required this.upperThreshold,
      required this.lowerThreshold,
      required this.xSeperateSize,
      required this.ySeperateSize,
      required this.touchDx,
      required this.isWeekly,
      this.leftMargin = 25,
      this.rightMargin = 25,
      this.leftPadding = 15,
      this.topPadding = 30,
      this.rightPadding = 15,
      this.bottomPadding = 30});

  late ChartOffsetCalculator calculator = ChartOffsetCalculator(
      xSeperateSize: xSeperateSize,
      ySeperateSize: ySeperateSize,
      leftMargin: leftMargin,
      rightMargin: rightMargin,
      leftPadding: leftPadding,
      topPadding: topPadding,
      rightPadding: rightPadding,
      bottomPadding: bottomPadding);

  @override
  void paint(Canvas canvas, Size size) {
    drawBlock(canvas, size);
    drawTouchValueText(canvas, size);
    drawGroundLine(canvas, size);
  }

  void drawBlock(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.blueAccent;

    for (var data in nutritionTrendChartData) {
      var rect = Rect.fromLTRB(
          data.dx, data.dy, data.dx + data.width, size.height - bottomPadding);
      var rrect = RRect.fromRectAndRadius(rect, Radius.circular(5));
      canvas.drawRRect(rrect, paint);
    }
  }

  void drawTouchValueText(Canvas canvas, Size size) {
    if (touchDx == null || nutritionTrendChartData.isEmpty) {
      return;
    }
    NutritionTrendChartData? chartData;
    var listOfDx = [];
    for (var data in nutritionTrendChartData) {
      if (data.lowDx < touchDx! && touchDx! < data.highDx) {
        chartData = data;
        break;
      }
      listOfDx.add(data.centerDx);
      if (touchDx! < data.lowDx) {
        break;
      }
    }
    if (chartData == null) {
      listOfDx.add(touchDx);
      listOfDx.sort();
      var index = listOfDx.indexOf(touchDx);
      if (index == 0) {
        chartData = nutritionTrendChartData.first;
      } else if (touchDx == listOfDx.last) {
        chartData = nutritionTrendChartData.last;
      } else {
        var abs1 = (listOfDx[index - 1] - touchDx).abs();
        var abs2 = (touchDx! - listOfDx[index + 1]).abs();
        if (abs1 < abs2) {
          chartData = nutritionTrendChartData[index - 1];
        } else {
          chartData = nutritionTrendChartData[index];
        }
      }
    }
    TextSpan maxSpan = TextSpan(
      style: TextStyle(
          fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold),
      children: [
        TextSpan(text: chartData.toDataText),
      ],
    );
    TextPainter tp =
        TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
    tp.layout();

    Offset offset = calculator.calculateTextOffset(
        size, tp.size, chartData.lowDx, chartData.dx, chartData.width);
    var rect = Rect.fromCenter(
        center: Offset(offset.dx + tp.width / 2, offset.dy + tp.height / 2),
        width: tp.width * 1.3,
        height: tp.height * 1.5);
    var rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
    Paint paint = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.black;
    canvas.drawPath(
        Path()
          ..addPolygon([
            Offset(chartData.dx + chartData.width / 2, offset.dy),
            Offset(chartData.dx + chartData.width / 2, chartData.dy - 2)
          ], false),
        paint);
    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    canvas.drawRRect(rrect, paint);
    paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.black;
    canvas.drawRRect(rrect, paint);
    tp.paint(canvas, offset);
  }

  void drawGroundLine(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    var dy = calculator.calculateBarChartDy(size, 0);

    canvas.drawPoints(
        PointMode.polygon,
        [Offset(leftMargin, dy), Offset((size.width - rightMargin), dy)],
        paint);

    if (isWeekly) {
      List<Map<String, dynamic>> map = [
        {'index': 0, 'weekDay': '일'},
        {'index': 1, 'weekDay': '월'},
        {'index': 2, 'weekDay': '화'},
        {'index': 3, 'weekDay': '수'},
        {'index': 4, 'weekDay': '목'},
        {'index': 5, 'weekDay': '금'},
        {'index': 6, 'weekDay': '토'},
      ];
      for (var data in map) {
        TextSpan maxSpan = TextSpan(
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: data['weekDay']),
          ],
        );
        TextPainter tp =
            TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(
            canvas,
            calculator.calculateBarChartGroundTextOffset(
                size, data['index'], tp.size, true));
      }
    } else {
      List<Map<String, dynamic>> map = [
        {'index': 3, 'weekDay': '4일'},
        {'index': 10, 'weekDay': '11일'},
        {'index': 17, 'weekDay': '18일'},
        {'index': 24, 'weekDay': '25일'},
        {'index': 29, 'weekDay': '30일'},
      ];
      for (var data in map) {
        if (xSeperateSize <= data['index']) {
          break;
        }
        TextSpan maxSpan = TextSpan(
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: data['weekDay']),
          ],
        );
        TextPainter tp =
            TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
        tp.layout();
        paint.color = Colors.blueAccent.withOpacity(0.3);
        canvas.drawPoints(
            PointMode.lines,
            calculator.calculateBarChartGroundTextLineOffsetList(
                size, data['index'], tp.size),
            paint);
        tp.paint(
            canvas,
            calculator.calculateBarChartGroundTextOffset(
                size, data['index'], tp.size, false));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _NutritionTrendBackgroundPainter extends CustomPainter {
  final double upperThreshold;
  final double lowerThreshold;
  final double xSeperateSize;
  final double ySeperateSize;

  final double leftMargin;
  final double rightMargin;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  final bool isWeekly;
  double areaWidth = 40;

  double lineWidth = 6;
  double spotWidth = 5;
  double fontSize = 15;

  _NutritionTrendBackgroundPainter(
      {required this.upperThreshold,
      required this.lowerThreshold,
      required this.xSeperateSize,
      required this.ySeperateSize,
      required this.isWeekly,
      this.leftMargin = 25,
      this.rightMargin = 25,
      this.leftPadding = 15,
      this.topPadding = 30,
      this.rightPadding = 15,
      this.bottomPadding = 30});

  @override
  void paint(Canvas canvas, Size size) {
    drawThresholdLine(canvas, size, upperThreshold);
    drawThresholdLine(canvas, size, lowerThreshold);
    invisibleLine(canvas, size);
  }

  void drawThresholdLine(Canvas canvas, Size size, double threshold) {
    List<Offset> offsets = [];
    ChartOffsetCalculator calculator = ChartOffsetCalculator(
        xSeperateSize: xSeperateSize,
        ySeperateSize: ySeperateSize,
        leftMargin: leftMargin,
        leftPadding: leftPadding,
        topPadding: topPadding,
        bottomPadding: bottomPadding);
    var dy = calculator.calculateBarChartDy(size, threshold);
    for (var i = leftMargin;;) {
      if (i < size.width - rightMargin) {
        offsets.add(Offset(i, dy));
        i += 7;
      } else {
        offsets.add(Offset(size.width - rightMargin, dy));
        break;
      }
    }
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;

    canvas.drawPoints(PointMode.lines, offsets, paint);

    TextSpan maxSpan = TextSpan(
      style: TextStyle(
          fontSize: fontSize - 2,
          color: Colors.redAccent,
          fontWeight: FontWeight.bold),
      children: [
        TextSpan(text: threshold.toInt().toString()),
      ],
    );
    TextPainter tp =
        TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
    tp.layout();
    paint.color = Colors.blueAccent.withOpacity(0.3);
    tp.paint(
        canvas,
        calculator.calculateBarChartThresholdTextOffset(
            size, threshold, tp.size));
  }

  void invisibleLine(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.transparent;
    canvas.drawPoints(
        PointMode.lines, [Offset.zero, Offset(size.width, size.height)], paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
