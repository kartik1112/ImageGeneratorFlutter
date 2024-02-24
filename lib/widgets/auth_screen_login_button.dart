import 'package:flutter/material.dart';

class AuthScreenLoginButton extends StatelessWidget {
  const AuthScreenLoginButton(
      {super.key, required this.icon, required this.subject, required this.onPressed});

  final Icon icon;
  final String subject;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            subject,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
