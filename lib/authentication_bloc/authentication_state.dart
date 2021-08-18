

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationState extends Equatable{
  AuthenticationState();

  @override
  
  List<Object> get props => [];
  
}

class AuthenticationInitial extends AuthenticationState{

}class AuthenticationVerify extends AuthenticationState{
  final FirebaseUser firebaseUser;
  AuthenticationVerify(this.firebaseUser);
  @override
  List<Object> get props =>[firebaseUser];

}


class AuthenticationSuccess extends AuthenticationState{
  final FirebaseUser firebaseUser;
  AuthenticationSuccess(this.firebaseUser);
  @override
  List<Object> get props =>[firebaseUser];

}

class AuthenticationFailure extends AuthenticationState{
  
}