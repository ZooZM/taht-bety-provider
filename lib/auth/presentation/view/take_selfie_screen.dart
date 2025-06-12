import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/back_button_circle.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/custom_title.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/main_button.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/cubit/createprovider_cubit.dart';
import 'package:taht_bety_provider/constants.dart';

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
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
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
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CreateproviderCubit, CreateproviderState>(
          listener: (context, state) {
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
                        child: Expanded(
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
                          if (_controller != null &&
                              _controller!.value.isInitialized) {
                            _controller!.takePicture().then((XFile file) {
                              if (file.path.isNotEmpty) {
                                context
                                    .read<CreateproviderCubit>()
                                    .createFaceID(
                                      File(file.path),
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
