import 'package:flutter/material.dart';
import 'package:flutter3study/drag_tag/tag_data.dart';

class DragTagScreen extends StatefulWidget {
  DragTagScreen({Key? key}) : super(key: key);

  @override
  State<DragTagScreen> createState() => _DragTagScreenState();
}

class _DragTagScreenState extends State<DragTagScreen> {
  GlobalKey _imageKey = GlobalKey();
  List<TagData> tags = [];
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Tag'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 2 / 5,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  child: GestureDetector(
                    onTapUp: (detail) => addTagDialog(
                        detail.globalPosition.dx, detail.globalPosition.dy),
                    child: Image.network(
                      'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=',
                      key: _imageKey,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: tags
                        .map((tag) => TagWidget(
                            data: tag,
                            imageWidth: size.width,
                            imageHeight: size.height))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Size get size {
    if (_imageKey.currentContext == null) {
      return Size(0, 0);
    }
    final RenderBox renderBox =
        _imageKey.currentContext!.findRenderObject() as RenderBox;

    return renderBox.size;
  }

  void addTag(double selectedDx, double selectedDy) {
    setState(() {
      tags.add(TagData.fromImage(
          textEditingController.text,
          selectedDx,
          selectedDy -
              MediaQuery.of(context).viewPadding.top -
              AppBar().preferredSize.height,size));
    });
    textEditingController.clear();
    Navigator.pop(context);
  }

  void addTagDialog(double selectedDx, double selectedDy) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add tag',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: TextField(
              controller: textEditingController,
            ),
            actions: [
              TextButton(
                  onPressed: () => addTag(selectedDx, selectedDy),
                  child: const Text('ADD'))
            ],
          );
        });
  }
}
