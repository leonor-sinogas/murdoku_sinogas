import 'package:flutter_test/flutter_test.dart';
import 'package:murdoku/main.dart';

void main() {
  testWidgets('home screen shows the first ten case files', (tester) async {
    await tester.pumpWidget(const MurdokuApp());

    expect(find.text('Think like a detective.'), findsOneWidget);
    expect(find.text('CASE 01'), findsOneWidget);
    expect(find.text('CASE 10'), findsOneWidget);
    expect(find.text('Start case 01'), findsOneWidget);
  });

  testWidgets('starting a case opens the playable grid', (tester) async {
    await tester.pumpWidget(const MurdokuApp());
    await tester.tap(find.text('Start case 01'));
    await tester.pumpAndSettle();

    expect(find.text('The All-Day Conference'), findsOneWidget);
    expect(find.text('SUSPECTS'), findsOneWidget);
    expect(find.text('Andre'), findsOneWidget);
    expect(find.text('CHECK SOLUTION'), findsOneWidget);
  });
}
