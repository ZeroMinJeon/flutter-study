import 'package:flutter/material.dart';
import 'package:flutter3study/graph/draw_sugar_level_chart.dart';
import 'package:flutter3study/graph/draw_week_sugar_level_chart.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            DrawWeekSugarLevelChartScreen()
          ],
        ));
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: AppBar(title: const Text('Graph Screen')),
//       body: ListView(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           SingleChildScrollView(
//               child: SizedBox(
//                   width: 5000, height: 400, child: LineChartSample1Screen())),
//           RepaintBoundary(
//             key: _globalKey,
//             child: Container(
//                 width: 300,
//                 height: 300,
//                 child: LineChartSample2Screen(isShowingMainData: false)),
//           ),
//           SingleChildScrollView(
//             child: Container(
//                 width: MediaQuery.of(context).size.width * 1.8,
//                 height: 300,
//                 child: Example1ChartScreen()),
//           ),
//           ElevatedButton(
//             onPressed: _callRepaintBoundaryToImage,
//             child: Text('Repaint Boundary To Image'),
//           ),
//           ElevatedButton(
//             onPressed: _callWidgetToImage,
//             child: Text('Widget To Image'),
//           ),
//           _byteData != null
//               ? Container(
//                   height: 200,
//                   decoration:
//                       BoxDecoration(border: Border.all(color: Colors.black)),
//                   child: Image.memory(_byteData!.buffer.asUint8List()),
//                 )
//               : Container()
//         ],
//       ));
// }

// _callRepaintBoundaryToImage() async {
//   ByteData byteData =
//       await WidgetToImage.repaintBoundaryToImage(this._globalKey);
//   setState(() => _byteData = byteData);
// }

// _callWidgetToImage() async {
//   ByteData byteData = await WidgetToImage.widgetToImage(Container(
//     width: 100,
//     height: 100,
//     color: Colors.blue,
//   ));
//   setState(() => _byteData = byteData);
// }
}
