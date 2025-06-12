import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety_provider/auth/data/repo/auth_repo_imp.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/authcubit/auth_cubit.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/cubit/createprovider_cubit.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/bloc_observer.dart';
import 'package:taht_bety_provider/core/utils/service_locator.dart';
import 'package:taht_bety_provider/features/home/data/repos/provider_profile_impl.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/fetch_provider_cubit.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/update_provider_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProviderCubit(
            getIt<ProviderProfileImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateProviderCubit(
            getIt<ProviderProfileImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            getIt<AuthRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => CreateproviderCubit(
            getIt<AuthRepoImp>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
