import 'package:chat/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:chat/src/api/endpoints.dart';

import '../models/user_model.dart';

class UsersProvider extends GetConnect {
  // String url = '${Environment.API_CHAT}api/users';

  // Future<Response> createUser(UserModel user) async {
  //   Response response = await post(Endpoints.createUser, user.toJson(),
  //       headers: {'Content-Type': 'Application/json'});

  //   print(response);

  //   return response;
  // }

  Future<ResponseApi> singnIn(String email, String password) async {
    Response response = await post(Endpoints.singnIn, {
      'email': email,
      'password': password,
    }, headers: {
      'Content-Type': 'Application/json',
    });

    if (response.body == null) {
      Get.snackbar('Error', 'Por favor tente novamente');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromMap(response.body);

    return responseApi;
  }

  Future<ResponseApi> createUser(UserModel user) async {
    Response response = await post(
      Endpoints.createUser,
      user.toJson(),
      headers: {
        'Content-Type': 'Application/json',
      },
    );

    if (response.body == null) {
      Get.snackbar('Error', 'Erro ao fazer cadastro');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromMap(response.body);

    return responseApi;
  }
}
