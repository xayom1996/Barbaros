import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/chat_controller.dart';
import 'package:radiobarbaros/controllers/auth_controller.dart';
import 'package:radiobarbaros/pages/components/chat_screen.dart';
import 'package:radiobarbaros/pages/components/chat_widget.dart';
import 'package:radiobarbaros/constants.dart';
import 'package:radiobarbaros/theme/color_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsList extends StatelessWidget{
  final ChatController chatController = Get.find(tag: 'chat');
  final AuthController authController = Get.find(tag: 'auth');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<types.Room>>(
      stream: chatController.rooms(),
      initialData: const [],
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              bottom: 200,
            ),
            child: const Text('No rooms'),
          );
        }

        if (authController.currentUser.value!.id != adminUserId){
          return ChatWidget(room: snapshot.data![0],);
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final room = snapshot.data![index];

            return Padding(
              padding: EdgeInsets.all(8.sp),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        room: room,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                      color: bottomNavColor,
                      borderRadius: BorderRadius.all(Radius.circular(16.sp))
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: CircleAvatar(
                          // backgroundColor: color,
                          // backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
                          radius: 20,
                          // child: !hasImage
                          //     ? Text(
                          //   name.isEmpty ? '' : name[0].toUpperCase(),
                          //   style: const TextStyle(color: Colors.white),
                          // )
                          //     : null,
                        ),
                      ),
                      Text(room.name ?? ''),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}