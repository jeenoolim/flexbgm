import 'package:flextv_bgm_player/controllers/BgmController.dart';
import 'package:flextv_bgm_player/controllers/EditorController.dart';
import 'package:flextv_bgm_player/model/Bgm.dart';
import 'package:flextv_bgm_player/widget/bgm/BgmItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgmList extends GetView<BgmController> {
  const BgmList({super.key});
  static const route = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: controller.items.length,
              itemBuilder: (BuildContext context, int index) {
                Media media = controller.items[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: BgmItem(item: media),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Get.find<EditorController>().updateStatus(EditingStatus.regist),
          child: const Icon(Icons.add),
        ));
  }
}
