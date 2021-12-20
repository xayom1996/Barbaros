import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/home_controller.dart';
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:radiobarbaros/theme/text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volume_watcher/volume_watcher.dart';

class HomePage extends StatelessWidget {
  final ImageProvider playImg = AssetImage('assets/BarbarosElements/Asset 5.png');
  final ImageProvider pauseImg = AssetImage('assets/BarbarosElements/Asset 4.png');

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find(tag: 'home');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(16.sp),
          child: SvgPicture.asset(
            'assets/Logo-Barbaros-FINAL.svg',
            width: MediaQuery.of(context).size.width / 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.sp),
            child: Text('Antalya 93.8 FM', style: kSongArtistTextStyle,),
          ),
          VolumeWatcher(
            onVolumeChangeListener: (double volume) {
              homeController.onChangeVolume(volume);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.sp),
            child: Obx(() {
              print('https://c26.radioboss.fm/w/artwork/309.png?${homeController
                  .ts.value.toString()}');
              return Image(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    // homeController.changeTime();
                    print('ERRoRRR');
                    return SvgPicture.asset(
                      'assets/no-cover-wh.svg',
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                    );
                  },
                  image: NetworkImage(
                      'https://c26.radioboss.fm/w/artwork/309.png?${homeController
                          .ts.value.toString()}')
              );
            }
            )
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.sp),
            child: Obx(() => SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: mainColor,
                inactiveTrackColor: mainColor,
                trackShape: RectangularSliderTrackShape(),
                trackHeight: 4.0,
                thumbColor: Colors.orange,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                // overlayColor: mainColor,
                // overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              ),
              child: Slider(
                min: 0.0,
                max: 1.0,
                value: homeController.volume.value,
                onChanged: (value) {
                  homeController.onChangeVolume(value);
                  // player.seek(Duration(milliseconds: currentValue.round()));
                },
              ),
            )),
          ),
          Spacer(),
          if (homeController.songName != 'songName')
            Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.sp),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      homeController.songName.value,
                      maxLines: 2,
                      style: kSongTitleTextStyle,
                    ),
                    Text(
                      homeController.artistName.value,
                      style: kSongArtistTextStyle,
                    ),
                  ],
                ),
              ),
            )),
          SizedBox(
            height: 20,
          ),
          Obx(() => GestureDetector(
            onTap: () {
              homeController.onTap();
            },
            child: !homeController.playing.value
                ? SvgPicture.asset(
                    'assets/play.svg',
                    width: MediaQuery.of(context).size.width / 4,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    'assets/pause.svg',
                    width: MediaQuery.of(context).size.width / 4,
                    fit: BoxFit.cover,
                  )
          )),
          Spacer(),
        ],
      ),
    );
  }
}