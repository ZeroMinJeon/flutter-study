import 'package:flutter/material.dart';

class TagData {
  String name;
  double dx;
  double dy;
  double showDx = 0;
  double showDy = 0;

  TagData(this.name, this.dx, this.dy);

  factory TagData.fromImage(
      String name, double showDx, double showDy, Size imageSize) {
    var data =
        TagData(name, showDx / imageSize.width, showDy / imageSize.height);
    return data;
  }

  void setting(double inputDx, double inputDy, double imageWidth,
      double imageHeight, Size widgetSize) {
    calcuatedDy(inputDy, imageHeight, widgetSize.height);
    calculatedDx(inputDx, imageWidth, widgetSize.width);
  }

  void presetting(double imageWidth, double imageHeight, Size widgetSize) {
    calculatedShowDx(imageWidth, widgetSize.width);
    calculatedShowDy(imageHeight, widgetSize.height);
  }

  void calculatedShowDx(double imageWidth, double widgetWidth) {
    var calDx = dx * imageWidth;
    if (calDx < widgetWidth / 2) {
      showDx = 0;
    } else if (calDx > imageWidth - widgetWidth / 2) {
      showDx = imageWidth - widgetWidth / 2;
    } else {
      showDx = calDx - widgetWidth / 2;
    }
  }

  void calculatedShowDy(double imageHeight, double widgetHeight) {
    var calDy = dy * imageHeight;
    if (calDy < widgetHeight / 2) {
      showDy = 0;
    } else if (calDy > imageHeight - widgetHeight / 2) {
      showDy = imageHeight - widgetHeight / 2;
    } else {
      showDy = calDy - widgetHeight / 2;
    }
  }

  void calculatedDx(double inputDx, double imageWidth, double widgetWidth) {
    dx = (inputDx + widgetWidth / 2) / imageWidth;
    calculatedShowDx(imageWidth, widgetWidth);
  }

  void calcuatedDy(double inputDy, double imageHeight, double widgetHeight) {
    if (inputDy < 0) {
      dy = 0;
    } else if (inputDy + widgetHeight / 2 > imageHeight) {
      dy = imageHeight;
    } else {
      dy = (inputDy + widgetHeight / 2) / imageHeight;
    }
    calculatedShowDy(imageHeight, widgetHeight);
  }
}

class TagWidget extends StatefulWidget {
  TagWidget(
      {Key? key,
      required this.data,
      required this.imageWidth,
      required this.imageHeight})
      : super(key: key);

  TagData data;
  // TagData data = TagData('asdfasdf', 0, 0);

  double imageWidth;
  double imageHeight;

  @override
  State<TagWidget> createState() =>
      _TagWidgetState(data, imageWidth, imageHeight);
}

class _TagWidgetState extends State<TagWidget> {
  TagData data;
  double imageWidth;
  double imageHeight;
  final GlobalKey _key = GlobalKey();
  Size preSize = Size(50, 36);

  _TagWidgetState(this.data, this.imageWidth, this.imageHeight);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getWidgetInfo);
  }

  void _getWidgetInfo(_) {
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;
    preSize = renderBox.size;
    setState(() {
      data.presetting(imageWidth, imageHeight, preSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: dy,
      left: dx,
      child: Draggable(
        onDragEnd: (detail) => move(detail),
        feedback: unit(),
        childWhenDragging: Container(),
        child: unit(
          key: _key,
        ),
      ),
    );
  }

  double get dx {
    return data.showDx;
  }

  double get dy {
    return data.showDy;
  }

  Widget unit({GlobalKey? key}) {
    return Container(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.redAccent,
        child: Text(
          data.name,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.white),
        ));
  }

  void move(DraggableDetails detail) {
    setState(() {
      data.setting(
          detail.offset.dx,
          detail.offset.dy - 50 - AppBar().preferredSize.height,
          widget.imageWidth,
          widget.imageHeight,
          preSize);
    });
  }
}
