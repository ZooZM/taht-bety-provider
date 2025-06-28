import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/toggel_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(
      {super.key,
      required this.providerId,
      required this.isOnline,
      required this.isActive});
  final String providerId;
  final bool isOnline;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Center(
            child: Text(
              'Ta7t Bety',
              style: Styles.projectNameStyle,
            ),
          ),

          // const Spacer(flex: 1),
          SlidingToggleSwitch(
            providerId: providerId,
            isOnline: isOnline,
            trackWidth: size.width / 3,
            isActive: isActive,
          ),
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: ksecondryColor,
              size: 30,
            ),
            onPressed: () async {
              await UserStorage.deleteUserData();
              context.go('/');
            },
          ),
          // const Spacer(flex: 1),

          // // Notification Icon
          // InkWell(
          //   onTap: () {
          //     context.go(AppRouter.kNotification);
          //   },
          //   child: const NotificationIcon(),
          // ),
        ],
      ),
    );
  }
}
