import 'package:flutter/material.dart';

import '../../../chat/presentation/view/list_chats_screen.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListChatsScreen()
    );
  }
}
