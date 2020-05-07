part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class AccountSelector extends RegistrationState {
  @override
  List<Object> get props => [];
}

class CandidateRegistration extends RegistrationState {
  final AccountType accountType;
  final int currentStep;
  final String email;
  final String password;
  final String passwordRepeat;
  final String name;
  final String surname;
  final String certificate;
  final String role;
  final int experience;
  final List<String> platforms;
  final List<Project> projects;
  final List<Technology> technologies;
  final File image;
  bool showError;

  CandidateRegistration(
      {this.accountType,
      this.currentStep,
      this.email,
      this.password,
      this.passwordRepeat,
      this.name,
      this.surname,
      this.certificate,
      this.role,
      this.experience,
      this.platforms,
      this.projects,
      this.technologies,
      this.image,
      this.showError});

  //Met à jour le state, tout en gardant les données en verifiant s'ils doivent être ecrasé ou pas.
  CandidateRegistration update(
          {AccountType accountType,
          int currentStep,
          String email,
          String password,
          String passwordRepeat,
          String name,
          String surname,
          String certificate,
          String role,
          int experience,
          List<String> platforms,
          List<Project> projects,
          List<Technology> technologies,
          File image}) =>
      CandidateRegistration(
          accountType: accountType ?? this.accountType,
          currentStep: currentStep ?? this.currentStep,
          email: email ?? this.email,
          password: password ?? this.password,
          passwordRepeat: passwordRepeat ?? this.passwordRepeat,
          name: name ?? this.name,
          surname: surname ?? this.surname,
          certificate: certificate ?? this.certificate,
          role: role ?? this.role,
          experience: experience ?? this.experience,
          platforms: platforms ?? this.platforms,
          projects: projects ?? this.projects,
          technologies: technologies ?? this.technologies,
          image: image ?? this.image);

  @override
  List<Object> get props => [
        accountType,
        currentStep,
        email,
        password,
        name,
        surname,
        certificate,
        role,
        experience,
        platforms,
        projects,
        technologies,
        image
      ];

  @override
  String toString() {
    return {
      'accountType': this.accountType,
      'currentStep': this.currentStep,
      'email': this.email,
      'password': this.password,
      'passwordRepeat': this.passwordRepeat,
      'name': this.name,
      'surname': this.surname,
      'certificate': this.certificate,
      'role': this.role,
      'experience': this.experience,
      'platforms': this.platforms,
      'projects': this.projects,
      'technologies': this.technologies,
      'image': this.image.path
    }.toString();
  }
}

class RecruiterRegistration extends RegistrationState {
  @override
  List<Object> get props => [];
}
