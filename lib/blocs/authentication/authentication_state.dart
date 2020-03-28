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
  final String email;
  final String password;
  final String error;
  Unauthenticated({this.email, this.password, this.error});

  @override
  List<Object> get props => [email, password, error];

  Unauthenticated update({String email, String password, String error}) =>
      copyWith(email: email, password: password, error: error);

  Unauthenticated copyWith({String email, String password, String error}) {
    return Unauthenticated(
        email: email ?? this.email,
        password: password ?? this.password,
        error: error ?? this.error);
  }
}
