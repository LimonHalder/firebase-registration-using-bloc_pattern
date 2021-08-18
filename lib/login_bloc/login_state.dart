
import 'package:firebase_auth/firebase_auth.dart';

class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isVerifying;

  bool get isFormValid => isEmailValid || isPasswordValid;

  LoginState(
      { this.isEmailValid,
       this.isPasswordValid,
       this.isSubmitting,
      this.isSuccess,
       this.isFailure,
       this.isVerifying,
});

  factory LoginState.initial() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isVerifying: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isVerifying: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isVerifying: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isVerifying: false,
    );
  }
  factory LoginState.verify() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isVerifying: true,
    );
  }

  LoginState update({
     bool isEmailValid,
     bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isVerifying: false,
    );
  }

  LoginState copyWith({
   bool isEmailValid,
     bool isPasswordValid,
   bool isSubmitting,
    bool isSuccess,
     bool isFailure,
     bool isVerifying,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isVerifying: isVerifying ?? this.isVerifying
    );
  }
}