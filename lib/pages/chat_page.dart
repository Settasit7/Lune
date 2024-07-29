import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/chat_bubble.dart';
import 'package:lune/components/message_field.dart';
import 'package:lune/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUsername;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverUsername,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final FocusNode _myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _myFocusNode.addListener(() {
      if (_myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    _myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.receiverUsername),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverID,
        senderID,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          controller: _scrollController,
          children: 
            snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    final bool isCurrentUser = data['senderID'] == FirebaseAuth.instance.currentUser!.uid;
    
    return Column(
      crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(
          message: data['message'],
          isCurrentUser: isCurrentUser,
          messageId: doc.id,
          userId: data['senderID'],
        )
      ],
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: MessageField(
              controller: _messageController,
              hintText: 'Type here',
              obscureText: false,
              focusNode: _myFocusNode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}