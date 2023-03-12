import 'package:chat/src/pages/base/controller/navigation_controller.dart';
import 'package:get/get.dart';


class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
