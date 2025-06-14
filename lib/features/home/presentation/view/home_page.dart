import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:taht_bety_provider/constants.dart';

import 'package:taht_bety_provider/features/home/presentation/view/chats.dart';
import 'package:taht_bety_provider/features/payment/presentation/view/dashboard_screen.dart';
import 'package:taht_bety_provider/features/home/presentation/view/service_profile.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/custtom_page_Icon.dart';
import 'package:taht_bety_provider/features/orders/presentation/view/order_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;
  List<Widget> pages = [
    const DashboardScreen(),
    const ServiceProfile(),
    const OrdersScreen(),
    const Chats(),
  ];
  List<bool> iconPressed = [
    false,
    true,
    false,
    false,
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[pageIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: kLightBlue,
        buttonBackgroundColor: kPrimaryColor,
        onTap: (value) {
          setState(() {
            pageIndex = value;
            for (int i = 0; i < iconPressed.length; i++) {
              iconPressed[i] = (i == value);
            }
          });
        },
        index: pageIndex,
        items: [
          CusttomPageIcon(
            icon: Icons.dashboard_outlined,
            isPressed: iconPressed[0],
          ),
          CusttomPageIcon(
            icon: Icons.home_outlined,
            isPressed: iconPressed[1],
          ),
          CusttomPageIcon(
            icon: Icons.document_scanner_outlined,
            isPressed: iconPressed[2],
          ),
          CusttomPageIcon(
            icon: Icons.chat_outlined,
            isPressed: iconPressed[3],
          ),
        ],
      ),
    );
  }
}
