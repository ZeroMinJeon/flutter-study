import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter3study/graph/curve_painter.dart';
import 'package:flutter3study/graph/custom_shape.dart';
import 'package:flutter3study/graph/example1_chart.dart';
import 'package:flutter3study/graph/line_chart_sample.dart';
import 'package:flutter3study/graph/line_chart_sample2.dart';

// import 'package:flutter3study/graph/line_chart.dart';
import 'package:flutter3study/graph/pi_chart.dart';
import 'package:get/get.dart';
import 'package:widget_to_image/widget_to_image.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  ByteData? _byteData;
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Graph Screen')),
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(width: 300, height: 300, child: LineChartSample1Screen()),
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                  width: 300,
                  height: 300,
                  child: LineChartSample2Screen(isShowingMainData: false)),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 300,
                child: Example1ChartScreen()),
            ElevatedButton(
              onPressed: _callRepaintBoundaryToImage,
              child: Text('Repaint Boundary To Image'),
            ),
            ElevatedButton(
              onPressed: _callWidgetToImage,
              child: Text('Widget To Image'),
            ),
            _byteData != null
                ? Container(
                    height: 200,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Image.memory(_byteData!.buffer.asUint8List()),
                  )
                : Container()
          ],
        ));
  }

  _callRepaintBoundaryToImage() async {
    ByteData byteData =
        await WidgetToImage.repaintBoundaryToImage(this._globalKey);
    setState(() => _byteData = byteData);
  }

  _callWidgetToImage() async {
    ByteData byteData = await WidgetToImage.widgetToImage(Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    ));
    setState(() => _byteData = byteData);
  }
}
