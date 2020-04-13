import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/authentication/authentication_bloc.dart';
import 'package:hireme/blocs/feed/feed_bloc.dart';
import 'package:hireme/blocs/notification/notification_bloc.dart';
import 'package:hireme/blocs/profile/profile_bloc.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/views/home/LoginView.dart';
import 'package:hireme/views/main-content/MainContent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc()..add(AppStarted())),
          BlocProvider<RegistrationBloc>(
            create: (context) => RegistrationBloc(),
          ),
          BlocProvider<FeedBloc>(
            create: (context) => FeedBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider<NotificationBloc>(
            create: (context) => NotificationBloc(),
          )
        ],
        child: MaterialApp(
          title: 'Material App',
          home: MyHomePage(),
          theme: ThemeData(
            primaryColor: Color(0xff5A82DF),
            primaryColorDark: Color(0xff325AB9),
            accentColor: Color(0xffff8a30),
            disabledColor: Color(0xffB5B5B5),
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return CircularProgressIndicator();
          } else if (state is Unauthenticated) {
            return LoginView(state: state);
          } else if (state is Authenticated) {
            BlocProvider.of<FeedBloc>(context).add(LoadUser(whoUseApp: state.user)); //une fois connecté, recupère la liste des candidat ou recruteur
            return MainContent(user: state.user);
          }
          return Container();
        },
      ),
    ));
  }
}
