import 'package:flutter/material.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';

import '../../../chat/presentation/view/list_chats_screen.dart';

class Chats extends StatelessWidget {
  Chats({super.key});

  final provider = UserStorage.getUserData();
  @override
  Widget build(BuildContext context) {
    if (provider.providerId == null) {
      return const Center(child: Text("Invalid provider"));
    }

    return ListChatsScreen(providerId: provider.userId);
  }
}
