import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/presentation/view/VerifyCodeScreen.dart';
import 'package:taht_bety_provider/auth/presentation/view/create_provider_account.dart';
import 'package:taht_bety_provider/auth/presentation/view/finish_create_provider.dart';
import 'package:taht_bety_provider/auth/presentation/view/forget_password_screen.dart';
import 'package:taht_bety_provider/auth/presentation/view/sign_in_view.dart';
import 'package:taht_bety_provider/auth/presentation/view/signup.dart';
import 'package:taht_bety_provider/auth/presentation/view/splash_screen.dart';
import 'package:taht_bety_provider/auth/presentation/view/take_selfie_screen.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view/screens/update_product.dart';
import 'package:taht_bety_provider/features/home/presentation/view/home_page.dart';
import 'package:taht_bety_provider/features/maps/presentation/view/display_maps.dart';
import 'package:taht_bety_provider/features/payment/presentation/view/dashboard_screen.dart';
import 'package:taht_bety_provider/features/payment/presentation/view/payment_screen.dart';
import 'package:taht_bety_provider/features/payment/presentation/view/widgets/person_details.dart';
import 'package:taht_bety_provider/features/product/presentation/view/category_details_screen.dart';

import '../../features/handle_product/presentation/view/screens/add_product_f.dart';

import '../../features/handle_product/presentation/view/screens/add_product_m.dart';
import '../../features/handle_product/presentation/view/screens/add_product_r.dart';
import '../../features/orders/presentation/view/order_details_screen.dart';
import '../../features/orders/presentation/view/order_screen.dart';

abstract class AppRouter {
  static const String kSignIn = '/signIn';
  static const String kSignUp = '/signUp';
  static const String kHomePage = '/homepage';
  static const String kMaps = '/maps';
  static const String kCategoryDetail = '/categorydetail';
  static const String kVerifyResetCodeScreen = "/verify-reset-code-screen";

  static const String kNotification = '/notification';
  static const String kTakeSelfie = '/takeselfie';
  static const String kVerifyCodeScreen = '/verifycodescreen';
  static const String kCreateProviderAccount = '/createprovideraccount';
  static const String kFinishCreateProvider = '/finishcreateprovider';
  static const String kAddProductF = '/addproductF';
  static const String kAddProductM = '/addproductM';

  static const String kAddProductR = '/addproductR';
  static const String kUpdateProduct = '/updateproduct';
  static const String kOrdersScreen = '/ordersScreen';
  static const String kOrderDetails = '/orderDetails';
  static const String kPersonDetails = '/person-details';
  static const String kPaymentScreen = '/payment-screen';
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: kSignIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: kSignUp,
      builder: (context, state) => const Signup(),
    ),
    GoRoute(
      path: kVerifyResetCodeScreen,
      builder: (context, state) => const ForgetPasswordScreen(),
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
      builder: (context, state) => AddProductF(),
    ),
    GoRoute(
      path: kAddProductM,
      builder: (context, state) => const AddProductM(),
    ),
    GoRoute(
      path: kAddProductR,
      builder: (context, state) => const AddProductR(),
    ),
    GoRoute(
      path: kUpdateProduct,
      builder: (context, state) => UpdateProduct(),
    ),
    GoRoute(
      path: kOrdersScreen,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: kOrderDetails,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return OrderDetailsScreen(
          order: extra['order'],
        );
      },
    ),
    GoRoute(
      path: kPersonDetails,
      builder: (context, state) => const PersonDetailsScreen(),
    ),
    GoRoute(
      path: kPaymentScreen,
      builder: (context, state) => const DashboardScreen(),
    ),
  ]);
}
