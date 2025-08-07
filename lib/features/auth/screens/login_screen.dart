import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/features/auth/services/auth_service.dart';
import '../../crud/screens/notes_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: ElevatedButton.icon(
          key: const Key('googleSignInButton'),
          icon: const Icon(Icons.login),
          label: const Text("Sign in with Google"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () async {
            final user = await authService.signInWithGoogle();
            if (user != null && context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const NotesScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}
