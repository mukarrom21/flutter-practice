import 'package:flutter/material.dart';
import 'package:practice_with_ostad/ui/screens/add_new_task.dart';
import 'package:practice_with_ostad/ui/screens/cancelled_task_screen.dart';
import 'package:practice_with_ostad/ui/screens/completed_task_screen.dart';
import 'package:practice_with_ostad/ui/screens/new_task_screen.dart';
import 'package:practice_with_ostad/ui/screens/progress_task_screen.dart';
import 'package:practice_with_ostad/ui/utils/app_colors.dart';

import 'app_bar_header.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
    const ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHeader(),
      bottomNavigationBar: _buildNavigationBar(),
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedFAB(),
        child: const Icon(Icons.add),
      ),
    );
  }

  NavigationBar _buildNavigationBar() {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.new_releases_outlined), label: 'New'),
        NavigationDestination(
            icon: Icon(Icons.check_circle_outline), label: 'Completed'),
        NavigationDestination(
            icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
        NavigationDestination(
            icon: Icon(Icons.incomplete_circle_outlined), label: 'Progress'),
      ],
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  _onPressedFAB() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddNewTask()));
  } // _buildNavigationBar
  /// ->
} // This is last curly brace
