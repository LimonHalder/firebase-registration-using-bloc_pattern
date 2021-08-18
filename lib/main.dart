// @dart=2.9

import 'package:firebase_registration_using_bloc/home_screen.dart';
import 'package:firebase_registration_using_bloc/register_bloc/register_bloc.dart';
import 'package:firebase_registration_using_bloc/repositories/search_repository.dart';
import 'package:firebase_registration_using_bloc/repositories/user_repository.dart';
import 'package:firebase_registration_using_bloc/screens/login/login_screen.dart';
import 'package:firebase_registration_using_bloc/screens/register/register_screen.dart';
import 'package:firebase_registration_using_bloc/screens/search/search.dart';
import 'package:firebase_registration_using_bloc/screens/search/searchq.dart';
import 'package:firebase_registration_using_bloc/search/search_bloc.dart';
import 'package:firebase_registration_using_bloc/simple_bloc_observer.dart';
import 'package:firebase_registration_using_bloc/verify_screen.dart';
import 'package:firebase_registration_using_bloc/verifybloc/lio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc/authentication_event.dart';
import 'authentication_bloc/authentication_state.dart';
import 'authentication_bloc/authentrication_bloc.dart';
import 'login_bloc/login_bloc.dart';
import 'login_bloc/login_event.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          )..add(AuthenticationStarted()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(userRepository: userRepository),
        ),
   BlocProvider(
          create: (context) => LoginBloc(userRepository: userRepository),
        ),
BlocProvider(
          create: (context) => SearchBloc(searchRepository: SearchRepository()),
        ),

      ],
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff6a515e),
        cursorColor: Color(0xff6a515e),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }

          if (state is AuthenticationSuccess) {
            return HomeScreen(
              //user: state.firebaseUser,
            );
          }
          if (state is AuthenticationVerify) {
            return LoginScreen(
              //user: state.firebaseUser,
            );
          }

          return Scaffold(
              appBar: AppBar(),
              body: Container(
                child: Center(child:  CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )),
              ));
        },
      ),
    );
  }
}
