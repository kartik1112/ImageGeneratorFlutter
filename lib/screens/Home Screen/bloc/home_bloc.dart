import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/repositories/get_api_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    onTransition(transition) {
      print(transition.toString());
    }

    on<GenerateButtonClickedEvent>(generateButtonClickedEvent);
    on<SaveGeneratedImageToLocalStorageClickedEvent>(
        saveGeneratedImageToLocalStorageClickedEvent);
    on<SignOutButtonClickedEvent>(signOutButtonClickedEvent);
    on<SaveGeneratedImageToCloudStorageClickedEvent>(
        saveGeneratedImageToCloudStorageClickedEvent);
  }

  FutureOr<void> generateButtonClickedEvent(
      GenerateButtonClickedEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final image = await GetApiDataRepository().getPromptResult(event.prompt);
      emit(HomeSuccess(image: image));
    } catch (e) {
      print(e.toString());
      emit(HomeFailure());
    }
  }

  FutureOr<void> saveGeneratedImageToLocalStorageClickedEvent(
      SaveGeneratedImageToLocalStorageClickedEvent event,
      Emitter<HomeState> emit) async {
    final dir = await getTemporaryDirectory();

    final imageFile =
        File("${dir.path}/${event.fileName.replaceAll(" ", "")}.jpg");

    imageFile.writeAsBytesSync(event.imageFile);

    final params = SaveFileDialogParams(sourceFilePath: imageFile.path);

    await FlutterFileDialog.saveFile(params: params);
  }

  FutureOr<void> signOutButtonClickedEvent(
      SignOutButtonClickedEvent event, Emitter<HomeState> emit) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    emit(HomeInitial());
  }

  FutureOr<void> saveGeneratedImageToCloudStorageClickedEvent(
      SaveGeneratedImageToCloudStorageClickedEvent event,
      Emitter<HomeState> emit) async {
    ScaffoldMessenger.of(event.context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(event.context).colorScheme.primary,
        content: const Text("Saving to Cloud"),
        duration: const Duration(seconds: 3),
      ),
    );

    final storage = FirebaseStorage.instance;
    final Directory systemTempDir =
        Directory.systemTemp; // getting tempory directory
    final imageFile =
        File("${systemTempDir.path}/${event.fileName.replaceAll(" ", "")}.jpg");
    imageFile.writeAsBytesSync(event.imageFile);
    TaskSnapshot taskSnapshot = await storage
        .ref("${event.fileName.replaceAll(" ", "")}.jpg")
        .putFile(imageFile);
    
  }
}
