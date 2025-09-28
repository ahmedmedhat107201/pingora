import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDarkMode: false)) {
    _loadTheme();
  }

  static const String _themeKey = 'isDarkMode';

  // Load theme from shared preferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      emit(ThemeState(isDarkMode: isDarkMode));
    } catch (e) {
      // If there's an error, default to light mode
      emit(const ThemeState(isDarkMode: false));
    }
  }

  // Toggle between light and dark mode
  Future<void> toggleTheme() async {
    try {
      final newThemeState = ThemeState(isDarkMode: !state.isDarkMode);
      emit(newThemeState);

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, newThemeState.isDarkMode);
    } catch (e) {
      // Handle error if needed
    }
  }

  // Set specific theme mode
  Future<void> setTheme(bool isDarkMode) async {
    try {
      emit(ThemeState(isDarkMode: isDarkMode));

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDarkMode);
    } catch (e) {
      // Handle error if needed
    }
  }

  // Check if current theme is dark
  bool get isDarkMode => state.isDarkMode;
}
