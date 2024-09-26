import 'package:flutter/material.dart';
import 'package:practice_with_ostad/screens/home_screen.dart';
import 'package:practice_with_ostad/screens/sticky_header_column_data_table.dart';

class ComponentsApp extends StatelessWidget {
  const ComponentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
