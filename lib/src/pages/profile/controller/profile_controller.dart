import 'package:chat/src/pages_routes/page_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/user_model.dart';

class ProfileController extends GetxController {


   UserModel user = UserModel.fromJson(GetStorage().read('user') ?? {});



   void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil(PagesRoutes.signInRoute, (route) => false);
   }
} 