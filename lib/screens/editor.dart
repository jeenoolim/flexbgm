import 'package:flextv_bgm_player/controllers/bgm_controller.dart';
import 'package:flextv_bgm_player/widget/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Editor extends GetView<BgmController> {
  const Editor({super.key});
  static const route = '/editor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          toolbarHeight: 60,
          centerTitle: false,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black87,
          title: const Text('편집',
              style: TextStyle(color: Colors.white, fontSize: 16))),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<SourceType>(
                    style: ButtonStyle(
                      iconColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) =>
                              states.contains(MaterialState.selected)
                                  ? Colors.white
                                  : Colors.redAccent),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) =>
                              states.contains(MaterialState.selected)
                                  ? Colors.black87
                                  : Colors.white),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                        return states.contains(MaterialState.selected)
                            ? Colors.white
                            : Colors.black87;
                      }),
                    ),
                    segments: SourceType.values.map((SourceType e) {
                      return ButtonSegment(
                          value: SourceType.string(e.value),
                          label: Text(e.label),
                          icon: Icon(e.icon));
                    }).toList(),
                    selected: <SourceType>{controller.sourceType.value},
                    onSelectionChanged: (Set<SourceType> newSelection) =>
                        controller.sourceType(newSelection.first),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.sourceController,
                          decoration: InputDecoration(
                            hintText: 'BGM 경로를 지정해 주세요',
                            errorText: controller.errorSource.value,
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: const TextStyle(height: 0.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.sourceType.value == SourceType.file,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 10.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black87,
                              shadowColor: Colors.grey,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              minimumSize: const Size(100, 65), //////// HERE
                            ),
                            onPressed: () {},
                            child: const Text('파일선택'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
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
              const SizedBox(height: 40),
              Column(
                children: [
                  TextInput(
                    height: 60,
                    hintText: '후원 갯수 지정',
                    controller: controller.doneController,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.black87,
                                textStyle: const TextStyle(fontSize: 14)),
                            onPressed: () => controller.save(Get.arguments),
                            child: const Row(
                              children: [
                                Icon(FontAwesomeIcons.check,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 10),
                                Text('저장',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              controller.status.value == EditingStatus.modify,
                          child: Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.red,
                                  textStyle: const TextStyle(fontSize: 14)),
                              onPressed: () => controller.save(Get.arguments),
                              child: const Row(
                                children: [
                                  Icon(Icons.clear,
                                      color: Colors.white, size: 20),
                                  SizedBox(width: 10),
                                  Text('삭제',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
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
