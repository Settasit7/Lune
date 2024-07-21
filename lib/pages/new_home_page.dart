import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/my_drawer.dart';
import 'package:lune/components/user_tile.dart';
import 'package:lune/pages/chat_page.dart';
import 'package:lune/services/chat/chat_service.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    _checkAndCreateUserProfile();
  }

  Future<void> _checkAndCreateUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(user.uid);
      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'uid': user.uid,
          'email': user.email,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != FirebaseAuth.instance.currentUser!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
