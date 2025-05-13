part of 'image_upload_cubit_cubit.dart';

abstract class ImageUploadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImageUploadInitial extends ImageUploadState {}

class ImagePickedSuccess extends ImageUploadState {
  final File? front;
  final File? back;
  ImagePickedSuccess(this.front, this.back);

  @override
  List<Object?> get props => [front, back];
}

class ImageUploading extends ImageUploadState {}

class ImageUploadedSuccess extends ImageUploadState {
  final bool isFront;
  ImageUploadedSuccess(this.isFront);

  @override
  List<Object?> get props => [isFront];
}

class ImageUploadError extends ImageUploadState {
  final String msg;
  ImageUploadError(this.msg);

  @override
  List<Object?> get props => [msg];
}
