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
  DateTime date = DateTime(2022, 5, 1);
  List<SugarLevelData> data = [
    SugarLevelData(DateTime(2022, 5, 1, 1), 30),
    SugarLevelData(DateTime(2022, 5, 1, 2), 70),
    SugarLevelData(DateTime(2022, 5, 1, 3, 10), 80),
    SugarLevelData(DateTime(2022, 5, 1, 3, 20), 90),
    SugarLevelData(DateTime(2022, 5, 1, 4), 90),
    SugarLevelData(DateTime(2022, 5, 1, 5), 90),
    SugarLevelData(DateTime(2022, 5, 1, 6), 100),
    SugarLevelData(DateTime(2022, 5, 1, 7), 120),
    SugarLevelData(DateTime(2022, 5, 1, 7), 110),
    SugarLevelData(DateTime(2022, 5, 1, 8), 130),
    SugarLevelData(DateTime(2022, 5, 1, 14), 140),
    SugarLevelData(DateTime(2022, 5, 1, 19), 150),
    SugarLevelData(DateTime(2022, 5, 1, 20), 210),
    SugarLevelData(DateTime(2022, 5, 1, 23), 100),
    SugarLevelData(DateTime(2022, 5, 2, 8), 100),
    SugarLevelData(DateTime(2022, 5, 2, 10), 140),
    SugarLevelData(DateTime(2022, 5, 2, 16), 120),
    SugarLevelData(DateTime(2022, 5, 2, 19), 150),
    SugarLevelData(DateTime(2022, 5, 3, 1), 100),
    SugarLevelData(DateTime(2022, 5, 3, 21), 120),
    SugarLevelData(DateTime(2022, 5, 4, 1), 120),
    SugarLevelData(DateTime(2022, 5, 5, 1), 100),
    SugarLevelData(DateTime(2022, 5, 5, 4), 70),
    SugarLevelData(DateTime(2022, 5, 6, 1), 100),
    SugarLevelData(DateTime(2022, 5, 6, 10), 10),
    SugarLevelData(DateTime(2022, 5, 7, 1), 100),
    SugarLevelData(DateTime(2022, 5, 8, 1), 120),
    SugarLevelData(DateTime(2022, 5, 12, 1), 130),
    SugarLevelData(DateTime(2022, 5, 14, 1), 120),
    SugarLevelData(DateTime(2022, 5, 18, 1), 110),
    SugarLevelData(DateTime(2022, 5, 19, 1), 100),
    SugarLevelData(DateTime(2022, 5, 20, 1), 120),
    SugarLevelData(DateTime(2022, 5, 21, 1), 100),
  ];

  List<TimeSugarLevelData> timeSugarLevelDataList = [];
  double ySeperateSize = 230;
  double upperThreshold = 180;
  double normalThreshold = 120;
  double lowerThreshold = 70;

  double leftPadding = 100;
  double topPadding = 100;
  double rightPadding = 100;
  double bottomPadding = 50;

  @override
  void initState() {
    super.initState();
    checkWeekData(isFirst: true);
  }

  void checkWeekData({bool isFirst = false}) {
    var thisWeekday = date.weekday;
    List<TimeSugarLevelData> result = [];
    data.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);
    var startDate = DateTime(
        date.year, date.month, date.day - (thisWeekday == 7 ? 0 : thisWeekday));
    if (!isFirst &&
        timeSugarLevelDataList.isNotEmpty &&
        startDate.isAtSameMomentAs(timeSugarLevelDataList.first.date)) return;
    for (int i = 0; i < 7; i++) {
      var aDate = DateTime(startDate.year, startDate.month, startDate.day + i);
      var bDate =
          DateTime(startDate.year, startDate.month, startDate.day + i + 1);
      for (var d in data) {
        if ((d.date.isAfter(aDate) || d.date.isAtSameMomentAs(aDate)) &&
            d.date.isBefore(bDate)) {
          var index = result
              .indexWhere((element) => element.date.isAtSameMomentAs(aDate));
          if (index != -1) {
            result[index].addLevel(d.level);
          } else {
            result.add(TimeSugarLevelData.fromLevelAndDate(aDate, d.level));
          }
        } else {
          continue;
        }
      }
    }
    setState(() {
      timeSugarLevelDataList = [...result];
      var highY = result.fold<double>(
          0,
          (previousValue, element) => previousValue > element.highLevel
              ? previousValue
              : element.highLevel);
      ySeperateSize = ySeperateSize > highY ? ySeperateSize : highY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        FittedBox(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: Stack(
              children: [
                _ChartBackground(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  ySeperateSize: ySeperateSize,
                  upperThreshold: upperThreshold,
                  normalThreshold: normalThreshold,
                  lowerThreshold: lowerThreshold,
                  leftPadding: leftPadding,
                  rightPadding: rightPadding,
                  topPadding: topPadding,
                  bottomPadding: bottomPadding,
                ),
                _ChartForGround(
                  timeSugarLevelDataList: timeSugarLevelDataList,
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  ySeperateSize: ySeperateSize,
                  upperThreshold: upperThreshold,
                  normalThreshold: normalThreshold,
                  lowerThreshold: lowerThreshold,
                  leftPadding: leftPadding,
                  rightPadding: rightPadding,
                  topPadding: topPadding,
                  bottomPadding: bottomPadding,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  setState(() => date = date.subtract(Duration(days: 1)));
                  checkWeekData();
                },
                icon: Icon(Icons.remove)),
            Text('${date.year}.${date.month}.${date.day}'),
            IconButton(
                onPressed: () {
                  setState(() => date = date.add(Duration(days: 1)));
                  checkWeekData();
                },
                icon: Icon(Icons.add))
          ],
        )
      ]),
    );
  }
}

