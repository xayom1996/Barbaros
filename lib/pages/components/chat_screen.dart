import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:radiobarbaros/pages/components/chat_widget.dart';

class ChatScreen extends StatelessWidget{
  final types.Room room;

  const ChatScreen({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name ?? ''),
      ),
      body: ChatWidget(room: room,),
    );
  }

}