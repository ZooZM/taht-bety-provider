// list_chats_screen.dart
import 'package:flutter/material.dart';

import '../../data/models/chat_messege_model.dart';

import 'chat_screen.dart';

class ListChatsScreen extends StatelessWidget {
  const ListChatsScreen({super.key});

  // Dummy function to simulate fetching previous messages
  List<ChatMessage> _getPreviousMessages(String chatId) {
    // In a real app, you would fetch messages based on the chatId
    if (chatId == 'user1') {
      return [
        ChatMessage(text: 'Hello!', isMe: false),
        ChatMessage(text: 'Hi there!', isMe: true),
        ChatMessage(text: 'How are you?', isMe: false),
      ];
    } else if (chatId == 'user2') {
      return [
        ChatMessage(text: 'Long time no see!', isMe: true),
        ChatMessage(text: 'Yeah, it has been!', isMe: false),
      ];
    } else if (chatId == 'user3') {
      return [
        ChatMessage(text: 'What are you up to?', isMe: false),
        ChatMessage(text: 'Just chilling.', isMe: true),
      ];
    } else if (chatId == 'user4') {
      return [
        ChatMessage(text: 'Did you finish the report?', isMe: true),
        ChatMessage(text: 'Almost done.', isMe: false),
      ];
    } else if (chatId == 'user5') {
      return [
        ChatMessage(text: 'See you tomorrow!', isMe: false),
        ChatMessage(text: 'Sounds good!', isMe: true),
      ];
    } else if (chatId == 'user6') {
      return [
        ChatMessage(text: 'How was your day?', isMe: true),
        ChatMessage(text: 'Pretty good, thanks!', isMe: false),
      ];
    } else if (chatId == 'user7') {
      return [
        ChatMessage(text: 'Let\'s grab coffee sometime.', isMe: false),
        ChatMessage(text: 'Definitely!', isMe: true),
      ];
    } else if (chatId == 'user8') {
      return [
        ChatMessage(text: 'Can you send me that file?', isMe: true),
        ChatMessage(text: 'Sure, just a moment.', isMe: false),
      ];
    } else if (chatId == 'user9') {
      return [
        ChatMessage(text: 'Happy birthday!', isMe: false),
        ChatMessage(text: 'Thank you!', isMe: true),
      ];
    } else if (chatId == 'user10') {
      return [
        ChatMessage(text: 'Are we still on for tonight?', isMe: true),
        ChatMessage(text: 'Yes, absolutely!', isMe: false),
      ];
    } else if (chatId == 'user11') {
      return [
        ChatMessage(text: 'Just wanted to check in.', isMe: false),
        ChatMessage(text: 'Thanks!', isMe: true),
      ];
    } else if (chatId == 'user12') {
      return [
        ChatMessage(text: 'Have a great weekend!', isMe: true),
        ChatMessage(text: 'You too!', isMe: false),
      ];
    }
    return [];
  }

  void _openChatScreen(BuildContext context, String userName, String lastMessage, String chatId) {
    final previousMessages = _getPreviousMessages(chatId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          userName: userName,
          lastMessage: lastMessage,
          previousMessages: previousMessages,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.05,
            left: screenWidth * 0.038,
            right: screenWidth * 0.038,
          ),
          child: Column(
            children: [
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 1',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 1',
                chatId: 'user1',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 2',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 2',
                chatId: 'user2',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 3',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 3',
                chatId: 'user3',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 4',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 4',
                chatId: 'user4',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 5',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 5',
                chatId: 'user5',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 6',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 6',
                chatId: 'user6',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 7',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 7',
                chatId: 'user7',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 8',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 8',
                chatId: 'user8',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 9',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 9',
                chatId: 'user9',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 10',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 10',
                chatId: 'user10',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 11',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 11',
                chatId: 'user11',
              ),
              _buildChatItem(
                context: context,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                userName: 'Alaa Khalid 12',
                lastMessage: 'consectetur advising edit, sed do elusion tempo incident ut 12',
                chatId: 'user12',
              ),
            ],
          ),
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
    required String chatId,
  }) {
    return GestureDetector(
      onTap: () => _openChatScreen(context, userName, lastMessage, chatId),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.0077,
          vertical: screenHeight * 0.0118,
        ),
        width: screenWidth,
        height: screenHeight * 0.15,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFCFD9E9), width: 1)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.205,
              height: screenWidth * 0.205,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/icons/profileChat.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.038),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.041,
                      color: const Color(0xFF15243F),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.0059),
                  Flexible(
                    child: Text(
                      lastMessage,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth * 0.036,
                        height: 1.5419,
                        color: const Color(0xFF15243F),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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

