import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/location_service.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/custtom_button.dart';
import 'package:taht_bety_provider/features/maps/presentation/view/widgets/lower_widget_of_maps.dart';
import 'package:taht_bety_provider/features/maps/presentation/view/widgets/maps_app_bar.dart';
import 'package:taht_bety_provider/features/maps/presentation/view_model/cubit/updatelocation_cubit.dart';

class DisplayMaps extends StatefulWidget {
  const DisplayMaps({super.key});
  @override
  State<DisplayMaps> createState() => _DisplayMapsState();
}

class _DisplayMapsState extends State<DisplayMaps> {
  late CameraPosition initialCameraPoistion;
  late GoogleMapController mapController;
  late LocationService locationService;
  LatLng? currentLocation;
  LatLng? centerCoordinates;
  bool isloading = true;

  @override
  void initState() {
    initialCameraPoistion =
        const CameraPosition(target: LatLng(26.820553, 30.802498), zoom: 6);
    locationService = LocationService();
    super.initState();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UpdatelocationCubit(),
        child: BlocConsumer<UpdatelocationCubit, UpdatelocationState>(
          listener: (context, state) {
            if (state is UpdatelocationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Location Saved successfully!")),
              );
              mapController.dispose();
              context.pop();
            } else if (state is UpdatelocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    mapToolbarEnabled: false,
                    initialCameraPosition: initialCameraPoistion,
                    onMapCreated: (controller) {
                      mapController = controller;
                      updateCurrentLocation();
                    },
                    onCameraMove: (position) {
                      setState(() {
                        isloading = true;
                        centerCoordinates = position.target;
                      });
                    },
                    onCameraIdle: () {
                      setState(() {
                        isloading = false;
                      });
                      currentLocation = centerCoordinates;
                    },
                    markers: markers,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                  ),
                  const Center(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Icon(
                        Icons.location_pin,
                        size: 40,
                        color: ksecondryColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: LowerWidgetOfMaps(
                      isLoading: isloading,
                      onArrowPress: () async {
                        await updateCurrentLocation();
                      },
                      onButtonPress: isloading
                          ? () {}
                          : () async {
                              if (currentLocation != null) {
                                setState(() {
                                  isloading = true;
                                });
                                context
                                    .read<UpdatelocationCubit>()
                                    .updateLocation(
                                      latitude: currentLocation!.latitude,
                                      longitude: currentLocation!.longitude,
                                      address: "Delivery Address",
                                      isFavorite: true,
                                    );
                              }
                            },
                    ),
                  ),
                  MapsAppBar(
                    isLoading: isloading,
                    onPress: () {
                      context.go(AppRouter.kHomePage);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> updateCurrentLocation() async {
    try {
      isloading = true;
      setState(() {});
      var currentLocation = await locationService.getLocation();
      var curPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      CameraPosition updatedCameraPos = CameraPosition(
        target: curPosition,
        zoom: 18.0,
      );

      isloading = false;
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(updatedCameraPos));
    } on LocationEnabledException catch (e) {
      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.26,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Log Out",
                    style: Styles.subtitle18Bold,
                  ),
                  const Flex(
                    direction: Axis.vertical,
                  ),
                  Text(
                    "$e",
                    style: Styles.text16SemiBold,
                  ),
                  const Flex(
                    direction: Axis.vertical,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flex(direction: Axis.horizontal),
                        CusttomButton(
                          isborder: true,
                          color: kWhite,
                          function: () => Navigator.pop(context),
                          title: "Cancel",
                          titleColor: kBlack,
                        ),
                        const CusttomButton(
                          isborder: false,
                          color: kOrange,
                          title: "Log out",
                          titleColor: kWhite,
                        ),
                        const Flex(direction: Axis.horizontal),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } on LocationPremissionException catch (e) {
      print(e);
    }
  }
}
