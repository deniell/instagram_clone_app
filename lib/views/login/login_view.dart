import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/views/constants/app_colors.dart';
import 'package:instagram_clone_app/views/constants/strings.dart';
import 'package:instagram_clone_app/views/login/divider_with_margins.dart';
import 'package:instagram_clone_app/views/login/facebook_button.dart';
import 'package:instagram_clone_app/views/login/google_button.dart';
import 'package:instagram_clone_app/views/login/login_view_signup_links.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.appName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.welcomeToAppName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                ),
                const DividerWithMargins(),
                Text(
                  Strings.logIntoYourAccount,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(height: 1.5),
                ),
                const Gap(20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor,
                  ),
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithFacebook,
                  child: const FacebookButton(),
                ),
                const Gap(20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor,
                  ),
                  onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                  child: const GoogleButton(),
                ),
                const DividerWithMargins(),
                const LoginViewSignupLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
