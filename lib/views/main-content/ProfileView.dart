import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/authentication/authentication_bloc.dart';
import 'package:hireme/blocs/profile/profile_bloc.dart';
import 'package:hireme/models/Candidate.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/views/main-content/SettingsView.dart';
import 'package:hireme/widgets/profile/PlatformCards.dart';

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
                  child: Text('Recruiter'),
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
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(candidate.avatarURL),
                        fit: BoxFit.cover)),
              ),
            ),
            PlatformCards(platforms: candidate.platforms)
          ],
        ),
      ),
    );
  }
}
