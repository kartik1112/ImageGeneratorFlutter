import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';

class GenericButtonWidget extends StatelessWidget {
  const GenericButtonWidget(
      {super.key,
      required this.promptController,
      required this.buttonText,
      required this.iconData, required this.onTap});

  final TextEditingController promptController;
  final String buttonText;
  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onTap,
      icon: Icon(iconData),
      label: Text(buttonText),
    );
  }
}

        // context.read<HomeBloc>().add(
        //       GenerateButtonClickedEvent(promptController.text),
        //     );
        // getPromptResult(promtController.text);