class _ChartForGround extends StatefulWidget {
  final double width;
  final double height;
  final double ySeperateSize;
  final double upperThreshold;
  final double normalThreshold;
  final double lowerThreshold;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  final List<TimeSugarLevelData> timeSugarLevelDataList;

  const _ChartForGround(
      {Key? key,
      required this.width,
      required this.height,
      required this.ySeperateSize,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      required this.timeSugarLevelDataList,
      this.leftPadding = 100,
      this.topPadding = 50,
      this.rightPadding = 100,
      this.bottomPadding = 100})
      : super(key: key);

  @override
  State<_ChartForGround> createState() => _ChartForGroundState();
}

class _ChartForGroundState extends State<_ChartForGround> {
  double? touchDx;

  late List<ChartData> chartData;

  void calculatedData() {
    chartData = widget.timeSugarLevelDataList
        .map((data) => ChartData.fromTimeSugarLevelData(
            data,
            Size(widget.width, widget.height),
            widget.leftPadding,
            widget.topPadding,
            widget.rightPadding,
            widget.bottomPadding,
            100,
            100,
            1,
            widget.ySeperateSize))
        .toList();
  }

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
    } else if (!oldWidget.timeSugarLevelDataList.first.date
        .isAtSameMomentAs(widget.timeSugarLevelDataList.first.date)) {
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
              painter: _WeekSugarLevelChart(
                  chartDataList: chartData,
                  ySeperatedNum: widget.ySeperateSize,
                  upperThreshold: widget.upperThreshold,
                  normalThreshold: widget.normalThreshold,
                  lowerThreshold: widget.lowerThreshold,
                  touchDx: touchDx),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChartBackground extends StatelessWidget {
  final double width;
  final double height;
  final double ySeperateSize;
  final double upperThreshold;
  final double normalThreshold;
  final double lowerThreshold;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;

  const _ChartBackground(
      {Key? key,
      required this.width,
      required this.height,
      required this.ySeperateSize,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      this.leftPadding = 100,
      this.topPadding = 50,
      this.rightPadding = 100,
      this.bottomPadding = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          size: Size(width, height),
          painter: _WeekSugarLevelBackgroundChart(
              ySeperateSize: ySeperateSize,
              upperThreshold: upperThreshold,
              normalThreshold: normalThreshold,
              lowerThreshold: lowerThreshold,
              leftPadding: leftPadding,
              topPadding: topPadding,
              rightPadding: rightPadding,
              bottomPadding: bottomPadding),
        ),
      ),
    );
  }
}

class _WeekSugarLevelChart extends CustomPainter {
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

  _WeekSugarLevelChart(
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
    if (touchDx == null) {
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

class _WeekSugarLevelBackgroundChart extends CustomPainter {
  final double upperThreshold;
  final double normalThreshold;
  final double lowerThreshold;
  final double ySeperateSize;

  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  double areaWidth = 40;

  double lineWidth = 6;
  double spotWidth = 5;
  double fontSize = 15;

  ChartAreaData? chartAreaData;

  _WeekSugarLevelBackgroundChart(
      {required this.ySeperateSize,
      required this.upperThreshold,
      required this.normalThreshold,
      required this.lowerThreshold,
      this.leftPadding = 100,
      this.topPadding = 50,
      this.rightPadding = 100,
      this.bottomPadding = 100});

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
          Offset(leftPadding, size.height - bottomPadding),
          Offset(size.width - rightPadding, size.height - bottomPadding)
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

    double dx = leftPadding - tp.width - 5; // 텍스트의 위치를 고려해 x축 값을 보정해줍니다.
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
