import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/notification_icon.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/toggel_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(
      {super.key, required this.providerId, required this.isOnline});
  final String providerId;
  final bool isOnline;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          SlidingToggleSwitch(
            providerId: providerId,
            isOnline: isOnline,
            trackWidth: size.width / 3,
          ),
          const Spacer(flex: 1),
          const Center(
            child: Text(
              'Ta7t Bety',
              style: Styles.projectNameStyle,
            ),
          ),
          const Spacer(flex: 2),

          // Notification Icon
          InkWell(
            onTap: () {
              context.go(AppRouter.kNotification);
            },
            child: const NotificationIcon(),
          ),
        ],
      ),
    );
  }
}
