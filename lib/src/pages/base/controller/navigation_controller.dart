import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

abstract class NavigationTabs {

  static const int chat = 0;
  static const int users = 1;
  static const int profile = 2;

}

class NavigationController extends GetxController {
  
  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;



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
}
