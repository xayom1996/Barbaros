import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/pages/chatPage.dart';
import 'package:radiobarbaros/pages/aboutPage.dart';
import 'package:radiobarbaros/pages/homePage.dart';
import 'package:radiobarbaros/pages/playListPage.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find(tag: 'dashboard');
  var tabIndex = 0.obs;
  late List<Widget> pages;

  @override
  void onInit(){
    pages = [
      HomePage(),
      PlayListPage(),
      ChatPage(),
      AboutPage(),
    ];
    super.onInit();
  }

  Widget get currentPage => pages[tabIndex.value];

  void changeTabIndex(int index) async {
    tabIndex.value = index;
  }
}