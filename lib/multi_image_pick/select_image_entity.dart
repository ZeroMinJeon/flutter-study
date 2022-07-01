import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class SelectWithCountEntity {
  final AssetEntity entity;
  bool isSelect = false;
  Uint8List? uint8List;
  int selectCount = -1;
  final int index;

  SelectWithCountEntity(this.entity, this.index);
}

class SelectEntity {
  final AssetEntity entity;
  bool isSelect = false;
  Uint8List? uint8List;
  final int index;

  SelectEntity(this.entity, this.index);
}
