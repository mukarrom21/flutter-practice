import 'package:flutter/material.dart';
import 'package:practice_with_ostad/water_tracker_app/home_screen.dart';

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          // backgroundColor: Colors.indigo,
        )
      ),
      home: const HomeScreen(
      ),
    );
  }
}
