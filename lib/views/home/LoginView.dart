import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/authentication/authentication_bloc.dart';
import 'package:hireme/views/home/RegistrationView.dart';
import 'package:hireme/widgets/home/CustomTextField.dart';

class LoginView extends StatelessWidget {
  final Unauthenticated state;
  LoginView({this.state});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "HireMe",
            style: GoogleFonts.roboto(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Column(
            children: <Widget>[
              CustomTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                onChange: (email) => onEmailChanged(context, email),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Mot de passe',
                keyboardType: TextInputType.emailAddress,
                onChange: (email) => onPasswordChanged(context, email),
              ),
              RaisedButton(
                child: Text(
                  'CONNEXION',
                  style: GoogleFonts.roboto(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                onPressed: () {
                  onSignIn(context, state.password, state.email);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pas inscrit ?',
                style:
                    GoogleFonts.roboto(color: Theme.of(context).disabledColor),
              ),
              FlatButton(
                child: Text(
                  'Inscription',
                  style: GoogleFonts.roboto(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  goToSignUp(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  goToSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationView()));
  }

  onSignIn(BuildContext context, String password, String email) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(SignIn(email: email, password: password));
  }

  onEmailChanged(BuildContext context, String email) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(EmailChanged(email: email));
  }

  onPasswordChanged(BuildContext context, String password) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(PasswordChanged(password: password));
  }
}
