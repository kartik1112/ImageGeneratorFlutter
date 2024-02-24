import 'package:flutter/material.dart';

class AuthScreenTextField extends StatelessWidget {
  const AuthScreenTextField(
      {super.key,
      required this.controller,
      required this.subject,
      this.isPass = false, required this.type});

  final TextEditingController controller;
  final String subject;
  final bool isPass;
  final String type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $subject';
        }
        if (isPass) {
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
        }
        if (type == 'email') {
          final regex = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
          if (!regex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        }

        return null;
      },
      obscureText: isPass,
      controller: controller,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      decoration: InputDecoration(
        label: Text(subject),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary.withAlpha(150)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary.withAlpha(150)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
