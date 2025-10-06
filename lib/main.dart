import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pingora/features/auth/data/repo/auth_repo.dart';
import 'package:pingora/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:pingora/features/chat_room/data/repo/chat_room_repo.dart';
import 'package:pingora/features/chat_room/presentation/view_model/chat_room_cubit.dart';
import 'package:pingora/features/chat_rooms/data/repo/chat_rooms_repo.dart';
import 'package:pingora/features/chat_rooms/presentation/view_model/chat_rooms_cubit.dart';
import 'package:pingora/features/profile/data/repo/profile_repo.dart';
import 'package:pingora/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:pingora/features/splash/presentation/view/splash_view.dart';
import 'core/utils/router/router_helper.dart';
import 'core/utils/services/local_services/cache_helper.dart';
import 'core/utils/services/remote_services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/shared/shared_cubits/theme_cubit/theme_cubit.dart';
import 'core/shared/theme/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();
  setup();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("ar"), Locale("en")],
      saveLocale: true,
      path: 'assets/translations',
      startLocale: const Locale("en"),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(getIt<AuthRepo>()),
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(getIt<ProfileRepo>()),
            ),
            BlocProvider<ChatRoomCubit>(
              create: (context) => ChatRoomCubit(getIt<ChatRoomRepo>()),
            ),
            BlocProvider<ChatRoomsCubit>(
              create: (context) => ChatRoomsCubit(getIt<ChatRoomsRepo>()),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                title: 'Pingora',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme(context),
                darkTheme: AppTheme.darkTheme(context),
                themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: SplashView(),
              );
            },
          ),
        );
      },
    );
  }
}
