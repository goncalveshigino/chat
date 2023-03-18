import 'package:chat/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:chat/src/api/endpoints.dart';

import '../models/user_model.dart';
import '../services/http_manager.dart';

class UsersProvider extends GetConnect {
  final HttpManager _httpManager = HttpManager();
  // String url = '${Environment.API_CHAT}api/users';

  // Future<Response> createUser(UserModel user) async {
  //   Response response = await post(Endpoints.createUser, user.toJson(),
  //       headers: {'Content-Type': 'Application/json'});

  //   print(response);

  //   return response;
  // }

  Future<ResponseApi> signIn(
    String email,
    String password,
  ) async {

    final response = await _httpManager.restRequest(
      url: Endpoints.singnIn,
      method: HttpMethods.post,
      body: {'email': email, 'password': password},
    );

    if (response.body == null) {
      Get.snackbar('Error', 'Por favor tente novamente');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromMap(response.body);

    return responseApi;

    // Response response = await post(Endpoints.singnIn, {
    //   'email': email,
    //   'password': password,
    // }, headers: {
    //   'Content-Type': 'Application/json',
    // });

    // if (response.body == null) {
    //   Get.snackbar('Error', 'Por favor tente novamente');
    //   return ResponseApi();
    // }

    // ResponseApi responseApi = ResponseApi.fromMap(response.body);

    // return responseApi;
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
