import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/dashboard_controller.dart';
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DashboardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController = Get.find(tag: 'dashboard');

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Obx(() =>
              IndexedStack(
                key: PageStorageKey('Indexed'),
                index: dashboardController.tabIndex.value,
                children: dashboardController.pages,
              ),
          )
      ),
      bottomNavigationBar: MyNavBar(
          icons: [
            FaIcon(FontAwesomeIcons.play),
            FaIcon(FontAwesomeIcons.music),
            FaIcon(FontAwesomeIcons.comment),
            FaIcon(FontAwesomeIcons.bars),
          ]
      ),
    );
  }
}

class MyNavBar extends StatelessWidget{
  final List<Widget> icons;
  MyNavBar({Key? key, required this.icons}) : super(key: key);

  final DashboardController dashboardController = Get.find(tag: 'dashboard');

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: bottomNavColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => dashboardController.changeTabIndex(0),
              child: SizedBox(
                width: 30.w,
                height: 30.h,
                child: SvgPicture.asset(
                    'assets/icon_play.svg',
                    width: 25.w,
                    color: dashboardController.tabIndex.value == 0
                        ? orange1
                        : mainColor
                ),
              ),
            ),
            InkWell(
              onTap: () => dashboardController.changeTabIndex(1),
              child: SizedBox(
                width: 30.w,
                height: 40.h,
                child: SvgPicture.asset(
                    'assets/icon_playlist.svg',
                    width: 25.w,
                    color: dashboardController.tabIndex.value == 1
                        ? orange1
                        : mainColor
                ),
              ),
            ),
            InkWell(
              onTap: () => dashboardController.changeTabIndex(2),
              child: SizedBox(
                width: 30.w,
                height: 40.h,
                child: SvgPicture.asset(
                    'assets/icon_chat.svg',
                    width: 25.w,
                    color: dashboardController.tabIndex.value == 2
                        ? orange1
                        : mainColor
                ),
              ),
            ),
            InkWell(
              onTap: () => dashboardController.changeTabIndex(3),
              child: SizedBox(
                width: 30.w,
                height: 40.h,
                child: SvgPicture.asset(
                    'assets/icon_about.svg',
                    width: 25.w,
                    color: dashboardController.tabIndex.value == 3
                        ? orange1
                        : mainColor
                ),
              ),
            ),
          ],
          // children: List.generate(icons.length, (index) =>
          //     IconButton(
          //       padding: EdgeInsets.all(0),
          //       color: dashboardController.tabIndex.value == index
          //           ? Colors.orange
          //           : mainColor,
          //       splashColor: Colors.transparent,
          //       highlightColor: Colors.transparent,
          //       hoverColor: Colors.transparent,
          //       iconSize: 24,
          //       onPressed: () {
          //         dashboardController.changeTabIndex(index);
          //       },
          //       icon: icons[index],
          //     ),
          // ),
        )
        )
    );
  }

}

ListTile buildListTile(
    BuildContext context, IconData icon, String title, Widget onPress) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    onTap: () {
      if(icon == Icons.supervised_user_circle_rounded)
        Navigator.pop(context);
      // Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => onPress));
    },
    leading: Icon(
      icon,
      size: 22,
      color: Theme.of(context).primaryColor,
    ),
    title: Text(
      title,
      style: TextStyle(letterSpacing: 2).copyWith(fontSize: 16),
    ),
  );
}
