import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3study/graph/sugar_level/data.dart';

class SugarLevelChartWidget extends StatefulWidget {
  final double width;
  final double height;
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
  final List<TimeSugarLevelData> timeSugarLevelDataList;
  final bool isWeeklyMode;

  const SugarLevelChartWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.ySeperateSize,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      required this.timeSugarLevelDataList,
      required this.isWeeklyMode,
      this.leftPadding = 15,
      this.topPadding = 30,
      this.rightPadding = 15,
      this.bottomPadding = 30,
      this.leftMargin = 25,
      this.rightMargin = 25})
      : super(key: key);

  @override
  State<SugarLevelChartWidget> createState() => _SugarLevelChartPainterState();
}

class _SugarLevelChartPainterState extends State<SugarLevelChartWidget> {
  double? touchDx;
  late List<ChartData> chartData;

  @override
  void initState() {
    calculatedData();
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.timeSugarLevelDataList.isEmpty ||
        widget.timeSugarLevelDataList.isEmpty) {
      calculatedData();
    } else if (!oldWidget.timeSugarLevelDataList.last.date
        .isAtSameMomentAs(widget.timeSugarLevelDataList.last.date)) {
      calculatedData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: GestureDetector(
          onTapDown: (detail) {
            setState(() => touchDx = detail.globalPosition.dx);
          },
          onHorizontalDragUpdate: (detail) {
            setState(() => touchDx = detail.globalPosition.dx);
          },
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: CustomPaint(
              size: Size(widget.width, widget.height),
              foregroundPainter: _SugarLevelChartPainter(
                  chartDataList: chartData,
                  ySeperatedNum: widget.ySeperateSize,
                  upperThreshold: widget.upperThreshold,
                  normalThreshold: widget.normalThreshold,
                  lowerThreshold: widget.lowerThreshold,
                  touchDx: touchDx),
              painter: _SugarLevelChartBackgroundPainter(
                  ySeperateSize: widget.ySeperateSize,
                  upperThreshold: widget.upperThreshold,
                  normalThreshold: widget.normalThreshold,
                  lowerThreshold: widget.lowerThreshold,
                  leftMargin: widget.leftMargin,
                  rightMargin: widget.rightMargin,
                  leftPadding: widget.leftPadding,
                  topPadding: widget.topPadding,
                  rightPadding: widget.rightPadding,
                  bottomPadding: widget.bottomPadding),
            ),
          ),
        ),
      ),
    );
  }

  void calculatedData() {
    chartData = widget.timeSugarLevelDataList
        .map((data) => ChartData.fromTimeSugarLevelData(
            data,
            Size(widget.width, widget.height),
            widget.leftMargin,
            widget.rightMargin,
            widget.leftPadding,
            widget.topPadding,
            widget.rightPadding,
            widget.bottomPadding,
            widget.isWeeklyMode ? 1 : 2,
            widget.ySeperateSize))
        .toList();
  }
}

class _SugarLevelChartPainter extends CustomPainter {
  final List<ChartData> chartDataList;
  final double upperThreshold;
  final double normalThreshold;
  final double lowerThreshold;
  final double? touchDx;
  final double ySeperatedNum;

  double xSeperatedNum = 0;
  double leftPadding = 100;
  double topPadding = 100;
  double rightPadding = 100;
  double bottomPadding = 50;
  double areaWidth = 40;

  double lineWidth = 6;
  double spotWidth = 5;
  double fontSize = 15;

  ChartAreaData? chartAreaData;

  _SugarLevelChartPainter(
      {required this.chartDataList,
      required this.ySeperatedNum,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      required this.touchDx});

  @override
  void paint(Canvas canvas, Size size) {
    drawValueText(
        canvas,
        size,
        chartDataList
            .map((data) => data.toChartAreaData())
            .toList()); // Offset(touchDx??0, 40));
    drawLinesAndSpots(canvas, size,
        chartDataList.map((data) => Offset(data.dx, data.highDy)).toList(),
        lineColor: Colors.blueAccent, spotColor: Colors.black);
    drawLinesAndSpots(canvas, size,
        chartDataList.map((data) => Offset(data.dx, data.averageDy)).toList(),
        lineColor: Colors.amberAccent, spotColor: Colors.black);
    drawLinesAndSpots(canvas, size,
        chartDataList.map((data) => Offset(data.dx, data.lowDy)).toList(),
        lineColor: Colors.orangeAccent, spotColor: Colors.black);

    canvas.drawPoints(
        PointMode.lines,
        [Offset(0, 0), Offset(size.width, size.height)],
        Paint()
          ..color = Colors.white.withOpacity(0)
          ..strokeWidth = 3);
  }

