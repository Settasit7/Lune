import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lune/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      message: message,
      receiverID: receiverID,
      senderID: currentUserID,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
      .collection('chat_rooms')
      .doc(chatRoomID)
      .collection('messages')
      .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
    .collection('chat_rooms')
    .doc(chatRoomID)
    .collection('messages')
    .orderBy('timestamp', descending: false)
    .snapshots();
  }

  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('reports').add(report);
  }

  Future<void> blockUser(String userId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.uid)
      .collection('blocked_users')
      .doc(userId)
      .set({});
    //notifyListeners();
  }

  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.uid)
      .collection('blocked_users')
      .doc(blockedUserId)
      .delete();
  }

  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('blocked_users')
      .snapshots()
      .asyncMap((snapshot) async {
        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();
        final userDocs = await Future.wait(
          blockedUserIds.map((id) => _firestore.collection('users').doc(id).get()),
        );
        return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
  }
}