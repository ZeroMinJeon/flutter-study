import 'package:flutter/material.dart';

class CardWithLightWidget extends StatefulWidget {
  const CardWithLightWidget({Key? key}) : super(key: key);

  @override
  State<CardWithLightWidget> createState() => _CardWithLightWidgetState();
}

class _CardWithLightWidgetState extends State<CardWithLightWidget> {
  Alignment cardAlignment = Alignment(-1.3, -0.6);
  late Matrix4 cardMatrix1;
  late Matrix4 cardMatrix2;
  double startDx = 0;
  double endDx = 0;
  double startDy = 0;
  double endDy = 0;
  bool isAnimated = false;

  @override
  void initState() {
    cardMatrix1 = Matrix4.identity()..rotateZ(-0.3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        if (isAnimated) {
          setState(() {
            startDx += event.delta.dy / 100;
            startDy -= event.delta.dx / 100;
          });
          swipe();
        }
      },
      onExit: (_) => reset(),
      child: GestureDetector(
        onTap: () => setState(() {
          isAnimated = true;
        }),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: cardMatrix1,
                child: Container(
                  width: 200,
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: RadialGradient(
                          colors: [Colors.white, Colors.redAccent],
                          stops: [0, 1],
                          center: cardAlignment,
                          radius: 0.9,
                          focalRadius: 10)),
                  child: Stack(
                    children: const [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'tap',
                          style: TextStyle(color: Colors.white,
                          fontSize: 24),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Text(
                          "Zeromin",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void swipe() {
    if (!isAnimated) return;
    setState(() {
      cardMatrix1 = Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
        ..setEntry(3, 2, 0.001)
        ..rotateZ(-0.3)
        ..rotateX(startDx)
        ..rotateY(startDy)
        ..rotateZ(0);
      cardAlignment = Alignment(-1.3 + startDy * 4, -0.6 - startDx * 3);
    });
  }

  void reset() {
    setState(() {
      cardMatrix1 = Matrix4.identity()..rotateZ(-0.3);
      cardAlignment = Alignment(-1.3, -0.6);
      startDy = 0;
      startDx = 0;
      isAnimated = false;
    });
  }
}