  void drawLinesAndSpots(Canvas canvas, Size size, List<Offset> offsets,
      {required Color lineColor, required Color spotColor}) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineWidth
      ..color = lineColor;
    canvas.drawPoints(PointMode.polygon, offsets, paint);
    paint.color = spotColor;
    paint.strokeWidth = spotWidth;
    canvas.drawPoints(PointMode.points, offsets, paint);
  }

  // 터치 했을 때에 그 영역에 있는 값 디스플레이 해주기.
  void drawValueText(Canvas canvas, Size size, List<ChartAreaData> areas) {
    if (touchDx == null || areas.isEmpty) {
      return;
    }
    ChartAreaData? result;
    var listOfDx = [];
    for (var data in areas) {
      if (data.lowDx < touchDx! && touchDx! < data.highDx) {
        result = data;
        break;
      }
      listOfDx.add(data.dx);
    }
    // 터치 영역에서 제일 가까운 값 찾기.
    if (result == null) {
      listOfDx.add(touchDx);
      listOfDx.sort();
      var index = listOfDx.indexOf(touchDx);
      if (index == 0) {
        result = areas.first;
      } else if (touchDx == listOfDx.last) {
        result = areas.last;
      } else {
        var abs1 = (listOfDx[index - 1] - touchDx).abs();
        var abs2 = (touchDx! - listOfDx[index + 1]).abs();
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

    // double y = 0; //-tp.height * 0.5; // 텍스트의 방향을 고려해 y축 값을 보정해줍니다.
    double dx = result.lowDx - tp.width * 1.3 / 2 <= 0
        ? leftPadding // tp.width/2*1.3 - result.lowDx
        : result.highDx + tp.width >= size.width
            ? size.width - rightPadding - tp.width
            : result.dx - tp.width / 2; // 텍스트의 위치를 고려해 x축 값을 보정해줍니다.
    double dy = tp.height * 0.25 + 1;

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
          ..addPolygon([
            Offset(result.dx, dy),
            Offset(result.dx, size.height - bottomPadding)
          ], false),
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
    var height = size.height - topPadding - bottomPadding;
    return height +
        topPadding -
        (height / ySeperatedNum) *
            dy; //(height - dy) / ySeperatedNum * height + topWidgetHeight;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; //timeSugarLevelDataList.isNotEmpty;
  }

  Color _selectTextColor(double value) {
    return value >= upperThreshold
        ? Colors.redAccent
        : value <= lowerThreshold
            ? Colors.purpleAccent
            : Colors.greenAccent;
  }
}

class _SugarLevelChartBackgroundPainter extends CustomPainter {
  final double upperThreshold;
  final double normalThreshold;
  final double lowerThreshold;
  final double ySeperateSize;

  final double leftMargin;
  final double rightMargin;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  double areaWidth = 40;

  double lineWidth = 6;
  double spotWidth = 5;
  double fontSize = 15;

  ChartAreaData? chartAreaData;

  _SugarLevelChartBackgroundPainter(
      {required this.ySeperateSize,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      this.leftPadding = 15,
      this.topPadding = 30,
      this.rightPadding = 15,
      this.bottomPadding = 30,
      this.leftMargin = 25,
      this.rightMargin = 25});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    drawThresholdLine(canvas, size);
    canvas.drawPoints(
        PointMode.lines,
        [
          Offset(leftMargin, size.height - bottomPadding),
          Offset(size.width - rightMargin, size.height - bottomPadding)
        ],
        paint);
  }

  void drawThresholdLine(Canvas canvas, Size size) {
    List<Offset> upperThresholdOffsets = [];
    List<Offset> normalThresholdOffsets = [];
    List<Offset> lowerThresholdOffsets = [];
    var upperDy = calculatedDy(size, upperThreshold);
    var normalDy = calculatedDy(size, normalThreshold);
    var lowerDy = calculatedDy(size, lowerThreshold);
    var i = size.width - rightMargin;
    var last = leftMargin + leftPadding / 2;
    while (true) {
      upperThresholdOffsets.add(Offset(i, upperDy));
      normalThresholdOffsets.add(Offset(i, normalDy));
      lowerThresholdOffsets.add(Offset(i, lowerDy));
      i -= 10;
      if (i < last) {
        i = last;
        upperThresholdOffsets.add(Offset(i, upperDy));
        normalThresholdOffsets.add(Offset(i, normalDy));
        lowerThresholdOffsets.add(Offset(i, lowerDy));
        break;
      }
    }
    Paint paint = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..color = Colors.redAccent.shade100;
    canvas.drawPoints(PointMode.lines, upperThresholdOffsets, paint);
    paint.color = Colors.black26;
    canvas.drawPoints(PointMode.lines, normalThresholdOffsets, paint);
    paint.color = Colors.black26;
    canvas.drawPoints(PointMode.lines, lowerThresholdOffsets, paint);
    drawThresholdText(canvas, size, upperThreshold.toInt().toString(),
        Colors.redAccent.shade100, upperDy);
    drawThresholdText(canvas, size, normalThreshold.toInt().toString(),
        Colors.black38, normalDy,
        isDown: true);
    drawThresholdText(canvas, size, lowerThreshold.toInt().toString(),
        Colors.black38, lowerDy,
        isDown: true);
  }

  void drawThresholdText(
      Canvas canvas, Size size, String text, Color color, double y,
      {bool isDown = false}) {
    TextSpan maxSpan = TextSpan(
        style: TextStyle(
            fontSize: fontSize, color: color, fontWeight: FontWeight.bold),
        text: text);
    TextPainter tp =
        TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
    tp.layout();

    double dx = leftMargin - leftPadding / 2 - 8; // 텍스트의 위치를 고려해 x축 값을 보정해줍니다.
    double dy = y - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  double calculatedDy(Size size, double dy) {
    var height = size.height - topPadding - bottomPadding;
    return height +
        topPadding -
        (height / ySeperateSize) *
            dy; //(height - dy) / ySeperatedNum * height + topWidgetHeight;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; //timeSugarLevelDataList.isNotEmpty;
  }
}
