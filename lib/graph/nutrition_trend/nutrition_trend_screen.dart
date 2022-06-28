import 'package:flutter/material.dart';
import 'package:flutter3study/graph/nutrition_trend/data.dart';
import 'package:flutter3study/graph/nutrition_trend/nutrition_trend_painter.dart';

class NutritionTrendScreen extends StatefulWidget {
  const NutritionTrendScreen({Key? key}) : super(key: key);

  @override
  State<NutritionTrendScreen> createState() => _NutritionTrendScreenState();
}

class _NutritionTrendScreenState extends State<NutritionTrendScreen> {
  double ySeperateSize = 230;
  double upperThreshold = 2000;
  double normalThreshold = 1000;
  double lowerThreshold = 1000;
  double xSeperateSize = 7;

  double leftMargin = 30;
  double rightMargin = 30;
  double leftPadding = 50;
  double topPadding = 30;
  double rightPadding = 30;
  double bottomPadding = 50;

  bool isWeeklyMode = false;

  DateTime date = DateTime(2022, 5, 1);

  List<NutritionTrendData> nutritionTrendDataList = [];

  List<NutritionTrendData> data = [
    NutritionTrendData(DateTime(2022, 5, 1), 2000),
    NutritionTrendData(DateTime(2022, 5, 2), 2200),
    NutritionTrendData(DateTime(2022, 5, 3), 2300),
    NutritionTrendData(DateTime(2022, 5, 4), 1100),
    NutritionTrendData(DateTime(2022, 5, 5), 1900),
    NutritionTrendData(DateTime(2022, 5, 6), 2200),
    NutritionTrendData(DateTime(2022, 5, 7), 1500),
    NutritionTrendData(DateTime(2022, 5, 9), 2500),
    NutritionTrendData(DateTime(2022, 5, 11), 2000),
    NutritionTrendData(DateTime(2022, 5, 14), 1800),
    NutritionTrendData(DateTime(2022, 5, 15), 900),
    NutritionTrendData(DateTime(2022, 5, 16), 1000),
    NutritionTrendData(DateTime(2022, 5, 17), 2200),
    NutritionTrendData(DateTime(2022, 5, 18), 2000),
    NutritionTrendData(DateTime(2022, 5, 20), 1900),
    NutritionTrendData(DateTime(2022, 5, 21), 2300),
    NutritionTrendData(DateTime(2022, 5, 22), 1200),
    NutritionTrendData(DateTime(2022, 5, 23), 1500),
    NutritionTrendData(DateTime(2022, 5, 24), 1900),
    NutritionTrendData(DateTime(2022, 5, 25), 1000),
    NutritionTrendData(DateTime(2022, 5, 26), 900),
    NutritionTrendData(DateTime(2022, 5, 27), 400),
    NutritionTrendData(DateTime(2022, 5, 28), 1000),
    NutritionTrendData(DateTime(2022, 5, 29), 2000),
    NutritionTrendData(DateTime(2022, 5, 30), 2300),
    NutritionTrendData(DateTime(2022, 5, 31), 2500),
    NutritionTrendData(DateTime(2022, 5, 32), 2100),
    NutritionTrendData(DateTime(2022, 4, 1), 2000),
    NutritionTrendData(DateTime(2022, 4, 2), 2200),
    NutritionTrendData(DateTime(2022, 4, 3), 2300),
    NutritionTrendData(DateTime(2022, 4, 4), 1100),
    NutritionTrendData(DateTime(2022, 4, 5), 1900),
    NutritionTrendData(DateTime(2022, 4, 6), 2200),
    NutritionTrendData(DateTime(2022, 4, 7), 1500),
    NutritionTrendData(DateTime(2022, 4, 9), 2500),
    NutritionTrendData(DateTime(2022, 4, 11), 2000),
    NutritionTrendData(DateTime(2022, 4, 14), 1800),
    NutritionTrendData(DateTime(2022, 4, 15), 900),
    NutritionTrendData(DateTime(2022, 4, 16), 1000),
    NutritionTrendData(DateTime(2022, 4, 17), 2200),
    NutritionTrendData(DateTime(2022, 4, 18), 2000),
    NutritionTrendData(DateTime(2022, 4, 20), 1900),
    NutritionTrendData(DateTime(2022, 4, 21), 2300),
    NutritionTrendData(DateTime(2022, 4, 22), 1200),
    NutritionTrendData(DateTime(2022, 4, 23), 1500),
    NutritionTrendData(DateTime(2022, 4, 24), 1900),
    NutritionTrendData(DateTime(2022, 4, 25), 1000),
    NutritionTrendData(DateTime(2022, 4, 26), 900),
    NutritionTrendData(DateTime(2022, 4, 27), 400),
    NutritionTrendData(DateTime(2022, 4, 28), 1000),
    NutritionTrendData(DateTime(2022, 4, 29), 2000),
    NutritionTrendData(DateTime(2022, 4, 30), 2300),
  ];

