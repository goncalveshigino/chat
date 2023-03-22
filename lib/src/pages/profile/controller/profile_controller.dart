import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/user_model.dart';

class ProfileController extends GetxController {

  final user = UserModel.fromJson(GetStorage().read('user') ?? {}).obs;

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil(PagesRoutes.signInRoute, (route) => false);
  }

  void goToProfileEdit() {
    Get.toNamed(PagesRoutes.profileEdit);
  }

 
}
