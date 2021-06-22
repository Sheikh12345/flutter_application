import 'package:get/get.dart';
import 'package:home_services/app/modules/home/controllers/home_controller.dart';
import 'package:home_services/app/modules/root/controllers/root_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
       fenix: true
    );

    Get.lazyPut<HomeController>(
        () => HomeController(),
      fenix: true
    );

    Get.lazyPut<RootController>(() => RootController(),
    fenix: true);
  }
}
