import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_fun.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety_provider/core/widgets/show_custom_choose_image_source.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/home_app_bar.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_prof_image.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_profile_info.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/upper_widget_loading.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/fetch_provider_cubit.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/update_provider_cubit.dart';

class ServUpperWidget extends StatefulWidget {
  const ServUpperWidget({super.key, required this.provider});

  final ProviderModel provider;

  @override
  State<ServUpperWidget> createState() => _ServUpperWidgetState();
}

class _ServUpperWidgetState extends State<ServUpperWidget> {
  late bool isOnline;
  @override
  void initState() {
    super.initState();
    isOnline = widget.provider.isOnline ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final double avHeight = MediaQuery.of(context).size.height;
    final double avWidth = MediaQuery.of(context).size.width;
    final double cHeight = avHeight * 0.36;
    final double cWidth = avWidth;
    final double coverHeight = avHeight * 0.24;
    final double imageWidth = 0.25 * avWidth;
    final double imageHeight = 0.122 * avHeight;

    return BlocConsumer<UpdateProviderCubit, UpdateProviderState>(
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
          return UpperWidgetLoading(
            isOnline: !widget.provider.isOnline!,
          );
        }
        return Column(
          children: [
            // رسالة التنبيه إذا لم يكن مفعل
            if (!(widget.provider.isActive ?? true))
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Your account is currently not activated, please contact the administration or wait for activation.",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            HomeAppBar(
              providerId: widget.provider.providerId!,
              isOnline: isOnline,
              isActive: (widget.provider.isActive ?? true),
            ),
            SizedBox(
              width: cWidth,
              height: cHeight + 5,
              child: Stack(
                children: [
                  CustomCushedImage(
                    image: widget.provider.coverPhoto ?? "",
                    height: 0.25,
                    width: 1,
                  ),
                  Positioned(
                    bottom: (imageHeight / 2) - 18,
                    left: 12,
                    child: ServProfImage(
                      image: widget.provider.photo ?? "",
                    ),
                  ),
                  Positioned(
                    top: coverHeight + 10,
                    left: imageWidth + 20,
                    right: 12,
                    child: ServProfileInfo(
                      name: widget.provider.name ?? "Provider Name",
                      address: widget.provider.locations?.isNotEmpty == true
                          ? widget.provider.locations![0].address ??
                              "No Address"
                          : "No Address",
                      rate: widget.provider.avgRating ?? 0.0,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 12,
                    child: InkWell(
                      onTap: () async {
                        File? image =
                            await showCustomChooseImageSource(context);
                        if (image != null) {
                          String image64 = await AppFun.imageToBase64(image);
                          print("Image64: $image64");
                          BlocProvider.of<UpdateProviderCubit>(context)
                              .updateProvider({'imageCover': image64});
                        }
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: ksecondryColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Change Photo",
                              style: Styles.text14Light,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
