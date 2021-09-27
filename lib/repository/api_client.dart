import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:html_unescape/html_unescape.dart';

class ApiClient {
  static const baseUrl = 'https://c26.radioboss.fm';
  static const audioscrobblerUrl = 'https://ws.audioscrobbler.com/2.0/';
  static const apiKeyLastFm = '89ac288818d5ae760892e0b47c09d12a';
  static const timeout = 5;

  static Future<String> getSongTitle() async {
    final apiUrl = Uri.parse('$baseUrl/statistics?json=1');
    final response = await http.get(apiUrl).timeout(
        Duration(seconds: timeout));

    final objJson = jsonDecode(response.body);
    // print(objJson);

    if (response.statusCode != 200) {
      throw Exception('error');
    }
    else
      return objJson['streams'][0]['songtitle'];
  }

  static Future<List<Map>> getListSongs() async{
    final apiUrl = Uri.parse('$baseUrl/w/recenttrackslist?u=309');
    final response = await http.get(apiUrl).timeout(
        Duration(seconds: timeout));

    final objJson = jsonDecode(response.body);
    List<Map> songsInfo = [];

    for (var song in objJson){
      var songInfo = {};
      var title = HtmlUnescape().convert(song['title']);
      songInfo['artistName'] = title.split(" - ")[0];
      if(title.split(" - ").length >= 2)
        songInfo['songName'] = title.split(" - ")[1];
      else
        songInfo['songName'] = '';
      songsInfo.add(songInfo);
      if (songsInfo.length >= 8)
        break;
    }
    return songsInfo;
  }

  static Future<String> searchSongsImage(String songName, String artistName) async{
    final apiUrl = Uri.parse('$audioscrobblerUrl/?method=track.getInfo&artist=$artistName&track=$songName&api_key=$apiKeyLastFm&format=json');
    final response = await http.get(apiUrl).timeout(Duration(seconds: timeout));
    final objJson = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception('error');
    }
    else {
      try{
        return objJson['track']['album']['image'][3]["#text"];
      }catch(error){
        return '';
      }
    }
  }
}