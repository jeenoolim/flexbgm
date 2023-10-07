import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flextv_bgm_player/constants/app_routes.dart';
import 'package:flextv_bgm_player/controllers/auth_controller.dart';
import 'package:flextv_bgm_player/model/bgm.dart';
import 'package:flextv_bgm_player/model/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum SourceType {
  file('file', '파일', FontAwesomeIcons.recordVinyl),
  youtube('youtube', '유튜브', FontAwesomeIcons.youtube),
  url('url', '주소', Icons.link);

  final String value;
  final String label;
  final IconData icon;
  const SourceType(this.value, this.label, this.icon);

  static SourceType string(name) =>
      SourceType.values.firstWhere((element) => element.name == name);
}

enum EditingStatus {
  done('done', '완료'),
  regist('regist', '생성'),
  modify('modify', '편집'),
  delete('delete', '삭제');

  final String value;
  final String label;
  const EditingStatus(this.value, this.label);
}

class BgmController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Rx<EditingStatus> status = Rx(EditingStatus.done);
  final RxList<Media> items = RxList();
  final Rx<SourceType> sourceType = Rx(SourceType.file);
  RxnString errorName = RxnString(null);
  final RxnString errorSource = RxnString(null);
  Bgm? respose;
  User? user;

  //소스
  TextEditingController sourceController = TextEditingController();
  //렉스
  TextEditingController doneController = TextEditingController();

  get sourceTypes => SourceType.values.toList();

  static BgmController get to => Get.find();

  void regist() {
    status.value = EditingStatus.regist;
    Get.toNamed(AppRoutes.editor);
    reset();
  }

  void delete(Media item) {
    status.value = EditingStatus.delete;
  }

  void swap(int oldIndex, int newIndex) {
    newIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    Media item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    items.refresh();
    submit();
  }

  void modify(String id) {
    status.value = EditingStatus.modify;
    Media item = items.firstWhere((e) => e.id == id);
    sourceController.text = item.source;
    doneController.text = item.done;
    sourceType.value = SourceType.string(item.type);
    Get.toNamed(AppRoutes.editor, arguments: id);
  }

  Media create(String? id) {
    return Media(
        id: id ?? uuid.v4(),
        type: sourceType.value.value,
        source: sourceController.text,
        done: doneController.text);
  }

  bool validation() {
    if (sourceController.text.isEmpty) {
      errorSource.value = '브금 경로를 설정 해주세요.';
      return false;
    }
    return true;
  }

  void reset() {
    sourceController.text = '';
    doneController.text = '';
    errorName.value = null;
    errorSource.value = null;
    sourceType(SourceType.file);
  }

  save(String? id) {
    if (validation()) {
      Media item = create(id);
      switch (status.value) {
        case EditingStatus.modify:
          int index = items.indexWhere((e) => e.id == item.id);
          items[index] = item;
          break;
        case EditingStatus.regist:
          items.add(item);
        default:
          break;
      }
      items.refresh();
      submit();
    }
  }

  submit() {
    firestore
        .collection('bgm')
        // .doc(user?.id.toString())
        .doc('17483')
        .update({"playlist": items.map((e) => e.toMap())});
    Get.back();
  }

  Future<Bgm> load() async {
    DocumentSnapshot<Map<String, dynamic>> response =
        // await firestore.collection('bgm').doc(_user?.id.toString()).get();
        await firestore.collection('bgm').doc('17483').get();
    Map<String, dynamic>? data = response.data();
    return Bgm.fromMap(data ?? {});
  }

  @override
  onInit() async {
    super.onInit();
    respose = await load();
    items.value = respose?.playlist ?? [];
    debounce(
        errorName,
        (callback) => Future.delayed(
            const Duration(seconds: 2), () => errorName.value = null));
    debounce(
        errorSource,
        (callback) => Future.delayed(
            const Duration(seconds: 2), () => errorSource.value = null));
    // Get.find<AuthController>().user.listen((user) async {
    //   _user = user;
    //   _bgm = await load();
    //   _items(_bgm?.playlist ?? []);
    // });
  }
}
