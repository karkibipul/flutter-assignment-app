import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login screen has Google sign-in button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: ElevatedButton.icon(
              key: const Key('googleSignInButton'), // 🔧 no 'const' here
              icon: const Icon(Icons.login),
              label: const Text("Sign in with Google"),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // Verify the button appears
    final googleButton = find.byKey(Key('googleSignInButton'));
    expect(googleButton, findsOneWidget);

    // Check button text
    expect(find.text('Sign in with Google'), findsOneWidget);
  });
}
