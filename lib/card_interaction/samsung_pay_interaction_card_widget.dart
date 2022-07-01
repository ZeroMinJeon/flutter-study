import 'package:flutter/material.dart';

class SamsungPayInteractionCardWidget extends StatefulWidget {
  const SamsungPayInteractionCardWidget({Key? key}) : super(key: key);

  @override
  State<SamsungPayInteractionCardWidget> createState() =>
      _SamsungPayInteractionCardWidgetState();
}

class _SamsungPayInteractionCardWidgetState
    extends State<SamsungPayInteractionCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(begin: 0, end: 50).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          animationController.forward();
        },
        onDoubleTap: () {
          animationController.reverse();
        },
        child: _AnimatedCard(
          listenable: animationController,
        ));
  }
}

class _AnimatedCard extends AnimatedWidget {
  const _AnimatedCard({required super.listenable});

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(animation.value / 2),
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
            gradient: RadialGradient(
                colors: [Colors.blueAccent.withOpacity(0.4), Colors.blueAccent],
                stops: [0, 1],
                center:
                    Alignment(animation.value - 1, 1 / 4 - animation.value / 2),
                radius: 1,
                focalRadius: 0.1)),
        child: Stack(
          children: const [
            Positioned(
              right: 10,
              bottom: 10,
              child: Text(
                'Zeromin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
