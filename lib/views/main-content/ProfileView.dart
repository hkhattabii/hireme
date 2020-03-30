import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/authentication/authentication_bloc.dart';
import 'package:hireme/blocs/profile/profile_bloc.dart';
import 'package:hireme/models/Candidate.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/views/main-content/SettingsView.dart';
import 'package:hireme/widgets/profile/PlatformCards.dart';
import 'package:hireme/widgets/profile/TechnologyCards.dart';

class ProfileView extends StatelessWidget {
  final User user;
  ProfileView({this.user});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState) {
        return user.accountType == AccountType.CANDIDATE
            ? CandidateProfileView(
                candidate: user,
              )
            : Container(
                child: Center(
                  child: RaisedButton(
                    child: Text('Logout'),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignOut());
                    },
                  ),
                ),
              );
      },
    );
  }
}

class CandidateProfileView extends StatelessWidget {
  final Candidate candidate;
  CandidateProfileView({this.candidate});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidate.surname.toUpperCase() +
            ' ' +
            candidate.name +
            ', ' +
            candidate.role +
            ' dev'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsView()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Container(
                  width: double.infinity,
                  height: 256,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(candidate.avatarURL),
                          fit: BoxFit.fill)),
                ),
              ),
              PlatformCards(platforms: candidate.platforms),
              TechnologyCards(technologies: candidate.technologies),
              Container(
                width: double.infinity,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
