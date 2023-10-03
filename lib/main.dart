import 'package:firebase_core/firebase_core.dart';
import 'package:flextv_bgm_player/constants/AppPages.dart';
import 'package:flextv_bgm_player/constants/AppRoutes.dart';
import 'package:flextv_bgm_player/controllers/AuthController.dart';
import 'package:flextv_bgm_player/controllers/BgmController.dart';
import 'package:flextv_bgm_player/controllers/SigninController.dart';
import 'package:flextv_bgm_player/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FLEX BGM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(BgmController());
        Get.lazyPut(() => SigninController(), fenix: true);
      }),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.signin,
    );
  }
}
