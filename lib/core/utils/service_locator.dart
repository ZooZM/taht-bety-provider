import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/auth/data/repo/auth_repo_imp.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';
import 'package:taht_bety_provider/features/home/data/repos/provider_profile_impl.dart';
import 'package:taht_bety_provider/features/orders/data/repo/order_repo_impl.dart';
import 'package:taht_bety_provider/firebase_options.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  getIt.registerSingleton<OrderRepoImpl>(
    OrderRepoImpl(
      ApiService(
        Dio(),
      ),
    ),
  );
}
