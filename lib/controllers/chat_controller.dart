import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radiobarbaros/constants.dart';

class ChatController extends GetxController{
  User? user;
  RxString roomId = ''.obs;
  RxList roomIds = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> createRoom() async{
    types.User? adminUser = types.User.fromJson(await fetchUser(adminUserId, 'users'));
    await FirebaseChatCore.instance.createRoom(adminUser);
  }

  Stream<List<types.Room>> rooms({bool orderByUpdatedAt = false}) {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) return const Stream.empty();

    final collection = orderByUpdatedAt
        ? FirebaseFirestore.instance
        .collection('rooms')
        .where('userIds', arrayContains: firebaseUser.uid)
        .orderBy('updatedAt', descending: true)
        : FirebaseFirestore.instance
        .collection('rooms')
        .where('userIds', arrayContains: firebaseUser.uid);

    return collection
        .snapshots()
        .asyncMap((query) => processRoomsQuery(firebaseUser, query, 'users'));
  }

  Stream<List<types.Room>> room({bool orderByUpdatedAt = false}) {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) return const Stream.empty();

    final collection = orderByUpdatedAt
        ? FirebaseFirestore.instance
        .collection('rooms')
        .where('userIds', arrayContains: firebaseUser.uid)
        .orderBy('updatedAt', descending: true)
        : FirebaseFirestore.instance
        .collection('rooms')
        .where('userIds', arrayContains: firebaseUser.uid);

    return collection
        .snapshots()
        .asyncMap((query) => processRoomsQuery(firebaseUser, query, 'users'));
  }
}