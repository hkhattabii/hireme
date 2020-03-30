import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/models/User.dart';

class PersonalInformations extends StatelessWidget {
  final String experience;
  final String certificate;
  PersonalInformations({this.experience, this.certificate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Années d'éxperience : ",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: experience,
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black))
          ])),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Plus haut diplome : ",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: certificate,
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black))
          ]))
        ],
      ),
    );
  }
}
