import 'cache_helper.dart';

class CacheKeysManger {
  static Future<void> saveAccessTokenToCache(String token) async =>
      await CacheHelper.saveData(key: 'access_token', value: token);

  static Future<void> saveRefreshTokenToCache(String token) async =>
      await CacheHelper.saveData(key: 'refresh_token', value: token);

  static String getAccessToken() =>
      CacheHelper.getData(key: 'access_token') ?? "";

  static String getRefreshtoken() =>
      CacheHelper.getData(key: 'refresh_token') ?? "";

  static String? getUserLanguageFromCache() =>
      CacheHelper.getData(key: 'language') ?? "ar";

  /// Save user selected language to cache
  static Future<void> saveUserLanguageToCache(String languageCode) async =>
      await CacheHelper.saveData(key: 'language', value: languageCode);

  /// Clear all authentication tokens - useful for logout or when tokens are invalid
  static Future<void> clearAuthTokens() async {
    await CacheHelper.saveData(key: 'access_token', value: '');
    await CacheHelper.saveData(key: 'refresh_token', value: '');
  }

  /// Check if user has valid tokens (both access and refresh must exist)
  static bool hasValidTokens() {
    final accessToken = getAccessToken();
    final refreshToken = getRefreshtoken();
    return accessToken.isNotEmpty && refreshToken.isNotEmpty;
  }

  //on boarding
  static void setOnBoarding(bool value) {
    CacheHelper.saveData(key: 'onBoarding', value: value);
  }

  static bool onBoardingStatus() =>
      CacheHelper.getData(key: 'onBoarding') ?? false;
}
