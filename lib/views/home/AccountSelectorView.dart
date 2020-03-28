import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/models/User.dart';

class AccountSelectorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              child: Text(
                'RECRUTEUR',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              color: Theme.of(context).primaryColorDark,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              onPressed: () {
                goToRecruiterRegistration(context);
              },
            ),
          ),
          SizedBox(height: 32.0),
          ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              child: Text(
                'CANDIDAT',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              color: Theme.of(context).primaryColorDark,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              onPressed: () {
                goToCandidateRegistration(context);
              },
            ),
          )
        ],
      ),
    );
  }

  goToRecruiterRegistration(BuildContext context) {
    BlocProvider.of<RegistrationBloc>(context)
        .add(SelectCandidateRegistration(accountType: AccountType.RECRUITER));
  }

  goToCandidateRegistration(BuildContext context) {
    BlocProvider.of<RegistrationBloc>(context)
        .add(SelectCandidateRegistration(accountType: AccountType.CANDIDATE));
  }
}
