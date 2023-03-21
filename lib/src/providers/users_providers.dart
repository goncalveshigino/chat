import 'dart:convert';
import 'dart:io';
import 'package:chat/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:chat/src/api/endpoints.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:path/path.dart';

class UsersProvider extends GetConnect {




  Future<ResponseApi> signIn(
    String email,
    String password,
  ) async {
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

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

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

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

//------------------------------------
  Future<Stream> createWithImage(UserModel user, File image) async {
    Uri uri = Uri.http(Environment.API_OLD_CHAT, '/api/users/createUser');

    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path),
      ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

//-----------------------------------------

  Future<ResponseApi> createUserWithImage(UserModel user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user),
    });

    Response response = await post(Endpoints.createUser, form);

    if (response.body == null) {
      Get.snackbar('Erro na requisicao', 'Nao foi possivel criar usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
