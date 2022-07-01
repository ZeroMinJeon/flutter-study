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
  List<SelectWithCountEntity> selectedEntities = [];

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
                child: const Text("앨범")),
          ],
        ),
      ),
    );
  }

  void showBottomModalForImagePick() async {
    List<SelectWithCountEntity> selectedEntities = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ImagePickBottomSheetWidget(
            prevSelectedEntity: this.selectedEntities,
          );
        });
    if (this.selectedEntities != selectedEntities){
      setState(() {
        this.selectedEntities = selectedEntities;
      });
    }
  }
}

class ImagePickBottomSheetWidget extends StatefulWidget {
  const ImagePickBottomSheetWidget({Key? key, required this.prevSelectedEntity})
      : super(key: key);

  final List<SelectWithCountEntity> prevSelectedEntity;

  @override
  State<ImagePickBottomSheetWidget> createState() =>
      _ImagePickBottomSheetWidgetState();
}

class _ImagePickBottomSheetWidgetState
    extends State<ImagePickBottomSheetWidget> {
  List<SelectWithCountEntity> selectedEntities = [];
  List<SelectWithCountEntity> entities = [];
  bool isLoading = true;

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
                        List<SelectWithCountEntity> result = await sendData();
                        Navigator.pop(context, result);
                      },
                      child: const Text('취소')),
                  const Center(
                    child: Text('엘범'),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.blueAccent,),
                    )
                  : GridView.count(
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
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
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
          entities.add(SelectWithCountEntity(data, entities.length));
        }
        for (SelectWithCountEntity data in selectedEntities) {
          var index = findIndexBSearch(data.index);
          entities[index].isSelect = true;
          entities[index].selectCount = data.selectCount;
        }
        isLoading = false;
      });
    } else {}
  }

  void selectOrUnSelect(int index) {
    var entityIndex = selectedEntities
        .indexWhere((element) => element.index == entities[index].index);
    setState(() {
      if (entityIndex != -1) {
        selectedEntities.removeAt(entityIndex);
        entities[index].selectCount = -1;
        entities[index].isSelect = false;
        for (var j = 0; j < selectedEntities.length; j++) {
          selectedEntities[j].selectCount = j + 1;
          var i = findIndexBSearch(selectedEntities[j].index);
          entities[i].selectCount = j + 1;
        }
      } else {
        entities[index].isSelect = true;
        selectedEntities.add(entities[index]);
        for (var j = 0; j < selectedEntities.length; j++) {
          var i = findIndexBSearch(selectedEntities[j].index);
          entities[i].selectCount = j + 1;
          selectedEntities[j].selectCount = j + 1;
        }
      }
    });
  }

  Future<List<SelectWithCountEntity>> sendData() async {
    List<SelectWithCountEntity> result = [];

    for (SelectWithCountEntity data in selectedEntities) {
      data.uint8List = await data.entity.originBytes;
      result.add(data);
    }
    return result;
  }

  int findIndexBSearch(int index) {
    int low = 0;
    int high = entities.length;
    double mid;

    while (low <= high) {
      mid = (low + high) / 2;
      var midIndex = mid.toInt();
      if (entities[midIndex].index == index) {
        return midIndex;
      } else if (entities[midIndex].index > index) {
        high = midIndex;
      } else {
        low = midIndex + 1;
      }
    }
    return -1;
  }
}
