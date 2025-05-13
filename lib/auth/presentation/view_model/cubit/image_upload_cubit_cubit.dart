// image_upload_cubit.dart
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_upload_cubit_state.dart';

class ImageUploadCubit extends Cubit<ImageUploadState> {
  ImageUploadCubit() : super(ImageUploadInitial());

  File? frontImage;
  File? backImage;
  final picker = ImagePicker();

  Future<void> pickImage(bool isFront) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        if (isFront) {
          frontImage = File(pickedFile.path);
        } else {
          backImage = File(pickedFile.path);
        }
        emit(ImagePickedSuccess(frontImage, backImage));
      }
    } catch (e) {
      emit(ImageUploadError("Failed to pick image"));
    }
  }

  Future<void> uploadImage(File imageFile) async {
    emit((ImageUploading()));
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
      });

      final response = await Dio().post(
        'https://example.com/upload',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ImageUploadedSuccess(response.data['url']));
      } else {
        emit(ImageUploadError('Failed to upload image'));
      }
    } catch (e) {
      emit(ImageUploadError('An error occurred: $e'));
    }
  }
}
