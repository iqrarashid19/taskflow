import 'package:flutter/material.dart';

import '../data/planner_data.dart';
import '../theme/app_theme.dart';
import '../widgets/planner_date_selector.dart';
import '../widgets/planner_task_card.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({
    super.key,
  });

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  int selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    final compact =
        MediaQuery.of(context).size.height < 720;

    final selectedDate = 20 + selectedDateIndex;

    final selectedTasks = plannerTasks
        .where(
          (task) => task.date == selectedDate,
        )
        .toList();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          compact ? 18 : 22,
          compact ? 12 : 18,
          compact ? 18 : 22,
          8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(compact),

            SizedBox(
              height: compact ? 16 : 20,
            ),

            PlannerDateSelector(
              selectedIndex: selectedDateIndex,
              onDateChanged: (index) {
                setState(() {
                  selectedDateIndex = index;
                });
              },
            ),

            SizedBox(
              height: compact ? 18 : 22,
            ),

            Row(
              children: [
                Text(
                  selectedDateIndex == 0
                      ? 'Today\'s Schedule'
                      : '${_getDayName(selectedDateIndex)}\'s Schedule',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkGreen,
                  ),
                ),
                const Spacer(),
                Text(
                  _getSelectedDate(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Expanded(
              child: selectedTasks.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: selectedTasks.length,
                      itemBuilder: (context, index) {
                        return PlannerTaskCard(
                          task: selectedTasks[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool compact) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Plan your day',
                style: TextStyle(
                  fontSize: compact ? 12 : 13,
                  color: AppTheme.secondaryText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Planner',
                style: TextStyle(
                  fontSize: compact ? 25 : 28,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkGreen,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppTheme.border,
            ),
          ),
          child: const Icon(
            Icons.calendar_today_outlined,
            color: AppTheme.darkGreen,
            size: 20,
          ),
        ),
      ],
    );
  }

  String _getDayName(int index) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];

    return days[index];
  }

  String _getSelectedDate() {
    const dates = [
      '20 Sep',
      '21 Sep',
      '22 Sep',
      '23 Sep',
      '24 Sep',
    ];

    return dates[selectedDateIndex];
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: AppTheme.softGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.event_available_rounded,
              color: AppTheme.primaryGreen,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'No tasks for this day',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.darkGreen,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Your schedule is clear.',
            style: TextStyle(
              fontSize: 10,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}