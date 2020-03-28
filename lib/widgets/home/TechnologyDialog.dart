import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/models/Technology.dart';

List<Technology> technologiesList = [
  Technology(
      id: 'PFPlag5VYIccI0IGcUbQ', name: 'Graphql', logo: 'images/graphql.png'),
  Technology(
      id: '6BTQ57VshpaBS0ILMtNl', name: 'Angular', logo: 'images/angular.png'),
  Technology(id: 'JX6pGfi1DqfP4SNWyyz3', name: 'Html', logo: 'images/html.png'),
  Technology(id: '65yIxQ9Msyh1gVPTP6Am', name: 'Css', logo: 'images/css.png'),
];

class TechnologyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 16.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: technologiesList.length,
            itemBuilder: (BuildContext context, int index) {
              return BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (BuildContext context, RegistrationState state) {
                  Technology technology = technologiesList[index];
                  List<Technology> technologiesSelected =
                      (state as CandidateRegistration).technologies;
                  return ListTile(
                    title: Text(
                      technology.name,
                      style: GoogleFonts.roboto(
                          color: isTechnologySelected(
                                  technology, technologiesSelected)
                              ? Theme.of(context).primaryColorDark
                              : Colors.black,
                          fontWeight: isTechnologySelected(
                                  technology, technologiesSelected)
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    leading:
                        Image.asset(technology.logo, width: 32, height: 32),
                    trailing:
                        isTechnologySelected(technology, technologiesSelected)
                            ? Icon(
                                Icons.check_box,
                                color: Theme.of(context).accentColor,
                              )
                            : Icon(Icons.check_box_outline_blank),
                    onTap: () {
                      BlocProvider.of<RegistrationBloc>(context).add(
                          CandidateToggleTechnologies(technology: technology));
                    },
                  );
                },
              );
            }),
      ),
    );
  }

  bool isTechnologySelected(
      Technology technology, List<Technology> technologiesSelected) {
    return technologiesSelected.indexOf(technology) > -1 ? true : false;
  }
}
