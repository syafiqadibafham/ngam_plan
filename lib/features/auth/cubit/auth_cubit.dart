import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ngam_plan/features/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState()) {
    _listenToAuthChanges();
  }

  final AuthRepository _authRepository;
  StreamSubscription? _authSubscription;

  User? get currentUser => _authRepository.currentUser;

  void _listenToAuthChanges() {
    _authSubscription = _authRepository.authStateChanges.listen((event) {
      if (event.session != null) {
        emit(state.copyWith(status: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.deleteAccount();
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateUserPassword(String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.updateUserPassword(password);
      // Maybe show a success message
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
