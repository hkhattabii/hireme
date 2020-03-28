import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/repositories/UserRepository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedState(event);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedState(event);
    } else if (event is SignIn) {
      yield* _mapSignInToState(
          event); //Se connecte à l'application, renvoie un etat de non connexion si les informations  sont incorrect avec une rreur
    } else if (event is SignOut) {
      yield* _mapSignOutToState(); //Prmet de renvoie l'état de non connexion lorsque l'utilisateur se deconnecte
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    yield Uninitialized();
    User user = await UserRepository.getCurrentUser();
    if (user != null) {
      yield Authenticated(user: user);
    } else {
      yield Unauthenticated(email: '', password: '');
    }
  }

  Stream<AuthenticationState> _mapEmailChangedState(EmailChanged event) async* {
    yield (state as Unauthenticated).update(email: event.email);
  }

  Stream<AuthenticationState> _mapPasswordChangedState(
      PasswordChanged event) async* {
    yield (state as Unauthenticated).update(password: event.password);
  }

  Stream<AuthenticationState> _mapSignInToState(SignIn event) async* {
    try {
      yield Uninitialized();
      User user = await UserRepository.signIn(event.email, event.password);
      yield Authenticated(user: user);
    } catch (e) {
      yield Unauthenticated(email: '', password: '');
    }
  }

  Stream<AuthenticationState> _mapSignOutToState() async* {
    UserRepository.signOut();
    yield Unauthenticated(email: '', password: '');
  }
}
