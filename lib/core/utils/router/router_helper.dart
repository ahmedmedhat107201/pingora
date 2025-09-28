import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) => null;

class MagicRouter {
  static BuildContext? currentContext = navigatorKey.currentContext;

  static Future<dynamic> navigateTo(Widget page) =>
      navigatorKey.currentState!.push(_materialPageRoute(page));

  static Future<dynamic> navigateAndPopAll(Widget page) => navigatorKey
      .currentState!
      .pushAndRemoveUntil(_materialPageRoute(page), (_) => false);

  static Future<dynamic> navigateAndPopUntilFirstPage(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
        _materialPageRoute(page),
        (route) => route.isFirst,
      );

  static Future<dynamic> navigateAndPop(Widget page) =>
      navigatorKey.currentState!.pushReplacement(_materialPageRoute(page));

  static bool get canPop => navigatorKey.currentState!.canPop();

  static void pop() => navigatorKey.currentState!.pop();

  static Route<dynamic> _materialPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Clean, modern slide with gentle scale

        // Slide animation - smooth and noticeable
        final slideAnimation =
            Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        // Gentle scale for depth
        final scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );

        // Smooth fade
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
          ),
        );

        // Previous page gentle fade out
        final exitFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
          ),
        );

        return Stack(
          children: [
            // Exiting page - simple fade
            if (secondaryAnimation.value > 0)
              FadeTransition(
                opacity: exitFadeAnimation,
                child: Container(
                  color: Colors.black.withValues(
                    alpha: 0.1 * secondaryAnimation.value,
                  ),
                ),
              ),

            // Entering page - slide + scale + fade
            SlideTransition(
              position: slideAnimation,
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: FadeTransition(opacity: fadeAnimation, child: child),
              ),
            ),
          ],
        );
      },
    );
  }
}
