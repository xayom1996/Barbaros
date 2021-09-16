import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/constants.dart';
import 'package:radiobarbaros/repository/api_client.dart';
import 'package:volume_watcher/volume_watcher.dart';

class HomeController extends GetxController{
  final Timer timer = Timer(Duration(milliseconds: 500), () {});
  final assetsAudioPlayer = AssetsAudioPlayer();
  final RxString songName = ''.obs;
  final RxString artistName = ''.obs;
  final RxBool playing = false.obs;
  final RxDouble volume = 0.5.obs;
  final RxList playlist = [].obs;

  final RxMap covers = {}.obs;

  @override
  void onInit() {
    super.onInit();
    initPlatformState();

    try {
      var audio = Audio.liveStream(radioUrl,
          metas: Metas(
            title: songName.value,
            artist: artistName.value,
          )
      );
      assetsAudioPlayer.open(
          audio,
          autoStart: false,
          showNotification: true
      );
    }catch(error){

    }

    getListSongs();
    Timer.periodic(new Duration(seconds: 5), (timer) {
      getListSongs();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      volume(await VolumeWatcher.getCurrentVolume);
    } on PlatformException {
      platformVersion = 'Failed to get volume.';
    }
  }

  void onTap() async{
    playing(!playing.value);

    if (playing.value)
      assetsAudioPlayer.play();
    else
      assetsAudioPlayer.pause();
  }

  void onChangeVolume(double newVolume) async{
    assetsAudioPlayer.setVolume(newVolume);
    VolumeWatcher.setVolume(newVolume);
    volume(newVolume);
  }

  void getSongTitle() async{
    var songTitle = await ApiClient.getSongTitle();
    var _artistName = songTitle.split(" - ")[0];
    var _songName = songTitle.split(" - ")[1];
    if (songName.value != _songName) {
      artistName(_artistName);
      songName(_songName);

      Timer(Duration(seconds: 2), () {
        getListSongs();
      });
    }
  }

  void getListSongs() async{
    try {
      var _playlist = await ApiClient.getListSongs();
      if (_playlist.length > 0) {
        artistName(_playlist[0]['artistName']);
        songName(_playlist[0]['songName']);
      }
      playlist(_playlist);
    } catch(error){
      print(error);
    }
  }

  getCoverSong(String _songName, String _artistName) {
    var song;
    if (_songName == '') {
      _artistName = artistName.value;
      _songName = songName.value;
    }
    song = "$_artistName - $_songName";

    if (covers[song] == null && _songName != '') {
        Timer(Duration(seconds: 3), () {
          searchCoverImage(_songName, _artistName);
        });
    }
    return covers[song];
  }

  void searchCoverImage(String newSongName, String newArtistName) async{
    var song = "$newArtistName - $newSongName";

    try {
      if (covers[song] == null) {
        var getCoverImage = await ApiClient.searchSongsImage(
            newSongName, newArtistName);
        covers[song] = getCoverImage;
      }
    } catch(error){
      print(error);
    }finally{

    }
  }
}