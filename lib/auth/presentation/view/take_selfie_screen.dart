import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/back_button_circle.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/custom_title.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/main_button.dart';

class TakeSelfieScreen extends StatefulWidget {
  const TakeSelfieScreen({super.key});

  @override
  State<TakeSelfieScreen> createState() => _TakeSelfieScreenState();
}

class _TakeSelfieScreenState extends State<TakeSelfieScreen> {
  CameraController? _controller;
  bool _canFinish = false;
  bool _isLoading = true;
  String? _errorMessage;
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initCamera();
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

  Future<void> _captureAndSendImage() async {
    if (!_controller!.value.isInitialized || _controller!.value.isTakingPicture)
      return;

    try {
      final image = await _controller!.takePicture();
      _capturedImage = File(image.path);
      setState(() {
        _isLoading = true;
      });

      final success = await _sendImageToAPI(_capturedImage!);

      if (success) {
        setState(() {
          _canFinish = true;
          _errorMessage = null;
          _isLoading = false;
        });
      } else {
        setState(() {
          _canFinish = false;
          _errorMessage = 'Verification failed. Please try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to capture image: $e';
        _isLoading = false;
      });
    }
  }

  Future<bool> _sendImageToAPI(File imageFile) async {
    try {
      final uri = Uri.parse('https://your-api.com/verify-selfie');

      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const BackButtonCircle(),
            const CustomTitle(text: 'Take a selfie picture'),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_errorMessage!,
                    style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 10),
            _isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Image.asset('assets/icons/face.png'),
                  )
                : Expanded(
                    child:
                        _controller != null && _controller!.value.isInitialized
                            ? CameraPreview(_controller!)
                            : const Center(child: Text('Camera not available')),
                  ),
            const SizedBox(height: 10),
            MainButton(
              label: _isLoading ? 'reading Image...' : 'Capture Image',
              onPressed: _isLoading ? () {} : _captureAndSendImage,
            ),
            const SizedBox(height: 10),
            _canFinish
                ? MainButton(
                    label: 'Finish',
                    onPressed: _canFinish ? () {} : () {},
                  )
                : const SizedBox(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
