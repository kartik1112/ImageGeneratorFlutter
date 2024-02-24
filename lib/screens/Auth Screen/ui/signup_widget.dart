import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wallpaper_app/screens/Auth%20Screen/bloc/auth_bloc.dart';
import 'package:wallpaper_app/widgets/auth_screen_login_button.dart';
import 'package:wallpaper_app/widgets/auth_screen_textfield.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
          key: _formKey,
          child: Column(
            children: [
              AuthScreenTextField(
                type: 'name',
                controller: nameController,
                subject: "Name",
              ),
              const SizedBox(
                height: 12,
              ),
              AuthScreenTextField(
                type: 'username',
                controller: usernameController,
                subject: "Username",
              ),
              const SizedBox(
                height: 12,
              ),
              AuthScreenTextField(
                type: 'email',
                controller: emailController,
                subject: "Email",
              ),
              const SizedBox(
                height: 12,
              ),
              AuthScreenTextField(
                type: 'paasword',
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
                      if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(OnSignUpButtonClickedEvent(
                          username: emailController.text,
                          password: passwordController.text));
                        
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Entered Fields are not Valid')));
                      }
                      // Future.delayed(Duration(seconds: 3));
                      
                    },
                    subject: "Sign Up",
                    icon: const Icon(Icons.person_add_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
