import 'package:flutter/material.dart';
import 'package:flutter3study/graph/sugar_level/data.dart';
import 'package:flutter3study/graph/sugar_level/sugar_level_chart_painter.dart';

class SugarLevelChartScreen extends StatefulWidget {
  SugarLevelChartScreen({Key? key}) : super(key: key);

  @override
  State<SugarLevelChartScreen> createState() => _SugarLevelChartScreenState();
}

class _SugarLevelChartScreenState extends State<SugarLevelChartScreen> {
  double ySeperateSize = 230;
  double upperThreshold = 180;
  double normalThreshold = 120;
  double lowerThreshold = 70;

  double leftMargin = 100;
  double rightMargin = 100;
  double leftPadding = 100;
  double topPadding = 100;
  double rightPadding = 100;
  double bottomPadding = 50;

  List<TimeSugarLevelData> timeSugarLevelDataList = [];

  bool isWeeklyMode = false;

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

  @override
  void initState() {
    super.initState();
    checkWeekData(isFirst: true);
  }

  @override
  void didChangeDependencies() {
    settingPaddingAndMargin();
    super.didChangeDependencies();
  }

  void settingPaddingAndMargin() {
    var size = MediaQuery.of(context).size;
    var horizontalMargin = 25 * size.width / 375;
    var horizontalPadding = 15 * size.width / 375;
    var verticalPadding = 30 * size.height / 812;
    setState(() {
      leftMargin = horizontalMargin;
      rightMargin = horizontalMargin;
      leftPadding = horizontalPadding;
      rightPadding = horizontalPadding;
      topPadding = verticalPadding;
      bottomPadding = verticalPadding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SugarLevelChartWidget(
            width: MediaQuery.of(context).size.width,
            height: 400,
            ySeperateSize: ySeperateSize,
            upperThreshold: 160,
            normalThreshold: 120,
            lowerThreshold: 70,
            timeSugarLevelDataList: timeSugarLevelDataList,
            isWeeklyMode: isWeeklyMode,
            leftMargin: 30,
            rightMargin: 30,
            leftPadding: 20,
            rightPadding: 20,
            topPadding: 20,
            bottomPadding: 20,
          ),
          TextButton(
              onPressed: () {
                setState(() => isWeeklyMode = !isWeeklyMode);
                if (isWeeklyMode) {
                  checkWeekData(isFirst: true);
                } else {
                  checkMonthData(isFirst: true);
                }
              },
              child: Text(isWeeklyMode ? '♥️' : '❤️‍')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    if (isWeeklyMode) {
                      setState(() => date = date.subtract(Duration(days: 1)));
                      checkWeekData();
                    } else {
                      setState(() =>
                          date = DateTime(date.year, date.month - 1, date.day));
                      isWeeklyMode ? checkWeekData() : checkMonthData();
                    }
                  },
                  icon: Icon(Icons.remove)),
              Text('${date.year}.${date.month}.${date.day}'),
              IconButton(
                  onPressed: () {
                    if (isWeeklyMode) {
                      setState(() => date = date.add(Duration(days: 1)));
                      checkWeekData();
                    } else {
                      setState(() =>
                          date = DateTime(date.year, date.month + 1, date.day));
                      isWeeklyMode ? checkWeekData() : checkMonthData();
                    }
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        ],
      ),
    );
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

  void checkMonthData({bool isFirst = false}) {
    var firstDay = DateTime(date.year, date.month, 1);
    var nextMonthFirstDay = DateTime(date.year, date.month + 1, 1);
    if (!isFirst &&
        timeSugarLevelDataList.isNotEmpty &&
        (timeSugarLevelDataList.first.date.isAtSameMomentAs(firstDay) ||
            (firstDay.isBefore(timeSugarLevelDataList.first.date) &&
                nextMonthFirstDay
                    .isAfter(timeSugarLevelDataList.first.date)))) {
      return;
    }
    List<TimeSugarLevelData> result = [];
    var removeList = [];
    var sortData = data
        .where((element) =>
            firstDay.isAtSameMomentAs(element.date) ||
            (firstDay.isBefore(element.date) &&
                nextMonthFirstDay.isAfter(element.date)))
        .toList()
      ..sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);

    if (sortData.isEmpty) {
      setState(() {
        timeSugarLevelDataList = [];
        ySeperateSize = 230;
      });
      return;
    }

    for (var aDate = firstDay; aDate.isBefore(nextMonthFirstDay);) {
      var bDate = aDate.add(Duration(days: 1));
      for (var d in sortData) {
        if ((d.date.isAfter(aDate) || d.date.isAtSameMomentAs(aDate)) &&
            d.date.isBefore(bDate)) {
          var index = result
              .indexWhere((element) => element.date.isAtSameMomentAs(aDate));
          if (index != -1) {
            result[index].addLevel(d.level);
            removeList.add(d);
          } else {
            result.add(TimeSugarLevelData.fromLevelAndDate(aDate, d.level));
            removeList.add(d);
          }
        } else {
          continue;
        }
      }
      for (var data in removeList) {
        sortData.remove(data);
      }
      removeList = [];
      aDate = bDate;
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
}
