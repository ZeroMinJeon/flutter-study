import 'dart:ui';

class ChartData1 {
  ChartData1(this.offset, this.value);

  final Offset offset;
  final double value;
}

class BarChartData extends ChartData1 {
  BarChartData(super.offset, super.value, this.highValue, this.lowValue);

  final double highValue;
  final double lowValue;
}

class ChartAreaData {
  final double lowDx;
  final double dx;
  final double highDx;
  final double highValue;
  final double averageValue;
  final double lowValue;
  final double dy;

  ChartAreaData(this.lowDx, this.dx, this.highDx, this.highValue,
      this.averageValue, this.lowValue, this.dy);
}

class SugarLevelData {
  final DateTime date;
  final double level;

  SugarLevelData(this.date, this.level);
}

class TimeSugarLevelData {
  final DateTime date;
  List<double> levels = [];

  TimeSugarLevelData(this.date);

  int get hour => date.hour;

  int get weekday => date.weekday;

  int get day => date.day;

  int get month => date.month;

  List<double> get sortedValue => levels..sort();

  double get lowLevel => sortedValue.first;

  //levels.isNotEmpty ? sortedValue.first : null;

  double get highLevel => sortedValue.last;

  //levels.isNotEmpty ? sortedValue.last : null;

  double get averageLevel =>
      levels.reduce((value, element) => value + element) / levels.length;

  //levels.isNotEmpty
  // ? levels.reduce((value, element) => value + element) / levels.length
  // : null;

  void addLevel(double newLevel) => levels.add(newLevel);

  void addLevels(List<double> newLevels) => levels.addAll(newLevels);

  factory TimeSugarLevelData.fromLevelAndDate(DateTime date, double level) =>
      TimeSugarLevelData(date)..addLevel(level);
}

class ChartData {
  final TimeSugarLevelData timeSugarLevelData;
  double dx = .0;
  double lowDy = .0;
  double averageDy = .0;
  double highDy = .0;

  ChartData(this.timeSugarLevelData);

  double get lowDx => dx - 50;

  double get highDx => dx + 50;

  String get toStringSugarData =>
      'low: ${timeSugarLevelData.lowLevel}, average: ${timeSugarLevelData.averageLevel}, high: ${timeSugarLevelData.highLevel}.';

  String get toStringData =>
      '$toStringSugarData dx: $dx, lowDy: $lowDy, averageDy: $averageDy, highDy: $highDy';

  ChartAreaData toChartAreaData() => ChartAreaData(
      lowDx,
      dx,
      highDx,
      timeSugarLevelData.highLevel,
      timeSugarLevelData.averageLevel,
      timeSugarLevelData.lowLevel,
      0);

  factory ChartData.fromTimeSugarLevelData(
      TimeSugarLevelData data,
      Size size,
      double leftMargin,
      double topMargin,
      double rightMargin,
      double bottomMargin,
      double leftPadding,
      double rightPadding,
      int mode,
      double ySeperateSize) {
    ChartData chartData = ChartData(data);
    var x = 0;
    int xSeperateSize = 0;
    switch (mode) {
      case 0: //hour
        x = data.hour;
        xSeperateSize = 24;
        break;
      case 1: //week
        x = data.weekday == 7 ? 0 : data.weekday;
        xSeperateSize = 7;
        break;
      case 2: //month
        x = data.day;
        xSeperateSize = DateTime(data.date.year, data.date.month + 1, 1)
            .subtract(const Duration(days: 1))
            .day;
        break;
    }

    var width =
        size.width - leftMargin - rightMargin - leftPadding - rightPadding;
    var height = size.height - topMargin - bottomMargin;
    var partWidth = width / xSeperateSize;
    var partHeight = height / ySeperateSize;

    chartData.dx = leftPadding + leftMargin + partWidth * x;
    chartData.highDy = height + topMargin - partHeight * data.highLevel;
    chartData.averageDy = height + topMargin - partHeight * data.averageLevel;
    chartData.lowDy = height + topMargin - partHeight * data.lowLevel;

    return chartData;
  }
}
