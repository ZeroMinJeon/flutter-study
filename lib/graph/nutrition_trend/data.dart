import 'dart:ui';

class NutritionTrendData {
  final DateTime date;
  final double? cal;

  NutritionTrendData(this.date, this.cal);

  // final double? carb;
  // final double? protein;
  // final double? fat;
  // final double? sugar;
  //
  // NutritionTrendData({
  //   required this.date,
  //   this.cal,
  //   this.carb,
  //   this.protein,
  //   this.fat,
  //   this.sugar,
  // });

  int get day => date.day;

  int get weekDay => date.weekday == 7 ? 0 : date.weekday;

  int get month => date.month;
}

class NutritionTrendChartData {
  final NutritionTrendData data;
  final double dx;
  final double width;
  final double dy;
  final bool isWeekly;

  NutritionTrendChartData(
      {required this.data,
      required this.dx,
      required this.width,
      required this.dy,
      required this.isWeekly});

  Offset get offset => Offset(dx, dy);

  double get interval => width / 4;

  double get centerDx => dx + width / 2;

  double get lowDx => centerDx - interval;

  double get highDx => centerDx + interval;

  String get toDataText => '${data.month}.${data.day} ${data.cal} kcal';

  factory NutritionTrendChartData.fromNutritionTrendData(
      NutritionTrendData data,
      {required Offset offset,
      required double width,
      required bool isWeekly}) {
    return NutritionTrendChartData(
        data: data,
        dx: offset.dx,
        dy: offset.dy,
        width: width,
        isWeekly: isWeekly);
  }
}
