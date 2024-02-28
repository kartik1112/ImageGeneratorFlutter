import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wallpaper_app/screens/Auth%20Screen/bloc/auth_bloc.dart';
import 'package:wallpaper_app/widgets/auth_screen_login_button.dart';
import 'package:wallpaper_app/widgets/auth_screen_textfield.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _formkey = GlobalKey<FormState>();

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.person_outline_rounded,
            size: 70,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(
          height: 38,
        ),
        Form(
          key: _formkey,
          child: Column(
            children: [
              AuthScreenTextField(
                type: 'email',
                controller: emailController,
                subject: "Email",
              ),
              const SizedBox(
                height: 12,
              ),
              AuthScreenTextField(
                type: 'password',
                controller: passwordController,
                subject: "Password",
                isPass: true,
              ),
              const SizedBox(
                height: 38,
              ),
              Row(
                children: [
                  AuthScreenLoginButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        context.read<AuthBloc>().add(OnSignInButtonClickedEvent(
                            username: emailController.text,
                            password: passwordController.text));
                      }
                    },
                    subject: "Log In",
                    icon: const Icon(Icons.arrow_circle_right),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AuthScreenLoginButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(OnSignUpChangeStateButtonClickedEvent());

                      // context.read<AuthBloc>().add(OnSignUpButtonClickedEvent(
                      //     username: emailController.text,
                      //     password: passwordController.text));
                    },
                    subject: "Sign Up",
                    icon: const Icon(Icons.person_add_rounded),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  AuthScreenLoginButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(OnSignInWithGoogleButtonClickedEvent());
                    },
                    subject: "Continue with Google",
                    icon: const Icon(Ionicons.logo_google),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
