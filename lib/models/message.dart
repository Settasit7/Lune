import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String receiverID;
  final String senderID;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.receiverID,
    required this.senderID,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'message' : message,
      'receiverID' : receiverID,
      'senderID': senderID,
      'timestamp' : timestamp,
    };
  }
}