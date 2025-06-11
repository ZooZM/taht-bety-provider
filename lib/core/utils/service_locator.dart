import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taht_bety_provider/auth/data/models/curuser.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/auth/data/repo/auth_repo_imp.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/cubit/createprovider_cubit.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';
import 'package:taht_bety_provider/features/home/data/repos/provider_profile_impl.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CurUserAdapter());

  UserStorage.init();

  getIt.registerSingleton<AuthRepoImp>(
    AuthRepoImp(
      ApiService(
        Dio(),
      ),
    ),
  );
  getIt.registerSingleton<ProviderProfileImpl>(
    ProviderProfileImpl(
      ApiService(
        Dio(),
      ),
    ),
  );
}
