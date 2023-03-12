

import 'package:chat/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {

   UserModel user = UserModel.fromJson(GetStorage().read('user') ?? {});

   var tabIndex = 0.obs;

   HomeController(){
    print('Usuario Session: ${user.toJson()}');
   }

   
    void changesTabIndex(int index){
      tabIndex.value = index;
    }

}