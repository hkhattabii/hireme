import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';

class CustomDropDown extends StatelessWidget {
  final String label;
  final Function onChange;
  CustomDropDown({this.label, this.onChange});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (BuildContext context, RegistrationState state) {
      String certificateValue = (state as CandidateRegistration).certificate;
      return DropdownButtonFormField(
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          value: certificateValue,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusColor: Colors.white,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          items: <String>['CESS', 'Bachelier', 'Master', 'Doctorat']
              .map((String value) {
            return DropdownMenuItem<String>(child: Text(value,), value: value);
          }).toList(),
          onChanged: (value) => onChange(value));
    });
  }
}
