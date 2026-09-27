class PlannerTask {
   String title;
   String time;
  final String category;
  final int date;

  PlannerTask({
    required this.title,
    required this.time,
    required this.category,
    required this.date,
  });
}

final List<PlannerTask> plannerTasks = [
  PlannerTask(
    title: 'Morning Workout',
    time: '08:00 AM',
    category: 'Personal',
    date: 20,
  ),
  PlannerTask(
    title: 'Finish Flutter UI',
    time: '10:00 AM',
    category: 'Work',
    date: 20,
  ),
  PlannerTask(
    title: 'Read Flutter Chapter',
    time: '02:00 PM',
    category: 'Learning',
    date: 20,
  ),
  PlannerTask(
    title: 'Update Portfolio',
    time: '05:00 PM',
    category: 'Work',
    date: 21,
  ),
  PlannerTask(
    title: 'Client Project Review',
    time: '11:00 AM',
    category: 'Work',
    date: 22,
  ),
  PlannerTask(
    title: 'Gym Session',
    time: '06:00 PM',
    category: 'Personal',
    date: 23,
  ),
  PlannerTask(
    title: 'Flutter Practice',
    time: '07:00 PM',
    category: 'Learning',
    date: 24,
  ),
];