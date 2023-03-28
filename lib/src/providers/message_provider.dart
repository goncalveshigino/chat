import 'dart:convert';
import 'dart:io';

import 'package:chat/src/api/endpoints.dart';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../models/message_model.dart';

class MessageProvider extends GetConnect {
  String url = Environment.apiChat + 'api/messages';

  UserModel user = UserModel.fromJson(GetStorage().read('user') ?? {});

  Future<List<MessageModel>> getMessages(String idChat) async {
    Response response = await get('$url/findByChat/$idChat', headers: {
      'Content-Type': 'Application/json',
      'Authorization': user.sessionToken!
    });

    if (response.statusCode == 401) {
      Get.snackbar('Requicao Negada', 'Usuario sem permissao');
      return [];
    }

    List<MessageModel> messages = MessageModel.fromJsonList(response.body);

    return messages;
  }

  Future<ResponseApi> createMessage(MessageModel message) async {
    Response response = await post(
      Endpoints.createMessage,
      message.toJson(),
      headers: {
        'Content-Type': 'Application/json',
        'Authorization': user.sessionToken!
      },
    );

    if (response.body == null) {
      Get.snackbar('Error', 'Erro ao criar Mensagem');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<Stream> createWithImage(MessageModel message, File image) async {
    Uri uri =
        Uri.http(Environment.API_OLD_CHAT, '/api/messages/createWithImage');

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = user.sessionToken!;
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path),
    ));
    request.fields['message'] = json.encode(message);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
}
