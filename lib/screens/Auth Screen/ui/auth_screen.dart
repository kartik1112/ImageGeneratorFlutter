import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/widgets/auth_screen_login_button.dart';
import 'package:wallpaper_app/widgets/auth_screen_textfield.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Lottie.network(
            height: double.infinity,
            fit: BoxFit.fill,
            "https://lottie.host/65a8e4ff-8cb6-4ae7-ac3a-ef477b56cc7c/jc5tdVFVcC.json"),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  // height: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(120),
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(150)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      "Welcome"),
                ),
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(20, 70, 20, 40),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(80),
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withAlpha(150)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              child: Icon(
                                Icons.person_outline_rounded,
                                size: 70,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              height: 38,
                            ),
                            AuthScreenTextField(
                              controller: emailController,
                              subject: "Email",
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            AuthScreenTextField(
                              controller: passwordController,
                              subject: "Password",
                              isPass: true,
                            ),
                            const SizedBox(
                              height: 38,
                            ),
                            const AuthScreenLoginButton(
                              subject: "Login",
                              icon: Icon(Icons.arrow_circle_right),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const AuthScreenLoginButton(
                              subject: "Sign with Google",
                              icon: Icon(Ionicons.logo_google),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
