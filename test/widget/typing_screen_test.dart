import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monkeytype_clone/presentation/views/typing_screen.dart';
import 'package:provider/provider.dart';
import 'package:monkeytype_clone/presentation/viewmodels/typing_viewmodel.dart';
import 'package:monkeytype_clone/presentation/widgets/my_app_bar.dart';

void main() {
  group('MyAppBarTitle Widget Test', () {
    testWidgets('MyAppBarTitle displays correct text', (WidgetTester tester) async {
      // Рендерим виджет
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MyAppBarTitle(),
          ),
        ),
      );

      // Проверяем что текст отображается
      expect(find.text('MonkeyType Clone'), findsOneWidget);
    });
  });
}