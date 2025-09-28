import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/shared/shared_cubits/theme_cubit/theme_cubit.dart';
import '../../core/shared/theme/app_theme.dart';

class ThemeExamplePage extends StatelessWidget {
  const ThemeExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Example', style: TextStyle(color: Colors.white)),
        backgroundColor: context.primaryColor,
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                icon: Icon(
                  state.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white,
                ),
                tooltip: state.isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
              );
            },
          ),
        ],
      ),
      backgroundColor: context.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Welcome to Your App! 🎉',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This page demonstrates the complete theme system with dark and light mode support.',
              style: TextStyle(fontSize: 16, color: context.secondaryTextColor),
            ),
            const SizedBox(height: 32),

            // Theme Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: context.greyColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: context.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              state.isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: context.primaryColor,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Theme',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: context.primaryTextColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.isDarkMode
                                      ? 'Dark Mode Active'
                                      : 'Light Mode Active',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context.subtitleColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: state.isDarkMode,
                            onChanged: (value) {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                            activeColor: context.primaryColor,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Color Showcase Section
            Text(
              'Color Palette',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _ColorCard(
                    color: context.primaryColor,
                    label: 'Primary',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ColorCard(
                    color: context.secondaryColor,
                    label: 'Secondary',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ColorCard(
                    color: context.activeGreen,
                    label: 'Success',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ColorCard(color: context.red, label: 'Error'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Input Field Example
            Text(
              'Input Fields',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              style: TextStyle(color: context.primaryTextColor),
              decoration: InputDecoration(
                labelText: 'Your Name',
                labelStyle: TextStyle(color: context.secondaryTextColor),
                hintText: 'Enter your name here',
                hintStyle: TextStyle(color: context.inputHintColor),
                filled: true,
                fillColor: context.inputBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              style: TextStyle(color: context.primaryTextColor),
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: context.secondaryTextColor),
                hintText: 'your.email@example.com',
                hintStyle: TextStyle(color: context.inputHintColor),
                filled: true,
                fillColor: context.inputBackgroundColor,
                prefixIcon: Icon(Icons.email, color: context.greyColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Buttons Section
            Text(
              'Buttons',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Primary button pressed!'),
                          backgroundColor: context.primaryColor,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Primary'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Success button pressed!'),
                          backgroundColor: context.activeGreen,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.activeGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Success'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Outlined button pressed!'),
                          backgroundColor: context.greyColor,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.primaryTextColor,
                      side: BorderSide(color: context.borderColor),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Outlined'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error button pressed!'),
                          backgroundColor: context.red,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Error'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Feature Cards
            Text(
              'Feature Cards',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 16),

            _FeatureCard(
              icon: Icons.auto_awesome,
              title: 'Automatic Theme Switching',
              description:
                  'Switch between light and dark modes instantly. Your preference is saved automatically.',
              color: context.primaryColor,
            ),
            const SizedBox(height: 12),

            _FeatureCard(
              icon: Icons.palette,
              title: 'Consistent Colors',
              description:
                  'All colors adapt automatically to your theme. No need to worry about contrast or readability.',
              color: context.activeGreen,
            ),
            const SizedBox(height: 12),

            _FeatureCard(
              icon: Icons.code,
              title: 'Developer Friendly',
              description:
                  'Simple API with context extensions. Just use context.primaryTextColor instead of hardcoded colors.',
              color: context.secondaryColor,
            ),
            const SizedBox(height: 32),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    '🎨 Theme System',
                    style: TextStyle(
                      fontSize: 24,
                      color: context.primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toggle the theme using the button in the app bar',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.subtitleColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorCard({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: context.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: context.greyColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
