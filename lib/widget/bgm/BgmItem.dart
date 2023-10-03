import 'package:flextv_bgm_player/controllers/BgmController.dart';
import 'package:flextv_bgm_player/model/Bgm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgmItem extends StatelessWidget {
  final Media item;
  const BgmItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    BgmController controller = Get.find<BgmController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                // play
              },
              icon: const Icon(Icons.play_arrow),
            )),
        Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(item.name),
            )),
        Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(item.source),
            )),
        Expanded(
          flex: 1,
          child: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (EditingStatus result) => {
              if (result == EditingStatus.modify)
                {controller.editItem(item)}
              else
                {controller.deleteItem(item)}
            },
            itemBuilder: (BuildContext context) =>
                [EditingStatus.modify, EditingStatus.delete]
                    .map((value) => PopupMenuItem(
                          value: value,
                          child: Row(children: [
                            Icon(value.icon),
                            const SizedBox(width: 10),
                            Text(value.label)
                          ]),
                        ))
                    .toList(),
          ),
        ),
      ],
    );
  }
}
