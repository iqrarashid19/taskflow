import 'package:flutter/material.dart';

import '../widgets/home_header.dart';
import '../widgets/create_task_card.dart';
import '../widgets/summary_section.dart';
import '../widgets/activity_chart.dart';
import '../widgets/home_tasks_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onAddTask;
  final VoidCallback onViewAllTasks;

  const HomeScreen({
    super.key,
    required this.onAddTask,
    required this.onViewAllTasks,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final compact = screenHeight < 720;

    final horizontalPadding = compact ? 18.0 : 22.0;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          compact ? 8 : 18,
          horizontalPadding,
          4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              compact: compact,
            ),

            SizedBox(
              height: compact ? 6 : 16,
            ),

            CreateTaskCard(
              compact: compact,
              onTap: onAddTask,
            ),

            SizedBox(
              height: compact ? 8 : 18,
            ),

            SummarySection(
              compact: compact,
            ),

            SizedBox(
              height: compact ? 3 : 6,
            ),

            Expanded(
              child: Column(
                children: [
                  HomeTasksSection(
                    onViewAll: onViewAllTasks,
                  ),

                  SizedBox(
                    height: compact ? 1 : 4,
                  ),

                  Expanded(
                    child: ActivityChart(
                      compact: compact,
                    ),
                  ),

                  SizedBox(
                    height: compact ? 18 : 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}