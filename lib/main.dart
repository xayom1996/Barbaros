import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/pages/dashboardPage.dart';
import 'package:radiobarbaros/theme/app_theme.dart';
import 'package:radiobarbaros/controllers/dashboard_bindings.dart';

void main() async{
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
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