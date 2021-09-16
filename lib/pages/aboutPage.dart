import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                _launchURL('https://radiobarbaros.com/');
              },
              child: Image(
                width: 50.w,
                image: AssetImage('assets/BarbarosElements/Asset 19.png'),
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: () {
                _launchURL('https://radiobarbaros.com/');
              },
              child: Image(
                width: 50.w,
                image: AssetImage('assets/BarbarosElements/Asset 17.png'),
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: () {
                _launchURL('https://www.instagram.com/radiobarbaros/');
              },
              child: Image(
                width: 50.w,
                image: AssetImage('assets/BarbarosElements/Asset 16.png'),
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: () {
                _launchURL('https://radiobarbaros.com/');
              },
              child: Image(
                width: 50.w,
                image: AssetImage('assets/BarbarosElements/Asset 18.png'),
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: () {
                _launchURL('https://radiobarbaros.com/');
              },
              child: Image(
                width: 50.w,
                image: AssetImage('assets/BarbarosElements/Asset 15.png'),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

void _launchURL(String _url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';