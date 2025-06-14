// list_chats_screen.dart
import 'package:flutter/material.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_screen.dart';

class ListChatsScreen extends StatelessWidget {
  const ListChatsScreen({super.key, required this.providerId});

  final String providerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Chats')
            .where('provider_id', isEqualTo: providerId)
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No chats found'));
          }

          final chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final data = chats[index].data() as Map<String, dynamic>;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: _buildChatItem(
                  context: context,
                  screenWidth: MediaQuery.of(context).size.width,
                  screenHeight: MediaQuery.of(context).size.height,
                  userName: data['userName'] ?? '',
                  lastMessage: data['lastMessage'] ?? '',
                  userId: data['user_id'] ?? '',
                  userImage: data['userImage'] ?? '',
                  providerId: data['provider_id'] ?? '',
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openChatScreen(BuildContext context, String userName, String userId,
      String userImage, String providerImage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          userName: userName,
          userId: userId,
          userImage: userImage,
          providerImage: providerImage,
          providerId: providerId,
        ),
      ),
    );
  }

  Widget _buildChatItem({
    required BuildContext context,
    required double screenWidth,
    required double screenHeight,
    required String userName,
    required String lastMessage,
    required String userId,
    required String providerId,
    required String userImage,
  }) {
    return GestureDetector(
      onTap: () => _openChatScreen(
        context,
        userName,
        userId,
        userImage,
        UserStorage.getUserData().photo,
      ),
      child: Container(
        width: screenWidth,
        height: screenHeight * 0.1,
        color: Colors.white,
        child: Row(
          children: [
            CircleAvatar(
              radius: screenHeight * 0.04,
              backgroundImage: userImage.isNotEmpty
                  ? NetworkImage(userImage)
                  : const AssetImage('assets/icons/profileChat.png')
                      as ImageProvider,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userName, style: Styles.subtitle16Bold),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    style: Styles.text16SemiBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
