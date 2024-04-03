import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final firestoreDB = FirebaseFirestore.instance;
  AuthBloc() : super(AuthInitial()) {
    on<OnSignInButtonClickedEvent>(onSignInButtonClickedEvent);
    on<OnSignUpButtonClickedEvent>(onSignUpButtonClickedEvent);
    on<OnSignUpChangeStateButtonClickedEvent>(
        onSignUpChangeStateButtonClickedEvent);
    on<OnSignInWithGoogleButtonClickedEvent>(
        onSignInWithGoogleButtonClickedEvent);
  }

  FutureOr<void> onSignInButtonClickedEvent(
      OnSignInButtonClickedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.username, password: event.password);
      if (FirebaseAuth.instance.currentUser != null) {
        emit(AuthSuccess());
        emit(AuthInitial());
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
          email: event.email, password: event.password);

      if (FirebaseAuth.instance.currentUser != null) {
        emit(AuthSuccess());

        emit(AuthInitial());
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

  FutureOr<void> onSignInWithGoogleButtonClickedEvent(
      OnSignInWithGoogleButtonClickedEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gauth = await user!.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: gauth.idToken, accessToken: gauth.accessToken);
      FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        emit(AuthSuccess());
        final userData = {
          'name': user.displayName,
          'email': user.email,
        };
        final db = FirebaseFirestore.instance;
        final storage = db.collection('users');
        final result = storage.add(userData);
        print(result.toString());
        emit(AuthInitial());
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }
}
