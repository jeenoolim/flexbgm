import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flextv_bgm_player/controllers/AuthController.dart';
import 'package:flextv_bgm_player/model/Bgm.dart';
import 'package:flextv_bgm_player/model/User.dart';
import 'package:flextv_bgm_player/screens/Eidtor.dart';
import 'package:flextv_bgm_player/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum SourceType {
  file('file', '파일'),
  url('url', '온라인');

  final String value;
  final String label;
  const SourceType(this.value, this.label);
}

enum EditingStatus {
  done('done', '완료', Icons.done),
  regist('regist', '생성', Icons.add),
  modify('modify', '편집', Icons.edit),
  delete('delete', '삭제', Icons.delete);

  final String value;
  final String label;
  final IconData icon;
  const EditingStatus(this.value, this.label, this.icon);
}

class BgmController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Rxn<Bgm> _bgm = Rxn();
  final RxList<Media> _items = RxList();
  final Rx<EditingStatus> _status = EditingStatus.done.obs;
  final Rx<SourceType> _sourctType = SourceType.file.obs;
  final Rxn<String> _errorName = Rxn();
  final Rxn<String> _errorSource = Rxn();

  User? user = Get.find<AuthController>().user;
  //이름
  TextEditingController nameController = TextEditingController();

  //소스
  TextEditingController sourceController = TextEditingController();
  //렉스
  TextEditingController doneController = TextEditingController();

  get bgm => _bgm;
  set bgm(value) => _bgm(value);

  get sourceTypes => SourceType.values.toList();

  get sourceType => _sourctType.value;
  set sourceType(value) => _sourctType(value);

  get items => _items;
  set items(value) => _items(value);

  get status => _status.value;
  set status(value) => _status(value);

  get errorName => _errorName.value;
  set errorName(value) => _errorName(value);

  get errorSource => _errorSource.value;
  set errorSource(value) => _errorSource(value);

  static BgmController get to => Get.find();

  addItem() {
    Get.bottomSheet(const Editor());
    _status(EditingStatus.regist);
  }

  deleteItem(Media item) {
    _status(EditingStatus.delete);
  }

  editItem(Media item) {
    nameController.text = item.name;
    sourceController.text = item.source;
    doneController.text = item.done;
    sourceType = item.type;
    Get.bottomSheet(const Editor());
    _status(EditingStatus.modify);
  }

  createItem() {
    if (nameController.text.isEmpty) {
      errorName = '브금 이름을 지정 해주세요';
      throw Exception(errorName.value);
    }
    if (sourceController.text.isEmpty) {
      errorSource = '브금 경로를 설정 해주세요.';
      throw Exception(errorSource.value);
    }
    return Media(
        id: uuid.v4(),
        name: nameController.text,
        type: sourceType.value,
        source: sourceController.text,
        done: doneController.text);
  }

  resetItem() {
    nameController.text = '';
    sourceController.text = '';
    doneController.text = '';
    sourceType = SourceType.file;
  }

  saveItem() async {
    try {
      Media? item = createItem();
      bgm.value.playlist.add(item);
      debugPrint('${bgm.value.toMap()}');
      Get.back();
    } on DioException catch (error) {
      Util.toast(error.message.toString());
    }
    // await firestore.collection('bgm').doc('11222').set(bgm.value.toMap());
  }

  load() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> response = await firestore
          .collection('bgm')
          .doc(user?.id.toString())
          // .doc('17483')
          .get();

      dynamic data = response.data();
      data = data == null
          ? Bgm(loginId: user?.loginId, playlist: [])
          : Bgm.fromMap(data);
      bgm = data;
      items = data.playlist;
    } on DioException catch (e) {
      debugPrint('e: ${e.message}');
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    load();
  }
}
