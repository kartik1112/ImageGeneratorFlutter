part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GenerateButtonClickedEvent extends HomeEvent {
  final String prompt;

  GenerateButtonClickedEvent(this.prompt);
}

class SaveGeneratedImageToLocalStorageClickedEvent extends HomeEvent {
  final Uint8List imageFile;
  final String fileName;

  SaveGeneratedImageToLocalStorageClickedEvent(this.imageFile, this.fileName);
}

class SignOutButtonClickedEvent extends HomeEvent {}
