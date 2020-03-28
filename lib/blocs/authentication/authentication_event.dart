part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}



class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}


class SignIn extends AuthenticationEvent {
  final String email;
  final String password;
  SignIn({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];

}



class EmailChanged extends AuthenticationEvent {
  final String email;
  EmailChanged({this.email});

  @override
  List<Object> get props => [email];

}


class PasswordChanged extends AuthenticationEvent {
  final String password;
  PasswordChanged({this.password});

  @override
  List<Object> get props => [password];

}