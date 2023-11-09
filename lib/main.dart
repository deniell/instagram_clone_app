import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/state/auth/providers/is_logged_in_provider.dart';
import 'firebase_options.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: InstagramCloneApp(),
    ),
  );
}

class InstagramCloneApp extends StatelessWidget {
  const InstagramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram clone',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

// when you are already logged in
class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () async {
              await ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text('Logout'),
          );
        },
      ),
    );
  }
}

// for login
class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final result = await const Authenticator().loginWithGoogle();
              result.log();
            },
            child: const Text(
              'Sign In with Google',
            ),
          ),
          TextButton(
            onPressed: () async {
              final result = await const Authenticator().loginWithFacebook();
              result.log();
            },
            child: const Text(
              'Sign In with Facebook',
            ),
          ),
        ],
      ),
    );
  }
}
