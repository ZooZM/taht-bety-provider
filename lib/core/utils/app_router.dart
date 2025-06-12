import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/presentation/view/VerifyCodeScreen.dart';
import 'package:taht_bety_provider/auth/presentation/view/create_provider_account.dart';
import 'package:taht_bety_provider/auth/presentation/view/finish_create_provider.dart';
import 'package:taht_bety_provider/auth/presentation/view/sign_in_view.dart';
import 'package:taht_bety_provider/auth/presentation/view/signup.dart';
import 'package:taht_bety_provider/auth/presentation/view/take_selfie_screen.dart';
import 'package:taht_bety_provider/features/home/presentation/view/home_page.dart';
import 'package:taht_bety_provider/features/maps/presentation/view/display_maps.dart';
import 'package:taht_bety_provider/features/product/presentation/view/category_details_screen.dart';

abstract class AppRouter {
  static const String kSignIn = '/signIn';
  static const String kSignUp = '/signUp';
  static const String kHomePage = '/homepage';
  static const String kMaps = '/maps';
  static const String kCategoryDetail = '/categorydetail';

  static const String kNotification = '/notification';
  static const String kTakeSelfie = '/takeselfie';
  static const String kVerifyCodeScreen = '/verifycodescreen';
  static const String kCreateProviderAccount = '/createprovideraccount';
  static const String kFinishCreateProvider = '/finishcreateprovider';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: kSignUp,
      builder: (context, state) => const Signup(),
    ),
    GoRoute(
      path: kCategoryDetail,
      builder: (context, state) => const CategoryDetailsScreen(),
    ),
    GoRoute(
      path: kMaps,
      builder: (context, state) => const DisplayMaps(),
    ),
    GoRoute(
      path: kHomePage,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: kTakeSelfie,
      builder: (context, state) => const TakeSelfieScreen(),
    ),
    GoRoute(
      path: kVerifyCodeScreen,
      builder: (context, state) => const VerifyCodeScreen(),
    ),
    GoRoute(
      path: kCreateProviderAccount,
      builder: (context, state) => const CreateProviderAccount(),
    ),
    GoRoute(
      path: kFinishCreateProvider,
      builder: (context, state) => const FinishCreateProvider(),
    ),
  ]);
}
