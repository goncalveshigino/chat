

import 'package:chat/src/api/endpoints.dart';
import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/message_model.dart';

class MessageProvider extends GetConnect {

  String url = Environment.apiChat + 'api/chats';

  UserModel user = UserModel.fromJson(GetStorage().read('user') ?? {});

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

}