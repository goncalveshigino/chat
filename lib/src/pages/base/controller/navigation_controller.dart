import 'package:chat/src/api/endpoints.dart';
import 'package:chat/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class NavigationTabs {
  static const int chat = 0;
  static const int user = 1;
  static const int profile = 2;
}

class NavigationController extends GetxController {


  UserModel user = UserModel.fromJson(GetStorage().read('user') ?? {});


  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;


  NavigationController(){
    print('Usuario Session: ${user.toJson()}');
    connectAndListen();
  }

  
  Socket socket = io('${Environment.apiChat}chat', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false
  });

  @override
  void onInit() {
    super.onInit();

    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.chat),
      currentIndex: NavigationTabs.chat,
    );
  }

  void _initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigationPageView(int page) {
    if (_currentIndex.value == page) return;

    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }

  void connectAndListen() {
    if (user.id != null) {
      socket.connect();
      socket.onConnect((data) {
        print('Usuario conectado a SOCKET IO');
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    socket.disconnect();
  }
}
