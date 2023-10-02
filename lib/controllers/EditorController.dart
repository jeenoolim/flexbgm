import 'package:flextv_bgm_player/model/Bgm.dart';
import 'package:flextv_bgm_player/screens/Eidtor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// enum EditorMode {
//   done('done', '완료'),
//   regist('regist', '등록'),
//   edit('edit', '편집'),
//   delete('delete', '삭제');

//   final String value;
//   final String label;
//   const EditorMode(this.value, this.label);
// }

// enum EditingStatus { done, regist, modify, delete }

enum EditingStatus {
  done('done', '완료', Icons.done),
  regist('delete', '삭제', Icons.add),
  modify('modify', '편집', Icons.edit),
  delete('delete', '삭제', Icons.delete);

  final String value;
  final String label;
  final IconData icon;
  const EditingStatus(this.value, this.label, this.icon);
}

class EditorController extends GetxController {
  static EditorController get to => Get.find();
  final Rx<EditingStatus> _status = EditingStatus.done.obs;
  Rx<EditingStatus> get status => _status;

  TextEditingController nameController =
      TextEditingController(); //id 텍스트 필드 컨트롤러
  TextEditingController sourceController =
      TextEditingController(); //패스워드 텍스트 필트 컨트롤러

  List<SourceType> sourceTypes = SourceType.values.toList();

  updateStatus(EditingStatus status) {
    if (status == EditingStatus.modify || status == EditingStatus.regist) {
      Get.bottomSheet(const Editor());
    }
    _status(status);
  }
}
