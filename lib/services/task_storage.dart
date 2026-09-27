import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/task_data.dart';
import '../data/planner_data.dart';
import '../theme/app_theme.dart';

class TaskStorage {
  static const String tasksKey =
      'taskflow_tasks';

  static const String plannerKey =
      'taskflow_planner';

  static const String profileNameKey =
      'taskflow_profile_name';

  static const String profileEmailKey =
      'taskflow_profile_email';

  static const String notificationsKey =
      'taskflow_notifications';

  // =========================
  // TASKS
  // =========================

  static Future<void> saveTasks() async {
    final preferences =
        await SharedPreferences.getInstance();

    // Save Tasks
    final tasks = taskList.map((task) {
      return {
        'title': task.title,
        'time': task.time,
        'priority': task.priority,
        'completed': task.completed,
        'category': task.category,
        'date': task.date,
      };
    }).toList();

    await preferences.setString(
      tasksKey,
      jsonEncode(tasks),
    );

    // Save Planner
    final planner = plannerTasks.map((task) {
      return {
        'title': task.title,
        'time': task.time,
        'category': task.category,
        'date': task.date,
      };
    }).toList();

    await preferences.setString(
      plannerKey,
      jsonEncode(planner),
    );
  }

  static Future<void> loadTasks() async {
    final preferences =
        await SharedPreferences.getInstance();

    await _loadTaskList(preferences);
    await _loadPlannerTasks(preferences);
  }

  static Future<void> _loadTaskList(
    SharedPreferences preferences,
  ) async {
    final savedData =
        preferences.getString(tasksKey);

    if (savedData == null ||
        savedData.isEmpty) {
      return;
    }

    try {
      final decoded =
          jsonDecode(savedData) as List;

      taskList.clear();

      for (final item in decoded) {
        taskList.add(
          TaskData(
            title: item['title'] ?? '',
            time: item['time'] ?? 'Anytime',
            priority:
                item['priority'] ?? 'Medium',
            icon: Icons.task_alt_rounded,
            color: _getColor(
              item['priority'] ?? 'Medium',
            ),
            completed:
                item['completed'] ?? false,
            category:
                item['category'] ?? 'today',
            date:
                (item['date'] as num?)
                    ?.toInt() ??
                20,
          ),
        );
      }
    } catch (_) {
      // Keep default tasks if saved data is invalid.
    }
  }

  static Future<void> _loadPlannerTasks(
    SharedPreferences preferences,
  ) async {
    final savedData =
        preferences.getString(plannerKey);

    if (savedData == null ||
        savedData.isEmpty) {
      return;
    }

    try {
      final decoded =
          jsonDecode(savedData) as List;

      plannerTasks.clear();

      for (final item in decoded) {
        plannerTasks.add(
          PlannerTask(
            title: item['title'] ?? '',
            time: item['time'] ?? 'Anytime',
            category:
                item['category'] ?? 'Work',
            date:
                (item['date'] as num?)
                    ?.toInt() ??
                20,
          ),
        );
      }
    } catch (_) {
      // Keep default planner tasks if saved data is invalid.
    }
  }

  // =========================
  // PROFILE
  // =========================

  static Future<String> getProfileName() async {
    final preferences =
        await SharedPreferences.getInstance();

    return preferences.getString(
          profileNameKey,
        ) ??
        'Iqra Rashid';
  }

  static Future<String> getProfileEmail() async {
    final preferences =
        await SharedPreferences.getInstance();

    return preferences.getString(
          profileEmailKey,
        ) ??
        '';
  }

  static Future<void> saveProfile({
    required String name,
    required String email,
  }) async {
    final preferences =
        await SharedPreferences.getInstance();

    await preferences.setString(
      profileNameKey,
      name,
    );

    await preferences.setString(
      profileEmailKey,
      email,
    );
  }

  // =========================
  // NOTIFICATIONS
  // =========================

  static Future<bool> getNotificationsEnabled() async {
    final preferences =
        await SharedPreferences.getInstance();

    return preferences.getBool(
          notificationsKey,
        ) ??
        true;
  }

  static Future<void> saveNotificationsEnabled(
    bool enabled,
  ) async {
    final preferences =
        await SharedPreferences.getInstance();

    await preferences.setBool(
      notificationsKey,
      enabled,
    );
  }

  // =========================
  // COLORS
  // =========================

  static Color _getColor(
    String priority,
  ) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppTheme.softPink;

      case 'medium':
        return AppTheme.softYellow;

      default:
        return AppTheme.softBlue;
    }
  }

  // =========================
  // CLEAR TASKS
  // =========================

  static Future<void> clearTasks() async {
    final preferences =
        await SharedPreferences.getInstance();

    await preferences.remove(tasksKey);
    await preferences.remove(plannerKey);
  }
}