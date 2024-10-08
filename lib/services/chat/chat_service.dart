import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/models/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream<List<Map<String, dynamic>>> getUsersStream() {
  //   return _firestore.collection('users').snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       final user = doc.data();
  //       return user;
  //     }).toList();
  //   });
  // }

Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
  final currentUser = _auth.currentUser;

  return _firestore
      .collection('blockings')
      .where('blockerId', isEqualTo: currentUser!.uid)
      .snapshots()
      .asyncMap((snapshot) async {
        final blockedUserIds = snapshot.docs.map((doc) => doc['blockedId']).toList();
        
        // Also get users who have blocked the current user
        final blockedByOthersSnapshot = await _firestore
          .collection('blockings')
          .where('blockedId', isEqualTo: currentUser.uid)
          .get();
        final blockedByOtherUserIds = blockedByOthersSnapshot.docs.map((doc) => doc['blockerId']).toList();

        final allBlockedUserIds = [...blockedUserIds, ...blockedByOtherUserIds];

        final usersSnapshot = await _firestore.collection('users').get();

        return usersSnapshot.docs
          .where((doc) => doc.id != currentUser.uid && !allBlockedUserIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
      });
}


Future<void> blockUser(String blockedId) async {
  await _firestore.collection('blockings').doc().set({
    'blockerId': FirebaseAuth.instance.currentUser!.uid,
    'blockedId': blockedId,
  });
  notifyListeners();
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
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('reports').add(report);
  }

  // Future<void> blockUser(String userId) async {
  //   final currentUser = _auth.currentUser;
  //   await _firestore
  //     .collection('users')
  //     .doc(currentUser!.uid)
  //     .collection('blocked_users')
  //     .doc(userId)
  //     .set({});
  //   //notifyListeners();
  // }

  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = _auth.currentUser;
    await _firestore
      .collection('users')
      .doc(currentUser!.uid)
      .collection('blocked_users')
      .doc(blockedUserId)
      .delete();
  }

  Stream<List<Map<String, dynamic>>> getBlockedUsersStream() {
    final currentUser = _auth.currentUser;

    return _firestore
        .collection('blockings')
        .where('blockerId', isEqualTo: currentUser!.uid)
        .snapshots()
        .asyncMap((snapshot) async {
          final blockedUserIds = snapshot.docs.map((doc) => doc['blockedId']).toList();

          if (blockedUserIds.isEmpty) {
            return [];
          }
          final blockedUsersSnapshot = await _firestore
              .collection('users')
              .where(FieldPath.documentId, whereIn: blockedUserIds)
              .get();
              
          return blockedUsersSnapshot.docs.map((doc) => doc.data()).toList();
        });
  }
}