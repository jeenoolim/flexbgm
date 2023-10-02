import 'package:flextv_bgm_player/controllers/EditorController.dart';
import 'package:flextv_bgm_player/model/Bgm.dart';
import 'package:flextv_bgm_player/widget/AppLogo.dart';
import 'package:flextv_bgm_player/widget/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editor extends GetView<EditorController> {
  const Editor({super.key, Media? item});
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const AppLogo(),
          const SizedBox(height: 16),
          SizedBox(
              height: 70,
              child: TextInput(
                hintText: 'BGM 이름',
                controller: controller.nameController,
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
                selected: const <SourceType>{
                  SourceType.url
                },
                onSelectionChanged: (Set<SourceType> newSelection) {}),
          ]),
          const SizedBox(height: 10),
          SizedBox(
            height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextInput(
                    hintText: '음원 경로',
                    controller: controller.nameController,
                  )),
                  const SizedBox(width: 10),
                  SizedBox(
                      height: double.infinity,
                      child: TextButton(
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
                        child:
                            const Text('파일선택', style: TextStyle(fontSize: 16)),
                      )),
                  const SizedBox(width: 10),
                  SizedBox(
                      height: double.infinity,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          // 
                        },
                        icon: const Icon(Icons.play_arrow),
                      )),
                ]),
          ),
          const Divider(
            height: 40,
            color: Colors.black12,
          ),
          SizedBox(
              height: 70,
              child: TextInput(
                hintText: '후원 갯수 지정',
                controller: controller.nameController,
              )),
          Expanded(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black, // your color here
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(230, 250, 187, 206),
                  padding: const EdgeInsets.all(30.0),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
                child: const Text('저장', style: TextStyle(fontSize: 16)),
              )
            ],
          ))
        ],
      ),
    ));
  }
}
