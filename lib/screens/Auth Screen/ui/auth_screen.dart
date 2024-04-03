import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/screens/Auth%20Screen/bloc/auth_bloc.dart';
import 'package:wallpaper_app/screens/Auth%20Screen/ui/login_widget.dart';
import 'package:wallpaper_app/screens/Auth%20Screen/ui/signup_widget.dart';

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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Stack(
          children: [
            Lottie.asset(
                height: double.infinity,
                fit: BoxFit.fill,
                "lib/assets/auth_bg.json"),
            Scaffold(
              resizeToAvoidBottomInset: false,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(120),
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
                            "Image Generator"),
                      ),
                    ),
                  ),
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.fromLTRB(20, 70, 20, 40),
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
                              child: BlocBuilder<AuthBloc, AuthState>(
                                builder: ((context, state) {
                                  switch (state) {
                                    case AuthInitial():
                                      return const LoginWidget();
                                    case AuthLoading():
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ));
                                    case AuthSuccess():
                                      return const LinearProgressIndicator();
                                    case AuthLogin():
                                      return const LoginWidget();
                                    case AuthSignup():
                                      return const SignUpWidget();
                                    default:
                                      return const Center(
                                          child: Text("Default"));
                                  }
                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}
