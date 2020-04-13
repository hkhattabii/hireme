import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/authentication/authentication_bloc.dart';
import 'package:hireme/blocs/profile/profile_bloc.dart';
import 'package:hireme/models/Candidate.dart';
import 'package:hireme/models/Project.dart';
import 'package:hireme/models/Recruiter.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/views/main-content/SettingsView.dart';
import 'package:hireme/widgets/profile/PersonnalInformations.dart';
import 'package:hireme/widgets/profile/PlatformCards.dart';
import 'package:hireme/widgets/profile/TechnologyCards.dart';

class ProfileView extends StatelessWidget {
  final User user;
  ProfileView({this.user});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(user.accountType == AccountType.CANDIDATE
                ? (user as Candidate).surname.toUpperCase() +
                    ' ' +
                    (user as Candidate).name +
                    ', ' +
                    (user as Candidate).role +
                    ' dev'
                : (user as Recruiter).companyName),
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
                              image: NetworkImage(user.avatarURL),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  PlatformCards(platforms: user.platforms),
                  TechnologyCards(technologies: user.technologies),
                  PersonalInformations(
                    experience: user.experience.toString(),
                    certificate: user.certificate,
                  ),
                  user.accountType == AccountType.CANDIDATE
                      ? Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Projet',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              ListView.builder(
                                  itemCount:
                                      (user as Candidate).projects.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Project project =
                                        (user as Candidate).projects[index];
                                    return ListTile(
                                      title: Text(project.name),
                                      subtitle: Text(project.url),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                    );
                                  })
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
