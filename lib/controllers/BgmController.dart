import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flextv_bgm_player/model/Bgm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgmController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static BgmController get to => Get.find();
  final RxList<Media> _items = RxList();
  RxList<Media> get items => _items;

  load() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> response = await firestore
          .collection('bgm')
          // .doc(user.value?.id.toString())
          .doc('17483')
          .get();

      dynamic data = response.data();
      debugPrint('${SourceType.values.map((e) => e.label).toList()}');
      data = data == null ? [] : Bgm.fromMap(data).playlist;
      _items(data);
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
