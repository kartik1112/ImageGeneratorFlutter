part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final Uint8List? image;

  HomeSuccess({ this.image});
}

final class HomeFailure extends HomeState {}
