import 'package:flutter/rendering.dart';

class ChartOffsetCalculator {
  final double leftMargin;
  final double topMargin;
  final double rightMargin;
  final double bottomMargin;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  final double xSeperateSize;
  final double ySeperateSize;

  ChartOffsetCalculator({
    required this.xSeperateSize,
    required this.ySeperateSize,
    this.leftMargin = 0,
    this.topMargin = 0,
    this.rightMargin = 0,
    this.bottomMargin = 0,
    this.leftPadding = 0,
    this.topPadding = 0,
    this.rightPadding = 0,
    this.bottomPadding = 0,
  });

  var alpha = 4 / 5;

  //BarChart
  double calculatedBarPartWidth(Size size) {
    var width =
        size.width - leftMargin - leftPadding - rightMargin - rightPadding;
    return width / (xSeperateSize + (xSeperateSize - 1) * alpha);
  }

  double calculateBarChartDx(Size size, int index) {
    var width =
        size.width - leftMargin - leftPadding - rightMargin - rightPadding;
    var parthWidth = width / (xSeperateSize + (xSeperateSize - 1) * alpha);
    return parthWidth * (index + index * alpha) + leftMargin + leftPadding;
  }

  double calculateBarChartDy(Size size, double value) {
    var height =
        size.height - topMargin - topPadding - bottomMargin - bottomPadding;
    var partHeight = height / ySeperateSize;
    return partHeight * (ySeperateSize - value) + topMargin + topPadding;
  }

  Offset calculateBarChartOffset(Size size, int index, double value) => Offset(
      calculateBarChartDx(size, index), calculateBarChartDy(size, value));

  Offset calculateBarChartGroundTextOffset(
          Size size, int index, Size textSize, bool isWeekly) =>
      Offset(
          calculateBarChartDx(size, index) +
              calculatedBarPartWidth(size) / 2 -
              textSize.width / (isWeekly ? 2 : 4),
          size.height - bottomMargin - bottomPadding + textSize.height / 2);

  Offset calculateLineChartGroundTextOffset(
          Size size, int index, Size textSize, bool isWeekly) =>
      Offset(calculateLineChartDx(size, index)+ (isWeekly ? - textSize.width / 2 : 4),
          size.height - bottomMargin - bottomPadding + textSize.height);

  List<Offset> calculateBarChartGroundTextLineOffsetList(
      Size size, int index, Size textSize) {
    var dx = calculateBarChartDx(size, index) -
        calculatedBarPartWidth(size) * alpha / 2;
    var dy = size.height - bottomPadding - bottomMargin;
    return [Offset(dx, dy), Offset(dx, dy + textSize.height * 1.8)];
  }

  List<Offset> calculateLineChartGroundTextLineOffsetList(
      Size size, int index, Size textSize) {
    var dx = calculateLineChartDx(size, index);
    var dy = size.height - bottomPadding - bottomMargin;
    return [Offset(dx, dy), Offset(dx, dy + textSize.height * 1.8)];
  }

  Offset calculateBarChartThresholdTextOffset(
          Size size, double threshold, Size textSize) =>
      Offset(leftMargin,
          calculateBarChartDy(size, threshold) + textSize.height / 3);

  Offset calculateTextOffset(
      Size size, Size tpSize, double lowDx, double dx, double width) {
    double x = dx + width / 2 - tpSize.width / 2;
    if (x - tpSize.width * 0.15 <= leftMargin) {
      x = leftMargin+tpSize.width *0.15;
    } else if (x + tpSize.width * 1.15 >= size.width - rightMargin) {
      x = size.width - rightMargin - tpSize.width * 1.15 + width / 2;
    }
    double y = tpSize.height * 0.25 + 1;

    return Offset(x, y);
  }

  // line graph
  double calculateLineChartDx(Size size, int index) {
    // index start = 0
    var width =
        size.width - leftMargin - leftPadding - rightMargin - rightPadding;
    var partWidth = width / xSeperateSize;
    return leftMargin + leftPadding + index * partWidth;
  }

  double calculateLineGraphDy(Size size, double value) {
    var height =
        size.height - topMargin - topPadding - bottomMargin - bottomPadding;
    var partHeight = height / ySeperateSize;
    return height + topMargin + topPadding - partHeight * value;
  }
}
