import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety_provider/core/widgets/custom_widget_loading.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/home_app_bar.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_prof_image.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_profile_info.dart';

class UpperWidgetLoading extends StatelessWidget {
  const UpperWidgetLoading({
    super.key,
    this.isOnline = true,
  });
  final bool isOnline;
  @override
  Widget build(BuildContext context) {
    final double avHeight = MediaQuery.of(context).size.height;
    final double avWidth = MediaQuery.of(context).size.width;
    final double cHeight = avHeight * 0.36;
    final double cWidth = avWidth;
    final double coverHeight = avHeight * 0.24;
    final double imageWidth = 0.25 * avWidth;
    final double imageHeight = 0.122 * avHeight;
    return CustomWidgetLoading(
      child: Column(
        children: [
          HomeAppBar(
            providerId: 'providerId',
            isOnline: isOnline,
            isActive: true, // Assuming the provider is active
          ),
          SizedBox(
            width: cWidth,
            height: cHeight,
            child: Stack(
              children: [
                const CustomCushedImage(
                  image:
                      "https://s3-alpha-sig.figma.com/img/b741/297c/49ff74de02ee0013dd84741b92dde045?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=M1HyrlHyeCZ2W~U734U7WIad301pSaZWbfwpthUSnmJAvXmRTji~Sgd27RlFWj7Vx0yilKHATFGFobLZQgoMd0m428344Za0ix1c4Mc3dHuR9EVAJNwivO4uG5xL4D1BTRONCzIXtdNGMW~JCTmmwMflSdDOU-7SH1OMSPs6xu8Mn-UO5S8tzVOjTj~tk-QB5vxN1nZDsH8lfkxqxoBuw7JKim0Csto9v4K~HGK~Gv7gkVp~F71t-lDcZTg-x3MBGiFPZTmU4i3Tfm5Hr4o04HaapD-O45s2e~CXfTPOFj0CAx0FPs7Kydn6fSvkr3R-RwWlSLH8uL2nmGkMHUV3BQ__",
                  height: 0.25,
                  width: 1,
                ),
                Positioned(
                  top: coverHeight - (imageHeight / 2),
                  left: 12,
                  child: const ServProfImage(
                    image: '',
                  ),
                ),
                Positioned(
                  top: coverHeight + 10,
                  left: imageWidth + 20,
                  right: 12,
                  child: const ServProfileInfo(
                    name: "Provider Name",
                    address: " Address",
                    rate: 0.0,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 12,
                  child: InkWell(
                    onTap: () async {
                      // File? image = await showCustomChooseImageSource(context);
                      // if (image != null) {
                      //   String image64 = await AppFun.imageToBase64(image);
                      //   print("Image64: $image64");
                      //   BlocProvider.of<UpdateProviderCubit>(context)
                      //       .updateProvider({'imageCover': image64});
                      // }
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
          ),
        ],
      ),
    );
  }
}
