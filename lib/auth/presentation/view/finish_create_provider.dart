import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/main_button.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/createprovidercubit/createprovider_cubit.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class FinishCreateProvider extends StatefulWidget {
  const FinishCreateProvider({super.key});

  @override
  State<FinishCreateProvider> createState() => _FinishCreateProviderState();
}

class _FinishCreateProviderState extends State<FinishCreateProvider> {
  final TextEditingController addressController = TextEditingController();
  late ProviderCurUser? user;
  bool isLoading = false;
  @override
  void initState() {
    user = UserStorage.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final address = GoRouterState.of(context).extra as String?;
    if (address != null) {
      addressController.text = address;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<CreateproviderCubit, CreateproviderState>(
          listener: (context, state) {
            if (state is CreateproviderLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is CreateproviderFailure) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 5),
                ),
              );
            } else if (state is CreateproviderSuccess) {
              setState(() {
                isLoading = false;
              });
              context.go(AppRouter.kHomePage);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                padding: const EdgeInsets.all(8),
                style: IconButton.styleFrom(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.black26),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Ready For Create Provider Account?',
                  style: Styles.subtitle18Bold,
                ),
              ),
              const Spacer(),

              Center(
                child: Image.asset(
                  'assets/icons/finish.png',
                  height: 200,
                ),
              ),
              const Spacer(),

              MainButton(
                label: "Create",
                onPressed: () async {
                  await context
                      .read<CreateproviderCubit>()
                      .createProvider(true);
                },
                isLoading: isLoading,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
