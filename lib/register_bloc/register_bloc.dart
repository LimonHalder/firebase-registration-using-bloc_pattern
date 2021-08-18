import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_registration_using_bloc/register_bloc/register_event.dart';
import 'package:firebase_registration_using_bloc/register_bloc/register_state.dart';
import 'package:firebase_registration_using_bloc/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../validatore.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChange) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChange) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {String email, String password}) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, password);
      await _userRepository.checkEmailVerified();
      yield RegisterState.verify();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
