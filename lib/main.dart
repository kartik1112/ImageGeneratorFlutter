import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/screens/Home%20Screen/bloc/home_bloc.dart';
import 'package:wallpaper_app/screens/Home%20Screen/ui/home_screen.dart';
import 'package:wallpaper_app/repositories/get_api_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RepositoryProvider(
      create: (context) => GetApiDataRepository(),
      child: BlocProvider(
        create: (context) => HomeBloc(),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              theme: ThemeData(textTheme: GoogleFonts.robotoCondensedTextTheme()),
              home: const HomeScreen(),
            );
          }
        ),
      ),
    ),
  );
}
