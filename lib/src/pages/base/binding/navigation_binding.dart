import 'package:get/get.dart';


import '../controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
