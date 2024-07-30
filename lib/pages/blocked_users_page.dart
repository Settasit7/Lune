import 'package:flutter/material.dart';
import 'package:lune/components/user_tile.dart';
import 'package:lune/services/auth/auth_service.dart';
import 'package:lune/services/chat/chat_service.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService authService = AuthService();

  void _showUnblockBox(BuildContext context, String userId) {

  }

  @override
  Widget build(BuildContext context) {

    String userId = authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked users'),
        actions: const [],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading...'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final blockedUsers = snapshot.data ?? [];
          if (blockedUsers.isEmpty) {
            return const Center(
              child: Text('No blocked users'),
            );
          }
          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index) {
              final user = blockedUsers[index];
              return UserTile(
                text: user['username'],
                onTap: () => _showUnblockBox(context, user['uid']),
              );
            },
          );
        },
      ),
    );
  }
}