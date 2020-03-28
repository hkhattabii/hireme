import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/models/Candidate.dart';
import 'package:hireme/models/Recruiter.dart';
import 'package:hireme/models/User.dart';

class SuggestionHeader extends StatelessWidget {
  final User userSuggesting;
  SuggestionHeader({this.userSuggesting});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorDark
              ])),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: getName(),
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  TextSpan(
                      text: getRole(),
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ]),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    getExperience(),
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: getTechnolgies()
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String getName() {
    if (userSuggesting is Candidate) {
      return (userSuggesting as Candidate).surname.toUpperCase() +
          ' ' +
          (userSuggesting as Candidate).name + '\n';
    } else if (userSuggesting is Recruiter) {
      return (userSuggesting as Recruiter).companyName.toUpperCase() + '\n';
    }
  }

  String getRole() {
    return userSuggesting.role;
  }

  String getExperience() {
    if (userSuggesting.experience >= 10) {
      return 'Senior';
    } else if (userSuggesting.experience >= 5) {
      return 'Medior';
    } else {
      return 'Junior';
    }
  }


  List<Padding> getTechnolgies() {
    return userSuggesting.technologies.map((technology) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Image.asset(technology.logo, width: 20, height: 20),
    )).toList();
  }
}
