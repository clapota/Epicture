import 'package:epicture/views/widgets/loginDialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

MaterialApp _appWithAlertDialog(WidgetTester tester, LoginDialog dialog, { ThemeData theme }) {
  return MaterialApp(
      theme: theme,
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            return Center(
              child: RaisedButton(
                child: const Text('X'),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return dialog;
                    },
                  );
                },
              ),
            );
          }
        ),
      ),
  );
}

void main() {
  testWidgets('Login Dialog full test', (WidgetTester tester) async {
    await tester.pumpWidget(_appWithAlertDialog(tester, LoginDialog()));

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();



    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'test_user');
    await tester.enterText(find.byType(TextField).at(1), 'test_pass');

    await tester.pumpAndSettle();

    expect(find.text('test_user'), findsOneWidget);
    expect(find.text('test_pass'), findsOneWidget);
  });
}
