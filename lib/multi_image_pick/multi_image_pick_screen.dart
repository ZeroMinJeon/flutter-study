import 'package:flutter/material.dart';
import 'package:flutter3study/multi_image_pick/AssetImageThumbnailWidget.dart';
import 'package:flutter3study/multi_image_pick/select_image_entity.dart';

import 'package:photo_manager/photo_manager.dart';

class MultiImagePickScreen extends StatefulWidget {
  const MultiImagePickScreen({Key? key}) : super(key: key);

  @override
  State<MultiImagePickScreen> createState() => _MultiImagePickScreenState();
}

class _MultiImagePickScreenState extends State<MultiImagePickScreen> {
  List<SelectEntity> selectedEntities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi Image Pick Screen')),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedEntities.isEmpty
                ? const SizedBox(
                    height: 200,
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          selectedEntities.length,
                          (index) =>
                              Image.memory(selectedEntities[index].uint8List!)),
                    ),
                  ),
            TextButton(
                onPressed: () {
                  showBottomModalForImagePick();
                },
                child: Text("앨범")),
          ],
        ),
      ),
    );
  }

  void showBottomModalForImagePick() async {
    List<SelectEntity> selectedEntities = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ImagePickBottomSheetWidget(
            prevSelectedEntity: this.selectedEntities,
          );
        });
    setState(() {
      this.selectedEntities = selectedEntities;
    });
  }
}

class ImagePickBottomSheetWidget extends StatefulWidget {
  const ImagePickBottomSheetWidget({Key? key, required this.prevSelectedEntity})
      : super(key: key);

  final List<SelectEntity> prevSelectedEntity;

  @override
  State<ImagePickBottomSheetWidget> createState() =>
      _ImagePickBottomSheetWidgetState();
}

class _ImagePickBottomSheetWidgetState
    extends State<ImagePickBottomSheetWidget> {
  List<SelectEntity> selectedEntities = [];
  List<SelectEntity> entities = [];

  @override
  void initState() {
    selectedEntities.addAll(widget.prevSelectedEntity);
    getImagesFromAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        List<SelectEntity> result = await sendData();
                        Navigator.pop(context, result);
                      },
                      child: Text('취소')),
                  const Center(
                    child: Text('엘범'),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                    entities.length,
                    (index) => GestureDetector(
                          onTap: () => selectOrUnSelect(index),
                          child: AssetImageCS(
                            selectEntity: entities[index],
                            width: 300,
                            height: 300,
                            boxFit: BoxFit.cover,
                            minusCount: entities[index].selectCount,
                          ),
                        )),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void getImagesFromAlbum() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      List<AssetPathEntity> list =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      List<AssetEntity> allImageList = [];
      for (AssetPathEntity data in list) {
        if (data.name == 'Recents' || data.name == 'Recent') {
          List<AssetEntity> imageList =
              await data.getAssetListPaged(page: 0, size: data.assetCount);
          allImageList.addAll(imageList);
          break;
        }
      }
      setState(() {
        for (AssetEntity data in allImageList) {
          entities.add(SelectEntity(data));
        }
        for (SelectEntity data in selectedEntities) {
          var index =
              entities.indexWhere((element) => element.entity == data.entity);
          entities[index].isSelect = true;
          entities[index].selectCount = data.selectCount;
        }
      });
    } else {}

  }

  void selectOrUnSelect(int index) {
    var entityIndex = selectedEntities
        .indexWhere((element) => element.entity == entities[index].entity);
    setState(() {
      if (entityIndex != -1) {
        selectedEntities.removeAt(entityIndex);
        entities[index].selectCount = -1;
        entities[index].isSelect = false;
        for (var j = 0; j < selectedEntities.length; j++) {
          selectedEntities[j].selectCount = j + 1;
          var i = entities.indexWhere((element) => element.entity == selectedEntities[j].entity);
          entities[i].selectCount = j + 1;
        }
      } else {
        entities[index].isSelect = true;
        selectedEntities.add(entities[index]);
        for (var j = 0; j < selectedEntities.length; j++) {
          var i = entities.indexWhere((element) => element.entity == selectedEntities[j].entity);
          entities[i].selectCount = j + 1;
          selectedEntities[j].selectCount = j + 1;
        }
      }
    });
  }

  Future<List<SelectEntity>> sendData() async {
    List<SelectEntity> result = [];

    for (SelectEntity data in selectedEntities) {
      data.uint8List = await data.entity.originBytes;
      result.add(data);
    }
    return result;
  }
}
