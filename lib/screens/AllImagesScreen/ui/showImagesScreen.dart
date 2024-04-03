import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';

class ShowImagesScreen extends StatelessWidget {
  const ShowImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
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
            title: Text(
              "Generate Image 🚀",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(SignOutButtonClickedEvent());
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ],
          ),
          body: Text("data"))
      ],
    );
  }
}