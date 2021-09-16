import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/auth_controller.dart';
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:radiobarbaros/theme/text_theme.dart';

class AuthBottomSheet extends StatefulWidget{
  @override
  _AuthBottomSheetState createState() => _AuthBottomSheetState();
}

class _AuthBottomSheetState extends State<AuthBottomSheet> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final AuthController authController = Get.find(tag: 'auth');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(8),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Obx(() => authController.loading == true
                  ? Center(
                    child: CircularProgressIndicator(),
                  )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(child: Text('Login', style: appBarTitle)),
                        TextFormField(
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(labelText: 'Phone number (+xx xxx-xxx-xxxx)'),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          child: RaisedButton(
                            color: mainColor,
                            child: Text("Verify Number", style: TextStyle(color: Colors.white,),),
                            onPressed: () async {
                              authController.verifyPhoneNumber(_phoneNumberController.text);
                            },
                          ),
                        ),
                        if(authController.verificationId.value != '')
                          Column(
                            children: [
                              TextFormField(
                                controller: _smsController,
                                decoration: const InputDecoration(labelText: 'Verification code'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 16.0),
                                alignment: Alignment.center,
                                child: RaisedButton(
                                    color: mainColor,
                                    onPressed: () async {
                                      authController.signInWithPhoneNumber(_smsController.text);
                                    },
                                    child: Text("Sign in", style: TextStyle(color: Colors.white,))),
                              ),
                            ],
                          ),
                      ],
                    )
              )
          ),
        ),
      )
    );
  }
}