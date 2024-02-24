import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/firebase_options.dart';
import 'package:wallpaper_app/screens/Auth%20Screen/bloc/auth_bloc.dart';
import 'package:wallpaper_app/screens/Auth%20Screen/ui/auth_screen.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';
import 'package:wallpaper_app/repositories/get_api_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    RepositoryProvider(
      create: (context) => GetApiDataRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              textTheme: GoogleFonts.robotoCondensedTextTheme(),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
          home: const AuthScreen(),
        ),
      ),
    ),
  );
}
