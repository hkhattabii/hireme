import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/models/Technology.dart';

class TechnologyCards extends StatelessWidget {
  final List<Technology> technologies;
  TechnologyCards({this.technologies});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Technologies maitrisées',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: technologies.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Technology technology = technologies[index];
                  return Container(
                    width: 80,
                    height: 64,
                    child: Card(
                      elevation: 4,
                      child: Center(
                        child: Image.asset(
                          technology.logo,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
