import 'package:flutter_test/flutter_test.dart';
import 'package:murdoku/main.dart';

void main() {
  testWidgets('home screen shows all thirty case files', (tester) async {
    await tester.pumpWidget(const MurdokuApp());

    expect(find.text('Think like a detective.'), findsOneWidget);
    expect(find.text('CASE 01'), findsOneWidget);
    expect(find.text('CASE 30'), findsOneWidget);
    expect(find.text('Start case 01'), findsOneWidget);
  });

  testWidgets('starting a case opens the playable grid', (tester) async {
    await tester.pumpWidget(const MurdokuApp());
    await tester.tap(find.text('Start case 01'));
    await tester.pumpAndSettle();

    expect(find.text('Vacation House'), findsOneWidget);
    expect(find.text('CHARACTERS'), findsOneWidget);
    expect(find.text('Arianna'), findsWidgets);
    expect(find.text('CHECK SOLUTION'), findsOneWidget);
  });
}
