import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/pages/dashboardPage.dart';
import 'package:radiobarbaros/theme/app_theme.dart';
import 'package:radiobarbaros/controllers/dashboard_bindings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appThemeData[AppTheme.RedLight],
        title: "Barbaros",
        initialBinding: DashboardBinding(),
        home: DashboardPage(),
      ),
    );
  }
}