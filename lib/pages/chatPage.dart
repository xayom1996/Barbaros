import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:radiobarbaros/theme/text_theme.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';


class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_turkish.png',
                width: 0.5.sw,
              ),
              SizedBox(
                height: 16.h,
              ),
              InkWell(
                onTap: () {
                  _launchURL('https://t.me/RadyoBarbaros');
                },
                child: Image(
                  width: 0.4.sw,
                  image: AssetImage('assets/telegram_transition.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

}

class ChatPage1 extends StatefulWidget{

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage1> {

  List<String> attachments = [];
  String attachment = '';
  bool isHTML = true;
  RxBool sendButtonActive = true.obs;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> sendEmail() async {

    var body = """
    <b>Name:</b> ${_nameController.text}<p></p>
    <b>Email:</b> ${_emailController.text}<p></p>
    <b>Phone:</b> ${_phoneController.text}<p></p>
    <b>Message:</b> ${_messageController.text}<p></p>
    """;

    String username = 'barbarosradyo@gmail.com';
    String password = 'Paracard481';

    final smtpServer = gmail(username, password);

    final equivalentMessage = Message()
      ..from = Address(_emailController.text)
      ..recipients.add(Address('app@radiobarbaros.com'))
      ..subject = 'Message from Mobile App'
      ..text = body
      ..html = body
      ..attachments = attachment != ''
          ? [
              FileAttachment(File(attachment))
                ..location = Location.inline
                ..cid = '<myimg@3.141>'
            ]
          : [];

    try {
      final sendReport2 = await send(equivalentMessage, smtpServer);
      clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message successfully sent'),
          backgroundColor: Colors.green,
        ),
      );
    } on MailerException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message not sent.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally{
      sendButtonActive(true);
    }

    // final Email email = Email(
    //   body: body,
    //   subject: 'Message from Mobile App',
    //   recipients: ['app@radiobarbaros.com'],
    //   attachmentPaths: attachment != '' ? [attachment] : [],
    //   isHTML: isHTML,
    // );
    //
    // String platformResponse;
    //
    // try {
    //   await FlutterEmailSender.send(email);
    //   platformResponse = 'success';
    // } catch (error) {
    //   platformResponse = error.toString();
    // }
    //
    // if (!mounted) return;
    //
    // _nameController.text = '';
    // _emailController.text = '';
    // _phoneController.text = '';
    // _messageController.text = '';
    // attachment = '';
    //
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(platformResponse),
    //   ),
    // );
  }

  void clearFields(){
    setState(() {
      _nameController.text = '';
      _emailController.text = '';
      _phoneController.text = '';
      _messageController.text = '';
      attachment = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.sp,
                    vertical: 4.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: kPlayListArtistTextStyle,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.sp),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Ad',
                          hintStyle: kPlayListArtistTextStyle.copyWith(
                            color: Colors.grey
                          ),
                          // labelText: 'Recipient',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.sp,
                    vertical: 4.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: kPlayListArtistTextStyle,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.sp),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'E-posta',
                          hintStyle: kPlayListArtistTextStyle.copyWith(
                              color: Colors.grey
                          ),
                          // labelText: 'Recipient',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.sp,
                    vertical: 4.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Telephone',
                        style: kPlayListArtistTextStyle,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.sp),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Telefone',
                          hintStyle: kPlayListArtistTextStyle.copyWith(
                              color: Colors.grey
                          ),
                          // labelText: 'Recipient',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.sp,
                    vertical: 4.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Message',
                        style: kPlayListArtistTextStyle,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      TextField(
                        controller: _messageController,
                        maxLines: 5,
                        // expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.sp),
                          hintText: 'Messaj',
                          hintStyle: kPlayListArtistTextStyle.copyWith(
                              color: Colors.grey
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // CheckboxListTile(
                //   contentPadding:
                //   EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                //   title: Text('HTML'),
                //   onChanged: (bool? value) {
                //     if (value != null) {
                //       setState(() {
                //         isHTML = value;
                //       });
                //     }
                //   },
                //   value: isHTML,
                // ),
                if (attachment != '')
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            attachment.split('/').last,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: kPlayListArtistTextStyle,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => {_removeAttachment()},
                        )
                      ],
                    ),
                  ),
                if (attachment == '')
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Align(
                      alignment: Alignment.centerLeft,
                        child: Text(
                          'File(≤5Mb)',
                          style: kPlayListArtistTextStyle,
                        )
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          _openImagePicker();
                        },
                        child: Container(
                          child: Image.asset(
                            'assets/BarbarosElements/upload_file.jpg',
                            height: 50.h,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async{
                          if (sendButtonActive.value) {
                            sendButtonActive(false);
                            await sendEmail();
                          }
                        },
                        child: Image.asset(
                          'assets/BarbarosElements/send_email.jpg',
                          height: 50.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openImagePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        double size = result.files.first.size / 1024 / 1024;
        if (size <= 5) {
          setState(() {
            attachment = result.files.first.path!;
          });
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File should not exceed 5 mb'),
            ),
          );
        }
      }
    }catch(e){

    }

  }

  void _removeAttachment() {
    setState(() {
      attachment = '';
    });
  }
}