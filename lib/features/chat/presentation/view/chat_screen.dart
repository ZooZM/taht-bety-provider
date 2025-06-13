// chat_screen.dart
import 'package:flutter/material.dart';

import '../../../../auth/presentation/view/widgets/back_button_circle.dart';
import '../../data/models/chat_messege_model.dart';


class ChatScreen extends StatefulWidget {
  final String userName;
  final String lastMessage;
  final List<ChatMessage> previousMessages;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.lastMessage,
    this.previousMessages = const [],
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    _messages.addAll(widget.previousMessages);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(text: _messageController.text.trim(), isMe: true),
        );
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.064,
              screenHeight * 0.052,
              screenWidth * 0.179,
              screenHeight * 0.024,
            ),
            child: Row(
              children: [
                BackButtonCircle(),
                SizedBox(width: screenWidth * 0.026),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.154,
                      height: screenWidth * 0.154,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/icons/profileChat.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.026),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.041,
                            color: const Color(0xFF15243F),
                            height: 1.5419,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFFCFD9E9), thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
              child: Column(
                children: [
                  for (int i = 0; i < _messages.length; i++)
                    Column(
                      children: [
                        _buildChatMessage(
                          screenWidth: screenWidth,
                          isMe: _messages[i].isMe,
                          message: _messages[i].text,
                        ),
                        if (i < _messages.length - 1)
                          SizedBox(height: screenHeight * 0.01),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.064),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: screenHeight * 0.01,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF99A8C2)),
                      borderRadius: BorderRadius.circular(screenWidth * 0.128),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type here or speak',
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.128),
                   
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.051),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: screenWidth * 0.123,
                    height: screenWidth * 0.123,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A4D6F),
                      borderRadius: BorderRadius.circular(
                        screenWidth * 0.123 / 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.send, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage({
    required double screenWidth,
    required bool isMe,
    required String message,
  }) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isMe)
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.02),
              child: Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/icons/Provider Icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.symmetric(vertical: screenWidth * 0.013),
            padding: EdgeInsets.all(screenWidth * 0.031),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFDCF8C6) : const Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(screenWidth * 0.031),
            ),
            child: Text(
              message,
              style: TextStyle(fontSize: screenWidth * 0.041),
            ),
          ),
          if (isMe)
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/icons/profileChat.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

