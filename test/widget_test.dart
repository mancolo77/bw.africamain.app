import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_/screens/main_navigation_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('MainNavigationScreen has 3 tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainNavigationScreen(),
      ),
    );
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Matches'), findsOneWidget);
    expect(find.text('My Progress'), findsOneWidget);
  });
}
