

import 'package:firebase_registration_using_bloc/login_bloc/login_event.dart';
import 'package:firebase_registration_using_bloc/login_bloc/login_state.dart';
import 'package:firebase_registration_using_bloc/repositories/user_repository.dart';
import 'package:firebase_registration_using_bloc/validatore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChange) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginWithCredentialPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(
        isEmailValid: Validators.isValidEmail(email), isPasswordValid: true);
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password),
        isEmailValid: true);
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {String email, String password}) async* {
    yield LoginState.loading();
    try {
      
      await _userRepository.signInWithCredentials(email, password);
      final firebaseUser = await _userRepository.getUser();
       //await firebaseUser.reload();
      //final firebaseUser1 = await _userRepository.getUser();
      //firebaseUser1.reload();
      firebaseUser.reload();
      if (firebaseUser.isEmailVerified) {
        yield LoginState.success();
        
      }else{
        yield LoginState.verify
        ();
      }
     
     } catch (_) {
      yield LoginState.failure();
    }
  }
}
