import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter3study/multi_image_pick/select_image_entity.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetImageCS extends StatelessWidget {
  final SelectWithCountEntity selectEntity;
  final double width;
  final double height;
  final BoxFit boxFit;
  final int minusCount;

  const AssetImageCS({
    Key? key,
    required this.selectEntity,
    required this.width,
    required this.height,
    required this.boxFit,
    this.minusCount = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectEntity.uint8List != null) {
      return _buildContainer(
        child: Image.memory(
          selectEntity.uint8List!,
          width: width,
          height: height,
          fit: boxFit,
        ),
      );
    }

    return FutureBuilder<Uint8List?>(
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          selectEntity.uint8List = snapshot.data;
          return snapshot.data != null
              ? _buildContainer(
                  child: Image.memory(
                    snapshot.data!,
                    width: width,
                    height: height,
                    fit: boxFit,
                  ),
                )
              : Container();
        } else {
          return _buildContainer();
        }
      },
      future: selectEntity.entity
          .thumbnailDataWithSize(ThumbnailSize(width.toInt(), height.toInt())),
    );
  }

  Widget _buildContainer({Widget? child}) {
    bool isVideo = selectEntity.entity.type == AssetType.video;
    bool isSelect = selectEntity.isSelect;

    return Container(
      margin: EdgeInsets.all(2),
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          child ?? Container(),
          isVideo == true ? videoIcon() : Container(),
          isSelect == true ? selectWidget() : Container(),
          countWidget(),
        ],
      ),
    );
  }

  Widget videoIcon() {
    return const Center(
      child: Icon(
        Icons.play_circle_filled,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget selectWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black26,
          border: Border.all(color: Colors.blueAccent, width: 4)),
    );
  }

  Widget countWidget() {
    if (minusCount != -1 && selectEntity.selectCount > minusCount) {
      --selectEntity.selectCount;
    }

    return Positioned(
      top: 0,
      right: 0,
      child: Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.only(top: 3,right: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectEntity.isSelect ? Colors.blueAccent : Colors.black38,
              border: Border.all(color: selectEntity.isSelect ?Colors.blueAccent : Colors.black12, width: 2)),
          child: selectEntity.isSelect
              ? Text(
                  "${selectEntity.selectCount}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              : null),
    );
  }
}
