import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/chat_controller.dart';
import 'package:radiobarbaros/controllers/auth_controller.dart';
import 'package:radiobarbaros/pages/components/auth_bottom_sheet.dart';
import 'package:radiobarbaros/pages/components/chats_list.dart';
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:radiobarbaros/theme/text_theme.dart';

class ChatPage extends StatefulWidget{

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController chatController = Get.find(tag: 'chat');
  final AuthController authController = Get.find(tag: 'auth');
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: appBarTitle,
        title: Text('Chat', style: appBarTitle),
        actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.black,
              onPressed: (){
                authController.logout();
              },
            ),
      ],
      ),
      body: Obx(() => authController.loading == true
            ? Center(
              child: CircularProgressIndicator(),
            )
            : authController.currentUser.value == null
              ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    if (authController.userId.value == '')
                      Column(
                        children: [
                          const Text('Not authenticated'),
                          TextButton(
                            onPressed: () {
                              Get.bottomSheet(AuthBottomSheet());
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(labelText: 'Display Name'),
                            ),
                          ),
                          RaisedButton(
                            color: mainColor,
                            child: Text("Enter", style: TextStyle(color: Colors.white,),),
                            onPressed: () async{
                              print(_nameController.text);
                              if (_nameController.text != ''){
                                authController.register(_nameController.text);
                              }
                            },
                          ),
                        ],
                      ),
                    Spacer(),
                  ],
                ),
              )
              : ChatsList()
      )
    );
  }
}