import 'package:flutter/material.dart';
import 'pages/portfolio_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sujeet Kumar — Flutter & Mobile Engineer',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppTheme.bgColor,
        colorScheme: const ColorScheme.dark(
          primary: AppTheme.primaryColor,
          secondary: AppTheme.secondaryColor,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Courier New',
            fontSize: 56,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.5,
            height: 1.1,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Courier New',
            fontSize: 40,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.0,
            height: 1.2,
          ),
          titleMedium: TextStyle(
            fontSize: 13,
            letterSpacing: 3,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(fontSize: 15, height: 1.7),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

/// Central theme constants used across the whole app.
class AppTheme {
  static const primaryColor   = Color(0xFF6C63FF);
  static const secondaryColor = Color(0xFF00D4AA);
  static const accentColor    = Color(0xFFFF6B6B);
  static const bgColor        = Color(0xFF0A0A0F);
  static const cardColor      = Color(0xFF1A1A2E);
  static const surfaceColor   = Color(0xFF12121C);

  static const double mobileBreakpoint  = 600.0;
  static const double tabletBreakpoint  = 900.0;
  static const double desktopBreakpoint = 1200.0;

  static const double xs   = 8.0;
  static const double sm   = 16.0;
  static const double md   = 24.0;
  static const double lg   = 32.0;
  static const double xl   = 48.0;
  static const double xxl  = 64.0;
  static const double xxxl = 100.0;
}
