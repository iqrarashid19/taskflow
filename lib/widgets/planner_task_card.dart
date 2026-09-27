import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../data/planner_data.dart';

class PlannerTaskCard extends StatelessWidget {
  final PlannerTask task;

  const PlannerTaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 4,
            decoration: BoxDecoration(
              color: _getColor(),
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkGreen,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  task.category,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          Text(
            task.time,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (task.category) {
      case 'Personal':
        return AppTheme.softPink;
      case 'Learning':
        return AppTheme.softYellow;
      default:
        return AppTheme.primaryGreen;
    }
  }
}