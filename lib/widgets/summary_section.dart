import 'package:flutter/material.dart';

import '../data/task_data.dart';
import '../theme/app_theme.dart';
import 'summary_card.dart';

class SummarySection extends StatelessWidget {
  final bool compact;

  const SummarySection({
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

    final focus = totalTasks == 0
        ? 0
        : ((completedTasks / totalTasks) * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.darkGreen,
              ),
            ),
            const Spacer(),
            const Text(
              'This week',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),

        SizedBox(
          height: compact ? 8 : 11,
        ),

        SizedBox(
          height: compact ? 142 : 158,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 4,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: compact ? 66 : 74,
            ),
            itemBuilder: (context, index) {
              final cards = [
                SummaryCard(
                  title: 'Total Tasks',
                  value: '$totalTasks',
                  icon: Icons.checklist_rounded,
                  iconBackground: AppTheme.softGreen,
                ),
                SummaryCard(
                  title: 'Completed',
                  value: '$completedTasks',
                  icon: Icons.check_circle_outline_rounded,
                  iconBackground: AppTheme.softBlue,
                ),
                SummaryCard(
                  title: 'Pending',
                  value: '$pendingTasks',
                  icon: Icons.schedule_rounded,
                  iconBackground: AppTheme.softYellow,
                ),
                SummaryCard(
                  title: 'Focus',
                  value: '$focus%',
                  icon: Icons.bolt_rounded,
                  iconBackground: AppTheme.softPink,
                ),
              ];

              return cards[index];
            },
          ),
        ),
      ],
    );
  }
}