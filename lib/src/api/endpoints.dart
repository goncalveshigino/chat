const String apiChat = "http://192.168.8.101:3000/api/users";
const String apiiChat = "http://192.168.8.101:3000/api/chats";
const String apiiiChat = "http://192.168.8.101:3000/api/messages";

abstract class Endpoints {
  static const String createUser = '$apiChat/createUser';
  static const String update = '$apiChat/update';
  static const String updateNotificationToken = '$apiChat/updateNotificationToken';
  static const String singnIn = '$apiChat/singnIn';
  static const String getUsers = '$apiChat/getAllUsers';
  static const String create = '$apiiChat/create';
  static const String createMessage = '$apiiiChat/createMessage';
  static const String updateToSeen = '$apiiiChat/updateToSeen';
}

class Environment {
  static const String API_OLD_CHAT = "192.168.8.101:3000";
  static const String apiChat = "http://192.168.8.101:3000/";
  static const String image_url = "https://cdn-icons-png.flaticon.com/512/16/16480.png";
}
