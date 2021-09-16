import 'package:radiobarbaros/models/user.dart';

// class FirestoreService {
//   final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection("users");
//
//   Future getUser(String uid) async {
//     try {
//       var userData = await _usersCollectionReference.document(uid).get();
//       return User.fromData(userData.data);
//     } catch (e) {
//       return e.message;
//     }
//   }
// }