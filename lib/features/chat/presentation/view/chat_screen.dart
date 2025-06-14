// Refactored provider chat screen with Firebase integration and message display

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import '../../../../auth/presentation/view/widgets/back_button_circle.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userId;
  final String userImage;
  final String providerId;
  final String providerImage;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userId,
    required this.userImage,
    required this.providerId,
    required this.providerImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final chatId = '${widget.providerId}_${widget.userId}';

    _messageController.clear();
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'text': text,
      'isUser': false,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance.collection('Chats').doc(chatId).set({
      'provider_id': widget.providerId,
      'user_id': widget.userId,
      'userName': widget.userName,
      'userImage': widget.userImage,
      'lastMessage': text,
      'lastMessageTime': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const BackButtonCircle(),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.1504,
                      height: screenWidth * 0.1504,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.userImage, // Placeholder image
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: Styles.subtitle16Bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(color: Color(0xFFCFD9E9), thickness: 1),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Chats')
                    .doc('${widget.providerId}_${widget.userId}')
                    .collection('messages')
                    .orderBy('timestamp')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final data =
                          messages[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: _buildChatMessage(
                          isMe: !(data['isUser'] ?? false),
                          message: data['text'] ?? '',
                          userImage: widget.userImage,
                          providerImage: widget.providerImage,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
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
                              hintText: 'Type here ',
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
                      borderRadius:
                          BorderRadius.circular(screenWidth * 0.123 / 2),
                    ),
                    child: const Center(
                      child: Icon(Icons.send, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessage({
    required bool isMe,
    required String message,
    required String userImage,
    required String providerImage,
  }) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
                bottomRight: isMe ? Radius.zero : const Radius.circular(12),
              ),
              border: Border.all(
                width: 0.2,
                color: !isMe ? kBlack : kWhite,
              ),
              color: isMe ? kExtraLite : kWhite,
            ),
            child: Text(
              message,
              style: Styles.text14Medium,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ],
    );
  }
}
