
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('TaskFlow app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('Zain'), findsOneWidget);
    expect(find.text('Today\'s Tasks'), findsOneWidget);
  });
}

