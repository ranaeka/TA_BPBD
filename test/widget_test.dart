import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bpbd/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// void main() {
//   testWidgets('app should work', (tester) async {
//     // Build an App with a Text Widget that displays the letter 'H'
//     await tester.pumpWidget(MaterialApp(
//       home: Scaffold(
//         body: Text('H'),
//       ),
//     ));

//     // Find a Widget that displays the letter 'H'
//     expect(find.text('H'), findsOneWidget);
//   });
// }
