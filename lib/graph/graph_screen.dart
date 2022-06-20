import 'package:flutter/material.dart';
import 'package:flutter3study/graph/sugar_level/draw_sugar_level_chart.dart';
import 'package:flutter3study/graph/sugar_level/sugar_level_chart_screen.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _renderWidget(context);
  }

  Widget _renderWidget(context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Graph Screen')),
        body: ListView(
          addRepaintBoundaries: false,
          children: [
            DrawSugarLevelChartScreen(),
            Container(
              height: 20,
              color: Colors.indigoAccent,
            ),
            SugarLevelChartScreen()
          ],
        ));
  }
}