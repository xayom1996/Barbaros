import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:radiobarbaros/theme/text_theme.dart';

class PlayListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find(tag: 'home');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // centerTitle: true,
        titleTextStyle: appBarTitle,
        title: Text('Playlist', style: appBarTitle),
      ),
      body: Container(
        padding: EdgeInsets.all(8.sp),
        child: Obx(() => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var song in homeController.playlist)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.sp),
                          width: 0.9.sw,
                          decoration: BoxDecoration(
                            color: bottomNavColor,
                            borderRadius: BorderRadius.all(Radius.circular(16.sp))
                          ),
                          child: Row(
                            children: [
                              Obx(() {
                                var coverSong = homeController.getCoverSong(song['songName'], song['artistName']);

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16.sp),
                                  child: coverSong == '' || coverSong == null
                                      ? SvgPicture.asset(
                                        'assets/no-cover-wh.svg',
                                        height: 40.h,
                                        fit: BoxFit.cover,
                                      )
                                      : Image(
                                          height: 40.h,
                                          image: NetworkImage(homeController.getCoverSong(song['songName'], song['artistName'])),
                                          fit: BoxFit.cover,
                                        ),

                                );
                              }),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      song['artistName'],
                                      style: kPlayListArtistTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      song['songName'],
                                      style: kPlayListSongTitleTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                )
            ],
          ),
        )),
      ),
    );
  }

}