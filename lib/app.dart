import 'package:flutter/material.dart';
import 'package:practice_with_ostad/ui/screens/splash_screen.dart';
import 'package:practice_with_ostad/ui/utils/app_colors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigationKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: AppColors.themeColor,
          inputDecorationTheme: _inputDecorationTheme(),
          elevatedButtonTheme: _elevatedButtonThemeData()),
      home: const SplashScreen(),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey),
      fillColor: Colors.white,
      filled: true,
      border: _inputBorder(),
      focusedBorder: _inputBorder(),
      enabledBorder: _inputBorder(),
      errorBorder: _inputBorder(),
      focusedErrorBorder: _inputBorder(),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
