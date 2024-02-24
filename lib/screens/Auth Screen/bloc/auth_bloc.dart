import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<OnSignInButtonClickedEvent>(onSignInButtonClickedEvent);
    on<OnSignUpButtonClickedEvent>(onSignUpButtonClickedEvent);
    on<OnSignUpChangeStateButtonClickedEvent>(
        onSignUpChangeStateButtonClickedEvent);
  }

  FutureOr<void> onSignInButtonClickedEvent(
      OnSignInButtonClickedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.username, password: event.password);
      if (FirebaseAuth.instance.currentUser != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(message: "Login not Successfull"));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  FutureOr<void> onSignUpButtonClickedEvent(
      OnSignUpButtonClickedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    print("preesed sign up");
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.username, password: event.password);

      if (FirebaseAuth.instance.currentUser != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(message: "Login not Successfull"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  FutureOr<void> onSignUpChangeStateButtonClickedEvent(
      OnSignUpChangeStateButtonClickedEvent event, Emitter<AuthState> emit) {
    emit(AuthSignup());
  }
}