  @override
  void initState() {
    super.initState();
    checkMonthData(isFirst: true);
  }

  @override
  void didChangeDependencies() {
    settingPaddingAndMargin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          NutritionTrendChartWidget(
              width: MediaQuery.of(context).size.width,
              height: 400,
              xSeperateSize: xSeperateSize,
              ySeperateSize: ySeperateSize,
              upperThreshold: upperThreshold,
              normalThreshold: normalThreshold,
              lowerThreshold: lowerThreshold,
              leftMargin: leftMargin,
              rightMargin: rightMargin,
              leftPadding: leftPadding,
              topPadding: topPadding,
              rightPadding: rightPadding,
              bottomPadding: bottomPadding,
              nutritionTrendDataList: nutritionTrendDataList,
              isWeeklyMode: isWeeklyMode),
          TextButton(
              onPressed: () {
                setState(() => isWeeklyMode = !isWeeklyMode);
                if (isWeeklyMode) {
                  checkWeekData(isFirst: true);
                } else {
                  checkMonthData(isFirst: true);
                }
              },
              child: Text(isWeeklyMode ? '주' : '월️‍')),
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

  void settingPaddingAndMargin() {
    var size = MediaQuery.of(context).size;
    var horizontalMargin = 20 * size.width / 375;
    var horizontalPadding = 10 * size.width / 375;
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

  void checkWeekData({bool isFirst = false}) {
    var thisWeekday = date.weekday;
    List<NutritionTrendData> result = [];
    data.sort((a, b) => a.date.isBefore(b.date) ? 0 : 1);
    var startDate = DateTime(
        date.year, date.month, date.day - (thisWeekday == 7 ? 0 : thisWeekday));
    var endDate = DateTime(date.year, date.month,
        date.day + (thisWeekday == 7 ? 6 : 6 - thisWeekday));
    if (!isFirst &&
        nutritionTrendDataList.isNotEmpty &&
        (startDate.isAtSameMomentAs(nutritionTrendDataList.first.date) ||
            (startDate.isBefore(nutritionTrendDataList.first.date))) &&
        (endDate.isAtSameMomentAs(nutritionTrendDataList.last.date) ||
            (endDate.isAfter(nutritionTrendDataList.last.date)))) return;
    for (int i = 0; i < 7; i++) {
      var aDate = DateTime(startDate.year, startDate.month, startDate.day + i);
      for (var d in data) {
        if (d.date.isAtSameMomentAs(aDate)) {
          result.add(d);
        }
      }
    }
    setState(() {
      nutritionTrendDataList = [...result];
      var highY = result.fold<double>(
          0,
          (previousValue, element) => previousValue > (element.cal ?? 0)
              ? previousValue
              : element.cal!);
      ySeperateSize = ySeperateSize > highY ? ySeperateSize : highY + 500;
      xSeperateSize = 7;
    });
  }

  void checkMonthData({bool isFirst = false}) {
    var firstDay = DateTime(date.year, date.month, 1);
    var nextMonthFirstDay = DateTime(date.year, date.month + 1, 1);
    if (!isFirst &&
        nutritionTrendDataList.isNotEmpty &&
        (nutritionTrendDataList.first.date.isAtSameMomentAs(firstDay) ||
            (firstDay.isBefore(nutritionTrendDataList.first.date) &&
                nextMonthFirstDay
                    .isAfter(nutritionTrendDataList.first.date))) &&
        (nutritionTrendDataList.last.date.isAtSameMomentAs(firstDay) ||
            (firstDay.isBefore(nutritionTrendDataList.last.date) &&
                nextMonthFirstDay.isAfter(nutritionTrendDataList.last.date)))) {
      return;
    }
    List<NutritionTrendData> result = [];
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
        nutritionTrendDataList = [];
        ySeperateSize = 2400;
      });
      return;
    }

    for (var aDate = firstDay; aDate.isBefore(nextMonthFirstDay);) {
      var bDate = aDate.add(Duration(days: 1));
      for (var d in sortData) {
        if (d.date.isAtSameMomentAs(aDate)) {
          var index = result
              .indexWhere((element) => element.date.isAtSameMomentAs(aDate));
          if (index != -1) {
            result.add(d);
            removeList.add(d);
          } else {
            result.add(d);
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
      nutritionTrendDataList = [...result];
      var highY = result.fold<double>(
          0,
          (previousValue, element) => previousValue > (element.cal ?? 0)
              ? previousValue
              : element.cal!);
      ySeperateSize = ySeperateSize > highY ? ySeperateSize : highY + 500;
      xSeperateSize = DateTime(date.year, date.month + 1, 1)
          .subtract(Duration(days: 1))
          .day
          .toDouble();
    });
  }
}
