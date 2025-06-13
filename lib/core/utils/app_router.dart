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

import '../../features/handle_product/presentation/view/screens/add_product_f.dart';
import '../../features/handle_product/presentation/view/screens/add_product_hc.dart';
import '../../features/handle_product/presentation/view/screens/add_product_m.dart';
import '../../features/handle_product/presentation/view/screens/add_product_r.dart';
import '../../features/handle_product/presentation/view/screens/update_product_f.dart';
import '../../features/handle_product/presentation/view/screens/update_product_hc.dart';
import '../../features/handle_product/presentation/view/screens/update_product_m.dart';
import '../../features/handle_product/presentation/view/screens/update_product_r.dart';

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
  static const String kAddProductF = '/addproductF';
  static const String kAddProductM = '/addproductM';
  static const String kAddProductHC = '/addproductHC';
  static const String kAddProductR = '/addproductR';
  static const String kUpdateProductF = '/updateproductF';
  static const String kUpdateProductM = '/updateproductM';
  static const String kUpdateProductHC = '/updateproductHC';
  static const String kUpdateProductR = '/updateproductR';
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
        GoRoute(
      path: kAddProductF,
      builder: (context, state) =>  AddProductF(),
    ),
    GoRoute(
      path: kAddProductM,
      builder: (context, state) => const AddProductM(),
    ),
    GoRoute(
      path: kAddProductHC,
      builder: (context, state) => const AddProductHC(),
    ),
    GoRoute(
      path: kAddProductR,
      builder: (context, state) => const AddProductR(),
    ),
    GoRoute(
      path: kUpdateProductF,
      builder: (context, state) =>  UpdateProductF(),
    ),
    GoRoute(
      path: kUpdateProductM,
      builder: (context, state) =>  UpdateProductM(),
    ),
    GoRoute(
      path: kUpdateProductHC,
      builder: (context, state) =>  UpdateProductHc(),
    ),
    GoRoute(
      path: kUpdateProductR,
      builder: (context, state) =>  UpdateProductR(),
      )
  ]);
}
