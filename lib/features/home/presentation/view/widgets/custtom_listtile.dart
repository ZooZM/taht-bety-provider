import 'package:flutter/material.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    this.function,
  });
  final IconData icon;
  final String title;
  final void Function()? function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: Styles.subtitle16Bold,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
    );
  }
}
