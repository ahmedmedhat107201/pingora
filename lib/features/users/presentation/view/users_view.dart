import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingora/core/shared/shared_widgets/custom_pingora_app_bar.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';
import 'package:pingora/core/utils/services/remote_services/service_locator.dart';
import 'package:pingora/features/users/data/repo/users_repo.dart';
import 'package:pingora/features/users/presentation/view/widgets/users_view_body.dart';
import 'package:pingora/features/users/presentation/view_model/users_cubit.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(getIt<UsersRepo>()),
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: CustomPingoraAppBar(hasBackButton: true),
        body: UsersViewBody(),
      ),
    );
  }
}
