import 'package:flextv_bgm_player/controllers/bgm_controller.dart';
import 'package:flextv_bgm_player/model/bgm.dart';
import 'package:flextv_bgm_player/widget/bgm/bgm_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgmList extends GetView<BgmController> {
  const BgmList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => ReorderableListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final Media item = controller.items[index];
              return Container(
                key: ValueKey(item.id),
                child: BgmItem(item: item),
              );
            },
            onReorder: (oldIndex, newIndex) =>
                controller.swap(oldIndex, newIndex),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), //모서리
          ), //테두리
          onPressed: () => Get.find<BgmController>().regist(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
