import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/authentication/authentication_bloc.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          child: Text('LOGOUT'),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(SignOut());
          },
        )
      ),
    );
  }
}
