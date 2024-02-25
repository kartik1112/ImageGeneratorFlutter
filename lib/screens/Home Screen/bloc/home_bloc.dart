import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/repositories/get_api_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GenerateButtonClickedEvent>(generateButtonClickedEvent);
    on<SaveGeneratedImageToLocalStorageClickedEvent>(
        saveGeneratedImageToLocalStorageClickedEvent);
    on<SignOutButtonClickedEvent>(signOutButtonClickedEvent);
  }

  FutureOr<void> generateButtonClickedEvent(
      GenerateButtonClickedEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final image = await GetApiDataRepository().getPromptResult(event.prompt);

      emit(HomeSuccess(image: image));
    } catch (e) {
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
    await FirebaseAuth.instance.signOut();
    emit(HomeInitial());
  }
}
