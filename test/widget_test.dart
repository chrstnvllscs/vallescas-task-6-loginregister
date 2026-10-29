import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vallescas_task6_login_register/main.dart';

void main() {
  testWidgets('VALLESCAS login screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VallescasApp());

    expect(find.text('VALLESCAS'), findsWidgets);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('Register new account and login flow', (WidgetTester tester) async {
    await tester.pumpWidget(const VallescasApp());

    // Scroll to Register link and tap it
    final registerLink = find.text('Register');
    await tester.ensureVisible(registerLink);
    await tester.tap(registerLink);
    await tester.pumpAndSettle();

    // Verify on Register Screen
    expect(find.text('Register'), findsWidgets);

    // Fill form
    await tester.enterText(find.byType(TextFormField).at(0), 'Carl Vallescas');
    await tester.enterText(find.byType(TextFormField).at(1), 'carl@vallescas.com');
    await tester.enterText(find.byType(TextFormField).at(2), 'secretPass1');
    await tester.enterText(find.byType(TextFormField).at(3), 'secretPass1');

    // Tap Sign Up
    final signUpButton = find.text('Sign Up');
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    // Should pop back to login screen with email filled
    expect(find.text('carl@vallescas.com'), findsOneWidget);

    // Enter password to login
    await tester.enterText(find.byType(TextFormField).at(1), 'secretPass1');
    final signInButton = find.text('Sign In');
    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    // Should be on home screen
    expect(find.text('Carl Vallescas'), findsWidgets);
    expect(find.text('carl@vallescas.com'), findsWidgets);
    expect(find.text('VALLESCAS'), findsWidgets);

    // Test logout
    await tester.tap(find.byTooltip('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Confirm Logout'), findsOneWidget);

    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    // Back to Login
    expect(find.text('Sign In'), findsOneWidget);
  });
}
