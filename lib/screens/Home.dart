// ignore: file_names
import 'package:flextv_bgm_player/controllers/BgmController.dart';
import 'package:flextv_bgm_player/widget/bgm/BgmList.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FLEX BGM'),
      ),
      body: const BgmList(),
    );
  }
}
