import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class SelectEntity {
  final AssetEntity entity;
  bool isSelect = false;
  Uint8List? uint8List;
  int selectCount = -1;

  SelectEntity(this.entity);
}

