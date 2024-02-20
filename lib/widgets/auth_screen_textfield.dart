import 'package:flutter/material.dart';

class AuthScreenTextField extends StatelessWidget {
  const AuthScreenTextField(
      {super.key,
      required this.controller,
      required this.subject,
      this.isPass = false});

  final TextEditingController controller;
  final String subject;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
