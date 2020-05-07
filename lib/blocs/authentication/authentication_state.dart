part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated({this.user});
  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  final String error;
  bool showError;
  Unauthenticated({this.error, this.showError});

  @override
  List<Object> get props => [error, showError];


  Unauthenticated update({String email, String password, String error}) =>
      copyWith(email: email, password: password, error: error);

  Unauthenticated copyWith({String email, String password, String error}) {
    return Unauthenticated(
        error: error ?? this.error);
  }

  @override
  String toString() {
    return {  
      'error': error
    }.toString();
  }
}
