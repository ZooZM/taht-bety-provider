import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';
part 'updatelocation_state.dart';

class UpdatelocationCubit extends Cubit<UpdatelocationState> {
  UpdatelocationCubit() : super(UpdatelocationInitial());

  final Dio _dio = Dio();

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
    required String address,
    required bool isFavorite,
  }) async {
    emit(UpdatelocationLoading());
    try {
      final user = UserStorage.getUserData();
      final response = await ApiService(_dio).put(
        endPoint: user.providerId == 'unknown'
            ? 'users/update-me'
            : 'providers/${user.providerId}',
        data: {
          "locations": [
            {
              "coordinates": {
                "type": "Point",
                "coordinates": [longitude, latitude]
              },
              "address": address,
              "isFavorite": isFavorite,
            }
          ]
        },
        token: UserStorage.getUserData().token,
      );

      if (response['success']) {
        emit(UpdatelocationSuccess());
      } else {
        emit(UpdatelocationError("Failed to update location."));
      }
    } catch (e) {
      emit(UpdatelocationError("An error occurred while updating location."));
    }
  }
}
