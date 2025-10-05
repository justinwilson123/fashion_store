import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/feature/account/data/models/last_message_model.dart';
import 'package:fashion/feature/account/data/models/message_model.dart';
import '../../injiction_container.dart' as di;

class FirebaseDatabaseService {
  final FirebaseFirestore _firebaseFireStore = di.sl<FirebaseFirestore>();

  FirebaseDatabaseService();

  Future<bool> checkChatExists(String userID) async {
    final result =
        await _firebaseFireStore.collection("chat").doc(userID).get();

    return result.exists;
  }

  Future<void> creatNewChat(
      {required LastMessageModel lastMessage, required String userID}) async {
    // try {
    final docRef = _firebaseFireStore.collection("chat").doc(userID);
    await docRef.set(lastMessage.toJson());
    // }
  }

  Future<void> updateLateMessage(
      LastMessageModel lastMessage, String userID) async {
    await _firebaseFireStore
        .collection("chat")
        .doc(userID)
        .update(lastMessage.toJson());
  }

  Future<void> sendMessage(MessageModel message, String userID) async {
    await _firebaseFireStore
        .collection("chat")
        .doc(userID)
        .collection('messages')
        .add(message.toJson());
  }

  Stream<List<MessageModel>> getMessage(String userID) {
    return _firebaseFireStore
        .collection("chat")
        .doc(userID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map<List<MessageModel>>((snapshot) {
      return snapshot.docs
          .map<MessageModel>((doc) => MessageModel.fromJson(doc.data()))
          .toList();
    });
  }
}
