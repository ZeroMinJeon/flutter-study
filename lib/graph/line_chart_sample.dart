import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample1Screen extends StatelessWidget {
  LineChartSample1Screen({Key? key}) : super(key: key);

  List<FlSpot> s1 = [
    FlSpot(0, 5),
    FlSpot(1, 7),
    FlSpot(2, 9),
    FlSpot(3, 8),
    FlSpot(4, 8),
    FlSpot(5, 6),
    FlSpot(5, 5),
    FlSpot(6, 4.5),
    FlSpot(7, 8),
    FlSpot(8, 9),
    FlSpot(9, 8),
    FlSpot(10, 8.5),
    FlSpot(11, 8),
  ];

  List<FlSpot> s2 = [
    FlSpot(0, 5),
    FlSpot(1, 6.5),
    FlSpot(2, 7),
    FlSpot(3, 8),
    FlSpot(4, 7),
    FlSpot(5, 4.7),
    FlSpot(6, 4.5),
    FlSpot(7, 6),
    FlSpot(8, 7),
    FlSpot(9, 8),
    FlSpot(10, 8),
    FlSpot(11, 7.8),
  ];

  List<FlSpot> s3 = [
    FlSpot(0, 5),
    FlSpot(1, 4.5),
    FlSpot(2, 5),
    FlSpot(3, 5),
    FlSpot(4, 4),
    FlSpot(5, 4),
    FlSpot(6, 3.4),
    FlSpot(7, 4),
    FlSpot(8, 5),
    FlSpot(9, 6),
    FlSpot(10, 6),
    FlSpot(11, 5.5),
  ];
  List<FlSpot> s4 = [
    FlSpot(0, 5),
    FlSpot(1, 4.3),
    FlSpot(2, 4.5),
    FlSpot(3, 4),
    FlSpot(4, 3),
    FlSpot(5, 2.5),
    FlSpot(6, 3),
    FlSpot(7, 3.5),
    FlSpot(8, 4),
    FlSpot(9, 5),
    FlSpot(10, 5.6),
    FlSpot(11, 5.5),
  ];
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      color: Colors.purple,
      fontWeight: FontWeight.bold,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }
    return Center(
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);

    return Center(
      child: Text(
        '\$ ${value + 0.5}',
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.4,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: s1,
              aboveBarData: BarAreaData(
                  show: true,
                  cutOffY: 4,
                  color: Colors.white,
                  applyCutOffY: false),
              isCurved: true,
              barWidth: 2,
              color: Colors.redAccent,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: s2,
              isCurved: true,
              barWidth: 2,
              color: Colors.cyanAccent,
              dotData: FlDotData(
                show: false,
              ),
              // aboveBarData: BarAreaData(
              //     show: true,
              //     cutOffY: 4,
              //     color: Colors.white,
              //     applyCutOffY: false),
            ),
            LineChartBarData(
              spots: s3,
              isCurved: true,
              barWidth: 2,
              color: Colors.indigoAccent,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: s4,
              isCurved: true,
              barWidth: 2,
              color: Colors.amberAccent,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(11, 3),
              ],
              isCurved: true,
              barWidth: 2,
              color: Colors.black,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: const [
                FlSpot(0, 4),
                FlSpot(11, 4),
              ],
              isCurved: true,
              barWidth: 2,
              color: Colors.black,
              dotData: FlDotData(
                show: false,
              ),
            ),
            LineChartBarData(
              spots: const [
                FlSpot(0, 7),
                FlSpot(11, 7),
              ],
              isCurved: true,
              barWidth: 2,
              color: Colors.black,
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          betweenBarsData: [
            BetweenBarsData(
              fromIndex: 0,
              toIndex: 5,
              color: Colors.amber,
            ),
            BetweenBarsData(
              fromIndex: 1,
              toIndex: 5,
              color: Colors.amberAccent,
            ),
            BetweenBarsData(
              fromIndex: 0,
              toIndex: 6,
              color: Colors.red,
            ),
            BetweenBarsData(
              fromIndex: 1,
              toIndex: 6,
              color: Colors.redAccent,
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: leftTitleWidgets,
                interval: 1,
                reservedSize: 36,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            checkToShowHorizontalLine: (double value) {
              return value == 1 || value == 6 || value == 4 || value == 5;
            },
          ),
        ),
      ),
    );
  }
}
