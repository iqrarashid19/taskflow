import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'services/task_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TaskStorage.loadTasks();

  runApp(
    const TaskFlowApp(),
  );
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}