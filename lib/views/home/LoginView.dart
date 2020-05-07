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
    if (state.error != null && state.showError == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final snackBar = SnackBar(content: Text(state.error));
        Scaffold.of(context).showSnackBar(snackBar);
        state.showError = false;
      });
    } 
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
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
                textEditingController: emailController
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Mot de passe',
                keyboardType: TextInputType.visiblePassword,
                textEditingController: passwordController,
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
                  onSignIn(context, emailController, passwordController);
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
                  goToSignUp(context, state);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  goToSignUp(BuildContext context, Unauthenticated state) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationView(unauthenticatedState: state,)));
  }

  onSignIn(BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(SignIn(email: emailController.text, password: passwordController.text));
    emailController.clear();
    passwordController.clear();
  }
}
