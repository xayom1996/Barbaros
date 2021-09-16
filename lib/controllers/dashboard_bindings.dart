import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/chat_controller.dart';
import 'package:radiobarbaros/controllers/dashboard_controller.dart';
import 'package:radiobarbaros/controllers/home_controller.dart';
import 'package:radiobarbaros/controllers/auth_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController(), tag: 'dashboard');
    Get.put<HomeController>(HomeController(), tag: 'home');
    Get.put<AuthController>(AuthController(), tag: 'auth');
    Get.put<ChatController>(ChatController(), tag: 'chat');
  }
}