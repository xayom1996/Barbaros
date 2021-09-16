import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var kHeadTextStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
  ),
);
var kPlayingFromTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 10.sp,
    height: 1.4,
  ),
);
var kAlbumTitleTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: white1,
  ),
);
var kTimeTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 11.sp,
    height: 1.2,
  ),
);

var kPlayListSongTitleTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 11.sp,
    color: orange1,
    height: 1.2,
  ),
);

var kPlayListArtistTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 14.sp,
    height: 1.2,
  ),
);


var kSongTitleTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 24.sp,
    //fontWeight: FontWeight.w700,
    height: 1.2,
  ),
);

var kSongArtistTextStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 14.sp,
    //fontWeight: FontWeight.w700,
    color: Colors.grey,
    height: 1.2,
  ),
);

var appBarTitle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 24.sp,
    color: Colors.black,
    height: 1.2,
  ),
);

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 0),
  blurRadius: 90,
  color: Color(0xff42426F),
);
