import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';

class PlatformsCheckBox extends StatelessWidget {
  final String platformName;
  PlatformsCheckBox({this.platformName});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (BuildContext context, RegistrationState state) {
      List<String> platformsSelected =
          (state as CandidateRegistration).platforms;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Color(0xffff8a30),
              value: getCheckBoxValue(platformsSelected),
              onChanged: (newValue) => toggleCheckBox(context, newValue)),
          Text(
            platformName,
            style: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }

  toggleCheckBox(BuildContext context, bool newValue) {
    BlocProvider.of<RegistrationBloc>(context).add(CandidateTogglePlatforms(newValue: newValue, platformName: platformName));
  }
  getCheckBoxValue(List<String> platformsSelected) {
    return platformsSelected.indexOf(platformName) > -1 ? true : false;
  }
}
