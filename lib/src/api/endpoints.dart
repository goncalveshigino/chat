
const String apiChat = "http://192.168.8.101:3000/api/users";

abstract class Endpoints {
   
 static const String createUser = '$apiChat/createUser';
 static const String update = '$apiChat/update';
  static const String singnIn = '$apiChat/singnIn';
}

class Environment {
   static const String API_OLD_CHAT = "192.168.8.101:3000";
}