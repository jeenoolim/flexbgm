import 'package:flextv_bgm_player/constants/AppRoutes.dart';
import 'package:flextv_bgm_player/screens/Eidtor.dart';
import 'package:flextv_bgm_player/screens/Home.dart';
import 'package:flextv_bgm_player/screens/SignIn.dart';
import 'package:flextv_bgm_player/screens/SignUp.dart';
import 'package:get/get.dart';

class AppPages {
  //페이지 라우팅
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => const Home()),
    GetPage(name: AppRoutes.signin, page: () => const SignIn()),
    GetPage(name: AppRoutes.signup, page: () => const SignUp()),
    GetPage(name: AppRoutes.editor, page: () => const Editor()),
    // GetPage(name: AppRoutes.secret, page: () => const SecretPage()),
    // GetPage(name: AppRoutes.upload, page: () => const UploadPage()),
    // GetPage(name: AppRoutes.setting, page: () => const SettingPage()),
  ];
}
