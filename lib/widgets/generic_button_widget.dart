import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';

class GenericButtonWidget extends StatelessWidget {
  const GenericButtonWidget(
      {super.key,
      required this.promptText,
      required this.buttonText,
      required this.iconData});

  final String promptText;
  final String buttonText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        context.read<HomeBloc>().add(
              GenerateButtonClickedEvent(promptText),
            );
        // getPromptResult(promtController.text);
      },
      icon: Icon(iconData),
      label: Text(buttonText),
    );
  }
}
