import 'dart:ui';

class ChartData {
  ChartData(this.offset, this.value);

  final Offset offset;
  final double value;
}

class BarChartData extends ChartData {
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

  ChartAreaData(this.lowDx,this.dx, this.highDx, this.highValue, this.averageValue,
      this.lowValue, this.dy);
}
