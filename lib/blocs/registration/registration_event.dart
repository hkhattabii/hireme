part of 'registration_bloc.dart';

enum FieldName {
  EMAIL,
  USERNAME,
  PASSWORD,
  PASSWORDREPEAT,
  NAME,
  SURNAME,
  CERTIFICATE,
  ROLE,
  EXPERIENCE,
  PLATFORMS,
  PROJECTS,
  TECHNOLOGIES,

}

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class ReturnAccountSelector extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class SelectRecruiterRegistration extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class SelectCandidateRegistration extends RegistrationEvent {
  final AccountType accountType;
  SelectCandidateRegistration({this.accountType});
  @override
  List<Object> get props => [accountType];
}

class NextStep extends RegistrationEvent {
  final int stepFocused;
  NextStep({this.stepFocused});

  @override
  List<Object> get props => [stepFocused];
}

class PreviousStep extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class CandidateTextFieldChanged extends RegistrationEvent {
  final dynamic value;
  final FieldName fieldName;
  CandidateTextFieldChanged({this.value, this.fieldName});

  @override
  List<Object> get props => [value, fieldName];
}

class CandidateTogglePlatforms extends RegistrationEvent {
  final bool newValue;
  final String platformName;
  CandidateTogglePlatforms({this.newValue, this.platformName});

  @override
  List<Object> get props => [newValue, platformName];
}

class CandidateToggleTechnologies extends RegistrationEvent {
  final Technology technology;
  CandidateToggleTechnologies({this.technology});

  @override
  List<Object> get props => [technology];
}

class CandidateAddProject extends RegistrationEvent {
  final Project project;
  CandidateAddProject({this.project});
  @override
  List<Object> get props => [project];
}

class CandidateRemoveProject extends RegistrationEvent {
  final Project project;
  CandidateRemoveProject({this.project});

  @override
  List<Object> get props => [project];
}

class CandidateAddImage extends RegistrationEvent {
  final File image;
  CandidateAddImage({this.image});

  @override
  List<Object> get props => [image];
}

class SignUp extends RegistrationEvent {
  @override
  List<Object> get props => [];
}
