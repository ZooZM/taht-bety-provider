import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_fun.dart';
import 'package:taht_bety_provider/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety_provider/core/widgets/show_custom_choose_image_source.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/fetch_provider_cubit.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/update_provider_cubit.dart';

class ServProfImage extends StatelessWidget {
  const ServProfImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<UpdateProviderCubit, UpdateProviderState>(
          listener: (context, state) {
            if (state is UpdateProviderFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failureMssg)),
              );
            } else if (state is UpdateProviderSuccess) {
              context.read<ProviderCubit>().fetchProvider();
            }
          },
          builder: (context, state) {
            if (state is UpdateProviderLoading) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const CustomCushedImage(
                  image: '',
                  height: 0.122,
                  width: 0.25,
                ),
              );
            }
            return CustomCushedImage(
              image: image,
              height: 0.122,
              width: 0.25,
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () async {
              File? image = await showCustomChooseImageSource(context);
              if (image != null) {
                String image64 = await AppFun.imageToBase64(image);

                BlocProvider.of<UpdateProviderCubit>(context)
                    .updateProvider(image64);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: ksecondryColor, width: 1),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: ksecondryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
