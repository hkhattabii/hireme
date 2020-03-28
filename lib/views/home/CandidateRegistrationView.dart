import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/registration/registration_bloc.dart';
import 'package:hireme/widgets/home/CustomDropDown.dart';
import 'package:hireme/widgets/home/CustomTextField.dart';
import 'package:hireme/widgets/home/PlatformsCheckBox.dart';
import 'package:hireme/widgets/home/ProjectDialog.dart';
import 'package:hireme/widgets/home/TechnologyDialog.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class CandidateRegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "CANDIDATE",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<RegistrationBloc>(context)
                  .add(ReturnAccountSelector());
            },
          ),
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark
                ])),
            child: BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, state) {
                final int currentStep =
                    (state as CandidateRegistration).currentStep;

                return Theme(
                  data: ThemeData(primaryColor: Theme.of(context).accentColor),
                  child: Stepper(
                    steps: [
                      step1(context, currentStep),
                      step2(context, currentStep),
                      step3(context, currentStep),
                      step4(context, currentStep),
                    ],
                    currentStep: currentStep,
                    onStepContinue: () {
                      onNextStep(context, currentStep);
                    },
                    onStepCancel: currentStep > 0
                        ? () {
                            BlocProvider.of<RegistrationBloc>(context)
                                .add(PreviousStep());
                          }
                        : null,
                    onStepTapped: (index) {
                      BlocProvider.of<RegistrationBloc>(context)
                          .add(NextStep(stepFocused: index));
                    },
                  ),
                );
              },
            ),
          ),
        ));
  }
}

Step step1(BuildContext context, int currentStep) {
  return Step(
      isActive: currentStep == 0,
      title: Text(
        "Informations de compte",
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
        children: <Widget>[
          CustomTextField(
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              onChange: (text) {
                onTextFieldChange(context, text, FieldName.EMAIL);
              }),
          CustomTextField(
              label: "Mot de passe",
              keyboardType: TextInputType.visiblePassword,
              onChange: (text) {
                onTextFieldChange(context, text, FieldName.PASSWORD);
              }),
          CustomTextField(
              label: "Répétez le mot de passe",
              keyboardType: TextInputType.visiblePassword,
              onChange: (text) {
                onTextFieldChange(context, text, FieldName.PASSWORDREPEAT);
              })
        ],
      ));
}

Step step2(BuildContext context, int currentStep) {
  return Step(
      isActive: currentStep == 1,
      title: Text(
        "Informations personnel",
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextField(
              label: "Nom",
              onChange: (text) {
                onTextFieldChange(context, text, FieldName.SURNAME);
              }),
          CustomTextField(
              label: "Prenom",
              onChange: (text) {
                onTextFieldChange(context, text, FieldName.NAME);
              }),
          CustomDropDown(
            label: 'Plus haut diplome',
            onChange: (value) {
              onTextFieldChange(context, value, FieldName.CERTIFICATE);
            },
          ),
        ],
      ));
}

Step step3(BuildContext context, int currentStep) {
  return Step(
      isActive: currentStep == 2,
      title: Text(
        'Informations professionel',
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
        children: <Widget>[
          CustomTextField(
              label: "Expérience",
              keyboardType: TextInputType.number,
              onChange: (text) =>
                  onTextFieldChange(context, text, FieldName.EXPERIENCE)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              PlatformsCheckBox(platformName: 'Web'),
              PlatformsCheckBox(platformName: 'Mobile'),
              PlatformsCheckBox(platformName: 'Bureau'),
            ],
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Ajouter des technologies',
              style: GoogleFonts.roboto(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return TechnologyDialog();
                  });
            },
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Ajouter des projets',
              style: GoogleFonts.roboto(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ProjectDialog();
                  });
            },
          )
        ],
      ));
}

Step step4(BuildContext context, int currentStep) {
  return Step(
      isActive: currentStep == 3,
      title: Text(
        'Insertion d\'une photo',
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Apercu de l'image dans le feed",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (BuildContext context, RegistrationState state) {
              File image = (state as CandidateRegistration).image;
              return Container(
                width: 256,
                height: 380,
                child: InkWell(
                  onTap: () async {
                    File imageMade = await ImagePickerGC.pickImage(
                        context: context,
                        source: ImgSource.Both,
                        cameraIcon: Icon(Icons.add, color: Colors.red));
                    uploadImage(context, imageMade);
                  },
                  child: Card(
                    color: Colors.white,
                    child: image != null
                        ? Image.file(
                            image,
                            fit: BoxFit.cover,
                          )
                        : Center(child: Text('Cliquez pour ajouter une photo')),
                  ),
                ),
              );
            },
          )
        ],
      ));
}

uploadImage(BuildContext context, File image) {
  BlocProvider.of<RegistrationBloc>(context)
      .add(CandidateAddImage(image: image));
}

onNextStep(BuildContext context, int currentStep) {
  currentStep < 3
      ? BlocProvider.of<RegistrationBloc>(context).add(NextStep())
      : BlocProvider.of<RegistrationBloc>(context).add(SignUp());
}

onTextFieldChange(BuildContext context, dynamic value, FieldName fieldName) {
  BlocProvider.of<RegistrationBloc>(context)
      .add(CandidateTextFieldChanged(value: value, fieldName: fieldName));
}
