import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/presentation/view/VerifyCodeScreen.dart';
import 'package:taht_bety_provider/auth/presentation/view/create_provider_account.dart';
import 'package:taht_bety_provider/auth/presentation/view/sign_in_view.dart';
import 'package:taht_bety_provider/auth/presentation/view/signup.dart';
import 'package:taht_bety_provider/auth/presentation/view/take_selfie_screen.dart';
import 'package:taht_bety_provider/features/home/presentation/view/home_page.dart';

abstract class AppRouter {
  static const String kSignIn = '/signIn';
  static const String kSignUp = '/signUp';
  static const String kHomePage = '/homepage';
  static const String kNotification = '/notification';
  static const String kTakeSelfie = '/takeselfie';
  static const String kVerifyCodeScreen = '/verifycodescreen';
  static const String kCreateProviderAccount = '/createprovideraccount';
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
  ]);
}
