

import 'package:chat/src/api/endpoints.dart';
import 'package:chat/src/models/chat_model.dart';
import 'package:chat/src/models/response_api.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatProvider extends GetConnect {

  String url = Environment.apiChat + 'api/chats';

  UserModel user = UserModel.fromJson(GetStorage().read('user') ?? {});

  Future<List<ChatModel>> getChats() async {
    Response response = await get(
        '$url/findByIdUser/${user.id}',
        //'${Endpoints.getUsers}${user.id}',
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': user.sessionToken!
        });

    if (response.statusCode == 401) {
      Get.snackbar('Requicao Negada', 'Erro ao carregar chats');
      return [];
    }

    List<ChatModel> chats = ChatModel.fromJsonList(response.body);


    return chats;
  }

  Future<ResponseApi> create(ChatModel chat) async {
    Response response = await post(
      Endpoints.create,
      chat.toJson(),
      headers: {
        'Content-Type': 'Application/json',
        'Authorization': user.sessionToken!
      },
    );

    if (response.body == null) {
      Get.snackbar('Error', 'Erro ao criar chat');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

}