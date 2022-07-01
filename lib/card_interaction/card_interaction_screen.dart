import 'package:flutter/material.dart';
import 'package:flutter3study/card_interaction/card_with_light_widget.dart';
import 'package:flutter3study/card_interaction/samsung_pay_interaction_card_widget.dart';

class CardInteractionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Interaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CardWithLightWidget(),
            SizedBox(
              height: 40,
            ),
            SamsungPayInteractionCardWidget()
          ],
        ),
      ),
    );
  }
}
