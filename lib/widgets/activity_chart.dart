import 'package:flutter/material.dart';

import '../data/task_data.dart';
import '../theme/app_theme.dart';

class ActivityChart extends StatelessWidget {
  final bool compact;

  const ActivityChart({
    super.key,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final totalTasks = taskList.length;

    final completedTasks = taskList
        .where((task) => task.completed)
        .length;

    final pendingTasks = totalTasks - completedTasks;

    final completedHeight = totalTasks == 0
        ? 0.0
        : (completedTasks / totalTasks);

    final pendingHeight = totalTasks == 0
        ? 0.0
        : (pendingTasks / totalTasks);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        compact ? 12 : 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.border,
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Activity',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkGreen,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.softGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'This week',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: compact ? 8 : 12,
          ),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(
                  label: 'Mon',
                  value: 0.45,
                  compact: compact,
                ),
                _buildBar(
                  label: 'Tue',
                  value: 0.70,
                  compact: compact,
                ),
                _buildBar(
                  label: 'Wed',
                  value: completedHeight,
                  compact: compact,
                ),
                _buildBar(
                  label: 'Thu',
                  value: 0.55,
                  compact: compact,
                ),
                _buildBar(
                  label: 'Fri',
                  value: pendingHeight,
                  compact: compact,
                ),
                _buildBar(
                  label: 'Sat',
                  value: 0.35,
                  compact: compact,
                ),
                _buildBar(
                  label: 'Sun',
                  value: 0.20,
                  compact: compact,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar({
    required String label,
    required double value,
    required bool compact,
  }) {
    final safeValue = value.clamp(0.08, 1.0);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: safeValue,
                  child: Container(
                    width: compact ? 12 : 15,
                    decoration: BoxDecoration(
                      color: AppTheme.softGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}