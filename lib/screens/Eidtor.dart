import 'package:flextv_bgm_player/controllers/BgmController.dart';
import 'package:flextv_bgm_player/widget/AppLogo.dart';
import 'package:flextv_bgm_player/widget/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editor extends GetView<BgmController> {
  const Editor({super.key});
  static const route = '/editor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const AppLogo(),
              const SizedBox(height: 16),
              SizedBox(
                  height: 70,
                  child: TextInput(
                    controller: controller.nameController,
                    hintText: 'BGM 이름',
                    errorText: controller.errorName,
                    onChanged: (e) => controller.errorName = '',
                  )),
              const Divider(
                height: 40,
                color: Colors.black12,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SegmentedButton<SourceType>(
                  segments: const <ButtonSegment<SourceType>>[
                    ButtonSegment<SourceType>(
                        value: SourceType.file,
                        label: Text('음원파일'),
                        icon: Icon(Icons.audiotrack)),
                    ButtonSegment<SourceType>(
                        value: SourceType.url,
                        label: Text('URL'),
                        icon: Icon(Icons.link))
                  ],
                  selected: <SourceType>{controller.sourceType},
                  onSelectionChanged: (Set<SourceType> newSelection) {
                    controller.sourceType = newSelection.first;
                  },
                ),
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextInput(
                      controller: controller.sourceController,
                      enabled: controller.sourceType == SourceType.url,
                      errorText: controller.errorSource,
                      onChanged: (e) => controller.errorSource = '',
                      hintText: '음원 경로',
                    )),
                    const SizedBox(width: 10),
                    SizedBox(
                        height: double.infinity,
                        child: controller.sourceType == SourceType.file
                            ? TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.black, // your color here
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  foregroundColor: Colors.black,
                                  backgroundColor:
                                      const Color.fromARGB(230, 250, 187, 206),
                                  padding: const EdgeInsets.all(16.0),
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {},
                                child: const Text('파일선택',
                                    style: TextStyle(fontSize: 16)),
                              )
                            : null),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: double.infinity,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          //
                        },
                        icon: const Icon(Icons.play_arrow),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 40,
                color: Colors.black12,
              ),
              SizedBox(
                height: 70,
                child: TextInput(
                  hintText: '후원 갯수 지정',
                  controller: controller.doneController,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              foregroundColor: Colors.grey,
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 59, 59),
                              textStyle: const TextStyle(fontSize: 14)),
                          onPressed: () => Get.back(closeOverlays: true),
                          child: const Text('취소',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 4),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              foregroundColor: Colors.black,
                              backgroundColor:
                                  const Color.fromARGB(255, 244, 171, 195),
                              textStyle: const TextStyle(fontSize: 14)),
                          onPressed: () => controller.saveItem(),
                          child: const Text('저장',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
