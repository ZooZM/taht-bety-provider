import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_profile_rate.dart';

class ServProfileInfo extends StatelessWidget {
  const ServProfileInfo({super.key, required this.name, required this.address});
  final String name;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 4),
        _buildLocationRow(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: Styles.subtitle18Bold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        const SizedBox(width: 12),
        const ServProfileRate(),
      ],
    );
  }

  /// Builds the row containing the location icon and address.
  Widget _buildLocationRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.place_outlined,
          size: 24,
          color: ksecondryColor,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            address,
            style: Styles.text12Light.copyWith(color: ksecondryColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
