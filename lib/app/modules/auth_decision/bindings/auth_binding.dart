import 'package:get/get.dart';
import 'package:home_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:home_services/app/modules/home/controllers/home_controller.dart';
import 'package:home_services/app/modules/root/controllers/root_controller.dart';


class AuthDeci extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(),permanent: true);
    Get.put<RootController>( RootController(),permanent: true);
  }
}
