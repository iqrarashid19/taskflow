import 'package:flutter/material.dart';

import '../data/task_data.dart';
import '../theme/app_theme.dart';

class HomeTasksSection extends StatelessWidget {
  final VoidCallback onViewAll;

  const HomeTasksSection({super.key, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final todayTasks = taskList
        .where((task) => task.category == 'today' && !task.completed)
        .take(2)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Today\'s Tasks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.darkGreen,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onViewAll,
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        if (todayTasks.isEmpty)
          _buildEmpty()
        else
          ...todayTasks.map((task) => _buildTask(task)),
      ],
    );
  }

  Widget _buildTask(TaskData task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: task.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(task.icon, size: 17, color: AppTheme.primaryGreen),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkGreen,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.softGreen,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              task.time,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return const Text(
      'No pending tasks today',
      style: TextStyle(fontSize: 10, color: AppTheme.secondaryText),
    );
  }
}
