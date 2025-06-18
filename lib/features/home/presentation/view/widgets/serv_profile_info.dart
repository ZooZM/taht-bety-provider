import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/presentation/view/finish_create_provider.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_profile_rate.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/update_provider_cubit.dart';

class ServProfileInfo extends StatelessWidget {
  const ServProfileInfo(
      {super.key,
      required this.name,
      required this.address,
      required this.rate});
  final String name;
  final String address;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        _buildLocationRow(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
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
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController _nameController =
                      TextEditingController(text: name);
                  return AlertDialog(
                    title: const Text('Edit Name'),
                    content: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(_nameController.text);
                          BlocProvider.of<UpdateProviderCubit>(context)
                              .updateProviderName(_nameController.text);
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: ksecondryColor,
            )),
        ServProfileRate(
          rate: rate,
        ),
      ],
    );
  }

  /// Builds the row containing the location icon and address.
  Widget _buildLocationRow(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRouter.kMaps);
      },
      child: Row(
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
      ),
    );
  }
}
