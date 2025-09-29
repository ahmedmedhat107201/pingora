import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pingora/features/auth/data/repo/auth_repo.dart';
import 'package:pingora/features/auth/data/repo/auth_repo_impl.dart';

import '../../../../features/splash/data/repo/splash_repo.dart';
import '../../../../features/splash/data/repo/splash_repo_impl.dart';
import 'api_service.dart';
//dependency Injection

final getIt = GetIt.instance;
BaseOptions options = BaseOptions(
  receiveDataWhenStatusError: true,
  connectTimeout: const Duration(seconds: 60), // 60 seconds
  receiveTimeout: const Duration(seconds: 60), // 60 seconds
);
void setup() {
  getIt.registerSingleton<ApiService>(ApiService(Dio(options)));

  //repos
  final api = getIt.get<ApiService>();

  getIt.registerSingleton<SplashRepo>(SplashRepoImpl(api));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(api));
}
