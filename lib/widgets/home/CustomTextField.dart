import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Function onChange;
  CustomTextField({this.label = "", this.keyboardType, this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText:
            keyboardType == TextInputType.visiblePassword ? true : false,
        onChanged: (text) {
          onChange(text);
        },
        decoration: InputDecoration(
            labelText: this.label,
            labelStyle: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))));
  }
}
