import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/back_button_circle.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/custom_title.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/main_button.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/createprovidercubit/createprovider_cubit.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/update_provider_cubit.dart';

class TakeSelfieScreen extends StatefulWidget {
  const TakeSelfieScreen({super.key});

  @override
  State<TakeSelfieScreen> createState() => _TakeSelfieScreenState();
}

class _TakeSelfieScreenState extends State<TakeSelfieScreen> {
  CameraController? _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      _initCamera();
    } else {
      setState(() {
        _errorMessage = 'Camera permission denied';
      });
    }
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(frontCamera, ResolutionPreset.medium);
      await _controller!.initialize();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Camera error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final isSignUp = GoRouterState.of(context).extra as bool?;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<CreateproviderCubit, CreateproviderState>(
          listener: (context, state) {
            bool isSignUp0 = isSignUp ?? true;
            if (state is CreateFaceIdLoading) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
            } else if (state is CreateFaceIdSuccess) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'true';
              });

              if (isSignUp0) {
                context.push(AppRouter.kMaps);
              } else {
                final now = DateTime.now().toUtc();
                final isoString = now.toIso8601String();

                context
                    .read<UpdateProviderCubit>()
                    .updateProviderLastPhoto(isoString);
                context.go(AppRouter.kHomePage);
              }
            } else if (state is CreateFaceIdFailure) {
              setState(() {
                _isLoading = false;
                _errorMessage = state.message;
              });
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BackButtonCircle(),
                const CustomTitle(text: 'Take a selfie picture'),
                if (_errorMessage != null)
                  Center(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                _isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Image.asset('assets/icons/face.png'),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: screenHeight * 0.6,
                          child: _controller != null &&
                                  _controller!.value.isInitialized
                              ? Stack(
                                  children: [
                                    CameraPreview(
                                      _controller!,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          color: Colors.black54,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            'Align your face in the center',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      heightFactor: 1.2,
                                      child: Image.asset(
                                        'assets/icons/center_face.png',
                                        width: screenWidth * 0.7,
                                        height: screenHeight * 0.45,
                                        fit: BoxFit.fill,
                                        color: ksecondryColor.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: Text('Camera not available')),
                        ),
                      ),
                const SizedBox(height: 10),
                MainButton(
                  label: _isLoading ? 'reading Image...' : 'Capture Image',
                  onPressed: _isLoading
                      ? () {}
                      : () {
                          context.read<CreateproviderCubit>().createFaceID(
                                photo: File('file.path'),
                                isSignUp: isSignUp ?? true,
                              );
                          if (_controller != null &&
                              _controller!.value.isInitialized) {
                            _controller!.takePicture().then((XFile file) {
                              if (file.path.isNotEmpty) {
                                context
                                    .read<CreateproviderCubit>()
                                    .createFaceID(
                                      photo: File(file.path),
                                      isSignUp: isSignUp ?? true,
                                    );
                              }
                            }).catchError((e) {
                              setState(() {
                                _errorMessage = 'Error capturing image: $e';
                              });
                            });
                          } else {
                            setState(() {
                              _errorMessage = 'Camera not initialized';
                            });
                          }
                        },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
