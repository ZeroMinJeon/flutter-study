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

class SugarLevelChartData extends SugarLevelData {
  final double dx;
  final double dy;

  SugarLevelChartData(super.date, super.level, this.dx, this.dy);

  Offset get offset => Offset(dx, dy);

  factory SugarLevelChartData.fromSugarLevelData(SugarLevelData data, Size size,
      {required double leftMargin,
      required double rightMargin,
      required double leftPadding,
      required double topPadding,
      required double rightPadding,
      required double bottomPadding,
      required double ySeperateSize}) {

    int xSeperateSize = 86400;

    var x = data.date.second + data.date.minute * 60 + data.date.hour * 3600;

    var width =
        size.width - leftMargin - rightMargin - leftPadding - rightPadding;
    var height = size.height - topPadding - bottomPadding;
    var partWidth = width / xSeperateSize;
    var partHeight = height / ySeperateSize;

    var dx = leftMargin + leftPadding + partWidth * x;
    var dy = height + topPadding - partHeight * data.level;

    return SugarLevelChartData(data.date, data.level, dx, dy);
  }

  factory SugarLevelChartData.fromOffsetThreshold(
      double dx, double threshold, DateTime preDate, Size size,
      {required double leftMargin,
      required double rightMargin,
      required double leftPadding,
      required double topPadding,
      required double rightPadding,
      required double bottomPadding,
      required double ySeperateSize}) {
    int xSeperateSize = 86400;

    var width =
        size.width - leftMargin - rightMargin - leftPadding - rightPadding;
    var height = size.height - topPadding - bottomPadding;
    var partWidth = width / xSeperateSize;
    var partHeight = height / ySeperateSize;

    var x = (dx - leftMargin - leftPadding) / partWidth;
    var dy = height + topPadding - partHeight * threshold;
    var hour = x ~/ 3600;
    var minute = (x % 3600) ~/ 60;
    var second = ((x % 3600) % 60).toInt();
    DateTime date = DateTime(
        preDate.year, preDate.month, preDate.day, hour, minute, second);

    return SugarLevelChartData(date, threshold, dx, dy);
  }
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
  int mode = 0; // 0 :time, 1: week: 2: month

  ChartData(this.timeSugarLevelData);

  double get interval => mode == 0
      ? 10.0
      : mode == 1
          ? 50
          : 10;

  double get lowDx => dx - interval;

  double get highDx => dx + interval;

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
      double rightMargin,
      double leftPadding,
      double topPadding,
      double rightPadding,
      double bottomPadding,
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
        xSeperateSize = 6;
        break;
      case 2: //month
        x = data.day - 1;
        xSeperateSize = DateTime(data.date.year, data.date.month + 1, 1)
                .subtract(const Duration(days: 1))
                .day -
            1;
        break;
    }

    var width =
        size.width - leftMargin - rightMargin - leftPadding - rightPadding;
    var height = size.height - topPadding - bottomPadding;
    var partWidth = width / xSeperateSize;
    var partHeight = height / ySeperateSize;

    chartData.dx = leftPadding + leftMargin + partWidth * x;
    chartData.highDy = height + topPadding - partHeight * data.highLevel;
    chartData.averageDy = height + topPadding - partHeight * data.averageLevel;
    chartData.lowDy = height + topPadding - partHeight * data.lowLevel;

    return chartData;
  }
}
