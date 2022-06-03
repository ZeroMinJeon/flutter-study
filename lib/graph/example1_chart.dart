import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Example1ChartScreen extends StatelessWidget {
  const Example1ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sample1,
      swapAnimationDuration: const Duration(microseconds: 100),
    );
  }

  LineChartData get sample1 =>
      LineChartData(titlesData: titlesData1, lineBarsData: lineBarsData1,
      minX: 20220522,
      minY: 0,
      maxX: 20220530,
      maxY: 240);

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3
      ];

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '70';
        break;
      case 2:
        text = '140';
        break;
      case 3:
        text = '200';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 20220523:
        text = const Text('5/23', style: style);
        break;
      case 20220524:
        text = const Text('5/24', style: style);
        break;
      case 20220525:
        text = const Text('5/25', style: style);
        break;
      case 20220526:
        text = const Text('5/26', style: style);
        break;
      case 20220527:
        text = const Text('5/27', style: style);
        break;
      case 20220528:
        text = const Text('5/28', style: style);
        break;
      case 20220529:
        text = const Text('5/29', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    return Center(
      child: text,
    );
  }

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff4af699),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(20220523, 70),
          // FlSpot(20220524, 80),
          // FlSpot(20220525, 85),
          // FlSpot(20220526, 92),
          // FlSpot(20220527, 85),
          // FlSpot(20220528, 70),
          FlSpot(20220529, 70),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0xffaa4cfc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: const [
          FlSpot(20220523, 160),
          FlSpot(20220524, 140),
          FlSpot(20220525, 130),
          FlSpot(20220526, 120),
          FlSpot(20220527, 140),
          FlSpot(20220528, 150),
          FlSpot(20220529, 145),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff27b6fc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(20220523, 210),
          FlSpot(20220524, 220),
          FlSpot(20220525, 180),
          FlSpot(20220526, 190),
          FlSpot(20220527, 200),
          FlSpot(20220528, 194),
          FlSpot(20220529, 176),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x444af699),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(20220522, 70),
          // FlSpot(20220524, 220),
          // FlSpot(20220525, 180),
          // FlSpot(20220526, 190),
          // FlSpot(20220527, 200),
          // FlSpot(20220528, 194),
          FlSpot(20220529, 70),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0x99aa4cfc),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: const Color(0x33aa4cfc),
        ),
        spots: const [
          FlSpot(20220522, 140),
          // FlSpot(20220524, 220),
          // FlSpot(20220525, 180),
          // FlSpot(20220526, 190),
          // FlSpot(20220527, 200),
          // FlSpot(20220528, 194),
          FlSpot(20220529, 140),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.redAccent,
        barWidth: 2,
        isStrokeCapRound: false,
        dotData: FlDotData(show: false),

        // belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(20220522, 200),
          // FlSpot(20220524, 220),
          // FlSpot(20220525, 180),
          // FlSpot(20220526, 190),
          // FlSpot(20220527, 200),
          // FlSpot(20220528, 194),
          FlSpot(20220529, 200),
        ],
      );
}
