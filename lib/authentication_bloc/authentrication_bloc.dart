import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_registration_using_bloc/authentication_bloc/authentication_event.dart';
import 'package:firebase_registration_using_bloc/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({  UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    }else if (event is AuthenticationVerified) {
     yield* _mapAuthenticationVerifiedToState();}
    
     else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } 
     
    else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutInToState();
    }
  }

  //AuthenticationLoggedOut
  Stream<AuthenticationState> _mapAuthenticationLoggedOutInToState() async* {
    yield AuthenticationFailure();
    _userRepository.signOut();
  }

  //AuthenticationLoggedIn
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
  
    yield AuthenticationSuccess(await _userRepository.getUser());
    
  }
 Stream<AuthenticationState> _mapAuthenticationVerifiedToState() async* {
 
      yield AuthenticationVerify(await _userRepository.getUser());
   
      
    }
    
   
  // AuthenticationStarted
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final firebaseUser = await _userRepository.getUser();
      if(firebaseUser.isEmailVerified){
      yield AuthenticationSuccess(firebaseUser);
   
      }
      else{
        yield AuthenticationFailure();
      }
    }
    else{
      yield AuthenticationFailure();
    }
  }
    }