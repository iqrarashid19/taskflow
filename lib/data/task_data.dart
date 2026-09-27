
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TaskData {
  String title;
  String time;
  String priority;
  final IconData icon;
  final Color color;
  bool completed;
  String category;
  int date;

  TaskData({
    required this.title,
    required this.time,
    required this.priority,
    required this.icon,
    required this.color,
    required this.completed,
    required this.category,
    this.date = 20,
  });
}

final List<TaskData> taskList = [
  TaskData(
    title: 'Finish Flutter UI',
    time: '5:00 PM',
    priority: 'High',
    icon: Icons.code_rounded,
    color: AppTheme.softGreen,
    completed: false,
    category: 'today',
    date: 20,
  ),
  TaskData(
    title: 'Read Flutter Chapter',
    time: '7:00 PM',
    priority: 'Medium',
    icon: Icons.menu_book_rounded,
    color: AppTheme.softYellow,
    completed: false,
    category: 'today',
    date: 20,
  ),
  TaskData(
    title: 'Update Portfolio',
    time: '10:00 AM',
    priority: 'Low',
    icon: Icons.work_outline_rounded,
    color: AppTheme.softBlue,
    completed: false,
    category: 'upcoming',
    date: 21,
  ),
  TaskData(
    title: 'Review App Design',
    time: '2:00 PM',
    priority: 'Medium',
    icon: Icons.design_services_outlined,
    color: AppTheme.softPink,
    completed: true,
    category: 'upcoming',
    date: 22,
  ),
];

