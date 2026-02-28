import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../cubit/theme_cubit.dart';
import 'widgets/password_login_form.dart';
import 'widgets/password_login_header.dart';
import 'widgets/welcome_back_card.dart';

@RoutePage()
class PasswordLoginPage extends StatelessWidget {
  final String email;

  const PasswordLoginPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Ensuring the Primary Color (Dark Blue) is used for the background header
    final backgroundColor = context.colors.primary;

    return Scaffold(
      backgroundColor: Colors.white, // Main body is white/greyish
      body: Stack(
        children: [
          // Blue Header Background
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const PasswordLoginHeader(),
                const SizedBox(height: 20),

                // Welcome Back Card (Overlapping logic)
                WelcomeBackCard(email: email),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: const PasswordLoginForm(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
