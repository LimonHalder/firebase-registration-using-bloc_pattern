import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{


  @override
  // TODO: implement props
  List<Object> get props => [];
}


class LoginEmailChange extends LoginEvent{
  final String email;
  LoginEmailChange({ this.email});
  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class LoginPasswordChange extends LoginEvent{
  final String password;
  LoginPasswordChange({ this.password});
  @override
  // TODO: implement props
  List<Object> get props => [password];
}



class LoginWithCredentialPressed extends LoginEvent{
  final String email;
  final String password;
  LoginWithCredentialPressed({  this.email ,  this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email,password];
}

