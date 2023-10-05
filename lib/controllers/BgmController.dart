import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flextv_bgm_player/constants/AppRoutes.dart';
import 'package:flextv_bgm_player/controllers/AuthController.dart';
import 'package:flextv_bgm_player/model/Bgm.dart';
import 'package:flextv_bgm_player/model/User.dart';
import 'package:flutter/material.dart';
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
  final RxList<Media> _items = RxList();
  final Rx<EditingStatus> _status = EditingStatus.done.obs;
  final Rx<SourceType> _sourctType = SourceType.file.obs;
  final Rx<String> _errorName = ''.obs;
  final Rx<String> _errorSource = ''.obs;
  Bgm? _bgm;
  User? _user;
  //이름
  TextEditingController nameController = TextEditingController();

  //소스
  TextEditingController sourceController = TextEditingController();
  //렉스
  TextEditingController doneController = TextEditingController();

  // get bgm => _bgm;
  // set bgm(value) => _bgm(value);

  get sourceTypes => SourceType.values.toList();

  get sourceType => _sourctType.value;
  set sourceType(value) => _sourctType(value);

  get items => _items;
  // set items(value) => _items(value);

  get status => _status.value;
  set status(value) => _status(value);

  get errorName => _errorName.value;
  set errorName(value) => _errorName(value);

  get errorSource => _errorSource.value;
  set errorSource(value) => _errorSource(value);

  static BgmController get to => Get.find();

  addItem() {
    Get.toNamed(AppRoutes.editor);
    resetItem();
    _status(EditingStatus.regist);
  }

  deleteItem(Media item) {
    _status(EditingStatus.delete);
  }

  editItem(Media item) {
    nameController.text = item.name;
    sourceController.text = item.source;
    doneController.text = item.done;
    sourceType =
        item.type == SourceType.file.value ? SourceType.file : SourceType.url;
    Get.toNamed(AppRoutes.editor);
    _status(EditingStatus.modify);
  }

  createItem() {
    if (nameController.text.isEmpty) {
      errorName = '브금 이름을 지정 해주세요';
      return;
    }
    if (sourceController.text.isEmpty) {
      errorSource = '브금 경로를 설정 해주세요.';
      return;
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
    errorName = '';
    errorSource = '';
    sourceType = SourceType.file.value;
  }

  saveItem() {
    Media? item = createItem();
    if (item == null) {
      return;
    }
    _items.add(item);
    _items.refresh();
    firestore
        .collection('bgm')
        .doc(_user?.id.toString())
        .update({"playlist": _items.map((e) => e.toMap())});
    Get.back();

    // await firestore.collection('bgm').doc('11222').set(bgm.value.toMap());
  }

  Future<Bgm> load() async {
    DocumentSnapshot<Map<String, dynamic>> response = await firestore
        .collection('bgm')
        .doc(_user?.id.toString())
        // .doc('17483')
        .get();

    Map<String, dynamic>? data = response.data();
    return Bgm.fromMap(data ?? {});
  }

  @override
  onInit() {
    super.onInit();
    Get.find<AuthController>().user.listen((user) async {
      _user = user;
      _bgm = await load();
      _items(_bgm?.playlist ?? []);
    });
  }
}
