import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          child: Image(
            width: MediaQuery.of(context).size.width / 2,
            image: AssetImage('assets/Logo Barbaros FINAL.png'),
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
              print(volume);
              homeController.onChangeVolume(volume);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.sp),
            child: AspectRatio(
                aspectRatio: 0.8.sw / 0.35.sh,
                child: Obx(() {
                  var coverSong = homeController.getCoverSong('', '');

                  return Container(
                    decoration: new BoxDecoration(
                        image: coverSong == '' || coverSong == null
                            ? DecorationImage(
                              alignment: FractionalOffset.topCenter,
                              fit: BoxFit.fitWidth,
                              image: AssetImage('assets/no-cover-wh.png')
                              // image: AssetImage('assets/cover_image.jpg')
                            )
                            : DecorationImage(
                              fit: BoxFit.fitWidth,
                              alignment: FractionalOffset.topCenter,
                              // image: AssetImage('assets/no-cover-wh.png')
                              image: NetworkImage(homeController.getCoverSong('', ''))
                            ),
                    ),
                  );
                })
            ),
          ),
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
            child: homeController.playing.value
                ? Image(
                    width: MediaQuery.of(context).size.width / 4,
                    image: playImg,
                    fit: BoxFit.cover,
                  )
                : Image(
                    width: MediaQuery.of(context).size.width / 4,
                    image: pauseImg,
                    fit: BoxFit.cover,
                  )
          )),
          Spacer(),
        ],
      ),
    );
  }
}