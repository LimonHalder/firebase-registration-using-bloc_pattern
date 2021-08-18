import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}
class AuthenticationVerified extends AuthenticationEvent {}


class AuthenticationLoggedOut extends AuthenticationEvent {}