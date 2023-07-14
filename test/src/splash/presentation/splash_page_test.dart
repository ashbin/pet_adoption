import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption/src/splash/presentation/splash_page.dart';

void main() {
  testWidgets('SplashScreen shows a loading indicator', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SplashPage()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
