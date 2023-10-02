import 'package:flextv_bgm_player/constants/AppRoutes.dart';
import 'package:flextv_bgm_player/controllers/SigninController.dart';
import 'package:flextv_bgm_player/widget/AppLogo.dart';
import 'package:flextv_bgm_player/widget/Button.dart';
import 'package:flextv_bgm_player/widget/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends GetView<SigninController> {
  const SignIn({super.key});
  static const route = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(),
          const SizedBox(height: 16),
          //아이디 텍스트 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInput(
              hintText: '아이디',
              controller: controller.idController,
            ),
          ),
          //패스워드 텍스트 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextInput(
              hintText: '비밀번호',
              controller: controller.pwController,
            ),
          ),
          //로그인 정보 저장 체크박스
          Row(
            children: [
              Obx(
                () => Checkbox(
                  activeColor: Colors.redAccent,
                  value: controller.isLoginInfoSave.value,
                  onChanged: controller.checkLoginInfoSave,
                ),
              ),
              const Text('로그인 정보 저장'),
            ],
          ),
          Button(
            margin: const EdgeInsets.all(8.0),
            text: '로그인',
            onPressed: () {
              controller.signin();
            },
          ),
          //회원가입 페이지 이동
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.signup),
            style: TextButton.styleFrom(
              foregroundColor: Colors.redAccent,
            ),
            child: const Text('회원가입'),
          ),
        ],
      ),
    );
  }
}