import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  const DetailScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(index.toString(), style: Theme.of(context).textTheme.headline3,),),
      body: Center(
        child: Text(index.toString(), style: Theme.of(context).textTheme.headline1,),
      ),
    );
  }
}
