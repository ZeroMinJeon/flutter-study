import 'dart:math';

import 'package:flutter/material.dart';

class ThreeDimensionLayerCardInteractionScreen extends StatefulWidget {
  const ThreeDimensionLayerCardInteractionScreen({Key? key}) : super(key: key);

  @override
  State<ThreeDimensionLayerCardInteractionScreen> createState() =>
      _ThreeDimensionLayerCardInteractionScreenState();
}

class _ThreeDimensionLayerCardInteractionScreenState
    extends State<ThreeDimensionLayerCardInteractionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(Duration(seconds: 1));
          controller.reverse();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppBar(
              title: const Text('3D layer interaction'),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () => controller.forward(),
                child: SizedBox(
                  child: AnimatedBuilder(
                      builder: (context, child) {
                        return Container(
                          color: Colors.white.withOpacity(1 - animation.value),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: _BottomShadowBoxWidget(
                                  listenable: animation,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: _BottomBoxWidget(
                                  listenable: animation,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: _MarginBoxWidget(
                                  listenable: animation,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: _PaddingBoxWidget(
                                  listenable: animation,
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child:
                                      _ContentBoxWidget(listenable: animation)),
                            ],
                          ),
                        );
                      },
                      animation: animation),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentBoxWidget extends AnimatedWidget {
  const _ContentBoxWidget(
      {required super.listenable, this.width = 300, this.height = 300});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, -300 * animation.value),
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(-pi * animation.value / 3)
          ..rotateZ(pi * animation.value / 4)
          ..setEntry(2, 3, -animation.value + 10),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Stack(clipBehavior: Clip.none, children: [
            Text.rich(
              TextSpan(
                  text: 'Hover Me!\n\n',
                  children: const [
                    TextSpan(
                        text:
                            "I'm just some example text content so there's something inside this box, nothing much to see here",
                        style: TextStyle(fontWeight: FontWeight.normal))
                  ],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: animation.status == AnimationStatus.completed
                          ? Colors.white
                          : animation.status == AnimationStatus.forward
                              ? Colors.white.withOpacity(animation.value)
                              : Colors.black)),
            ),
            Positioned(
              left: 0,
              bottom: -20,
              child: Container(
                width: width,
                alignment: Alignment.center,
                child: Text('Conntent',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: animation.status == AnimationStatus.forward ||
                                animation.status == AnimationStatus.completed
                            ? Colors.white
                            : animation.status == AnimationStatus.reverse
                                ? Colors.white.withOpacity(animation.value)
                                : Colors.transparent)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _PaddingBoxWidget extends AnimatedWidget {
  const _PaddingBoxWidget(
      {required super.listenable, this.width = 300, this.height = 300});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, -200 * animation.value),
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(-pi * animation.value / 3)
          ..rotateZ(pi * animation.value / 4),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                    width: width,
                    height: 20,
                    color: animation.status == AnimationStatus.forward ||
                            animation.status == AnimationStatus.completed
                        ? Colors.blueAccent
                        : animation.status == AnimationStatus.reverse
                            ? Colors.blueAccent.withOpacity(animation.value)
                            : null),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: width,
                    height: 20,
                    color: animation.status == AnimationStatus.forward ||
                            animation.status == AnimationStatus.completed
                        ? Colors.blueAccent
                        : animation.status == AnimationStatus.reverse
                            ? Colors.blueAccent.withOpacity(animation.value)
                            : null),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 20,
                    height: height,
                    color: animation.status == AnimationStatus.forward ||
                            animation.status == AnimationStatus.completed
                        ? Colors.blueAccent
                        : animation.status == AnimationStatus.reverse
                            ? Colors.blueAccent.withOpacity(animation.value)
                            : null),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                    width: 20,
                    height: height,
                    color: animation.status == AnimationStatus.forward ||
                            animation.status == AnimationStatus.completed
                        ? Colors.blueAccent
                        : animation.status == AnimationStatus.reverse
                            ? Colors.blueAccent.withOpacity(animation.value)
                            : null),
              ),
              Positioned(
                left: 0,
                bottom: 20,
                child: Container(
                  width: width,
                  alignment: Alignment.center,
                  child: Text('Padding',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: animation.status == AnimationStatus.forward ||
                                  animation.status == AnimationStatus.completed
                              ? Colors.blueAccent
                              : animation.status == AnimationStatus.reverse
                                  ? Colors.blueAccent
                                      .withOpacity(animation.value)
                                  : Colors.transparent)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarginBoxWidget extends AnimatedWidget {
  _MarginBoxWidget(
      {required super.listenable, this.width = 300, this.height = 300});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, -100 * animation.value),
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(-pi * animation.value / 3)
          ..rotateZ(pi * animation.value / 4),
        child: Container(
          width: width + 10,
          height: height + 10,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: width + 10,
                  height: 5,
                  color: Colors.pinkAccent,
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: width + 10,
                  height: 5,
                  color: Colors.pinkAccent,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 5,
                  height: height + 10,
                  color: Colors.pinkAccent,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 5,
                  height: height + 10,
                  color: Colors.pinkAccent,
                ),
              ),
              Positioned(
                left: 0,
                bottom: 10,
                child: Container(
                  width: width,
                  alignment: Alignment.center,
                  child: Text('Margin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: animation.status == AnimationStatus.forward ||
                                  animation.status == AnimationStatus.completed
                              ? Colors.pinkAccent
                              : animation.status == AnimationStatus.reverse
                                  ? Colors.pinkAccent
                                      .withOpacity(animation.value)
                                  : Colors.transparent)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBoxWidget extends AnimatedWidget {
  _BottomBoxWidget(
      {required super.listenable, this.width = 300, this.height = 300});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, 000 * animation.value),
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(-pi * animation.value / 3)
          ..rotateZ(pi * animation.value / 4),
        child: Container(
          width: width + 10,
          height: width + 10,
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          child: Text('Bottom',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: animation.status == AnimationStatus.forward ||
                          animation.status == AnimationStatus.completed
                      ? Colors.black
                      : animation.status == AnimationStatus.reverse
                          ? Colors.black.withOpacity(animation.value)
                          : Colors.transparent)),
        ),
      ),
    );
  }
}

class _BottomShadowBoxWidget extends AnimatedWidget {
  _BottomShadowBoxWidget(
      {required super.listenable, this.width = 300, this.height = 300});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, 100 * animation.value),
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(-pi * animation.value / 3)
          ..rotateZ(pi * animation.value / 4),
        child: Container(
          width: width + 10,
          height: width + 10,
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 5, spreadRadius: 3)
          ]),
          alignment: Alignment.bottomCenter,
          child: Text('Shadow',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: animation.status == AnimationStatus.forward ||
                      animation.status == AnimationStatus.completed
                      ? Colors.white
                      : animation.status == AnimationStatus.reverse
                      ? Colors.white.withOpacity(animation.value)
                      : Colors.transparent)),
        ),
      ),
    );
  }
}
