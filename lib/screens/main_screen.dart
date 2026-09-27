import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/add_task_sheet.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'planner_screen.dart';
import 'profile_screen.dart';
import 'tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int _refreshKey = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openAddTask() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AddTaskSheet(
        onTaskAdded: () {
          setState(() {
            _refreshKey++;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        key: ValueKey('home_$_refreshKey'),
        onAddTask: _openAddTask,
        onViewAllTasks: () {
          _onItemTapped(1);
        },
      ),
      TasksScreen(key: ValueKey('tasks_$_refreshKey')),
      PlannerScreen(key: ValueKey('planner_$_refreshKey')),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: IndexedStack(index: _currentIndex, children: screens),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTask,
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
