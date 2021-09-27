import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:radiobarbaros/controllers/chat_controller.dart';
import 'package:radiobarbaros/controllers/dashboard_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  RxString status = ''.obs;
  RxBool loading = false.obs;
  RxString userId = ''.obs;
  Rx<types.User?> currentUser = Rx<types.User?>(null);
  RxString verificationId = ''.obs;

  @override
  void onInit(){
    initializeFlutterFire();
    super.onInit();
  }

  void initializeFlutterFire() async {
    try {
      firebaseUser.value = _auth.currentUser;
      if (firebaseUser.value != null) {
        userId(firebaseUser.value!.uid);
        print('Init');
        await getCurrentUser();
      }
      // print(currentUser);
    } catch (e) {
      print('Init');
      print(e);
    }
  }

  Future<void> getCurrentUser() async{
    try {
      currentUser(types.User.fromJson(await fetchUser(userId.value, 'users')));
    } catch(e){
      print(e);
    }
  }

  void register(String displayName) async {
    loading(true);
    try {
      currentUser.value = types.User(
          firstName: displayName,
          id: firebaseUser.value!.uid,
          role: types.Role.user
      );
      await FirebaseChatCore.instance.createUserInFirestore(
          currentUser.value!
      );
      final ChatController chatController = Get.find(tag: 'chat');
      await chatController.createRoom();
    } catch (e) {
      print(e);
    } finally{
      loading(false);
    }
  }

  void signInWithPhoneNumber(String smsCode) async {
    loading(true);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );

      firebaseUser.value = (await _auth.signInWithCredential(credential)).user!;

      // showSnackbar("Successfully signed in UID: ${user.uid}");
      final AuthController authController = Get.find(tag: 'auth');
      final DashboardController dashboardController = Get.find(tag: 'dashboard');
      authController.userId(firebaseUser.value!.uid);
      await authController.getCurrentUser();
      dashboardController.changeTabIndex(2);
      Get.back();
    } catch (e) {
      print('Failed to sign in: $e');
      // showSnackbar("Failed to sign in: " + e.toString());
      Get.snackbar('', "Failed to sign in");
    } finally{
      loading(false);
    }

  }

  void verifyPhoneNumber(String phoneNumber) async {
    loading(true);
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      Get.snackbar('', "Phone number automatically verified and user signed in");
    };

    PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
      Get.snackbar('', 'Phone number verification failed.');
    };

    PhoneCodeSent codeSent = (String _verificationId, [int? forceResendingToken]) async {
      Get.snackbar('', 'Please check your phone for the verification code.');
      verificationId(_verificationId);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String _verificationId) {
      verificationId(_verificationId);
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      Get.snackbar('', 'Failed to Verify Phone Number');
    }
    loading(false);
  }

  Future<Map<String, dynamic>> fetchUser(
      String userId,
      String usersCollectionName) async {
    final doc = await FirebaseFirestore.instance
        .collection(usersCollectionName)
        .doc(userId)
        .get();

    final data = doc.data()!;

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

    return data;
  }

  void logout() async {
    loading(true);
    try {
      await FirebaseAuth.instance.signOut();
      userId('');
      firebaseUser.value = null;
      currentUser.value = null;
      verificationId.value = '';
    } catch (e) {
      print(e);
    } finally{
      loading(false);
    }
  }
}