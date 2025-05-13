import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/notification_icon.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/fetch_provider_cubit.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/service_profile_body_f.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/service_profile_body_m.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/service_profile_body_r.dart';

class ServiceProfile extends StatefulWidget {
  const ServiceProfile({super.key});

  @override
  State<ServiceProfile> createState() => _ServiceProfileState();
}

class _ServiceProfileState extends State<ServiceProfile> {
  Future<void> reloadPage(BuildContext context) async {
    await context.read<FetchProviderCubit>().fetchProvider();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    reloadPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => reloadPage(context),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ta7t Bety',
                      style: Styles.projectNameStyle,
                    ),
                    InkWell(
                      onTap: () {
                        context.go(AppRouter.kNotification);
                      },
                      child: const NotificationIcon(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<FetchProviderCubit, FetchProviderState>(
                  builder: (context, state) {
                    if (state is FetchProviderLoading) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    } else if (state is FetchProviderFailure) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Center(
                            child: Text(state.failureMssg),
                          ),
                        ],
                      );
                    } else if (state is FetchProviderSuccess) {
                      final providerType = state.provider.providerType;

                      if (providerType!.startsWith('M')) {
                        return ServiceProfileBodyM(provider: state.provider);
                      } else if (providerType.startsWith('R') ||
                          providerType.startsWith('HW')) {
                        return ServiceProfileBodyR(provider: state.provider);
                      } else if (providerType.startsWith('F')) {
                        return ServiceProfileBodyF(provider: state.provider);
                      } else if (providerType.startsWith('HC')) {
                        return ServiceProfileBodyR(provider: state.provider);
                      } else {
                        return const Center(
                          child: Text('Unknown provider type'),
                        );
                      }
                    } else {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          Center(
                            child: Text('Error'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
