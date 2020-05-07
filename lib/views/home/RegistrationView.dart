import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/authentication/authentication_bloc.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/views/home/AccountSelectorView.dart';
import 'package:hireme/views/home/CandidateRegistrationView.dart';
import 'package:hireme/views/home/RercuiterRegistrationView.dart';

class RegistrationView extends StatelessWidget {
  final Unauthenticated unauthenticatedState;
  RegistrationView({this.unauthenticatedState});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark
                ])),
            child: BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
              if (state is AccountSelector) {
                return AccountSelectorView();
              }  else if (state is CandidateRegistration) {
                return state.accountType == AccountType.CANDIDATE ? CandidateRegistrationView(state: unauthenticatedState) : RecruiterRegistrationView();
              }
              return Container();
            }
          )
        )
      );
    }
}
