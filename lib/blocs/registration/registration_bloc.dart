import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hireme/models/Project.dart';
import 'package:hireme/models/Technology.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/repositories/CandidateRepository.dart';
import 'package:hireme/repositories/RecruiterRepository.dart';
part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  @override
  RegistrationState get initialState => AccountSelector();

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is SelectCandidateRegistration) {
      yield* _mapSelectCandidateRegistrationState(event);
    } else if (event is SelectRecruiterRegistration) {
      yield RecruiterRegistration();
    } else if (event is ReturnAccountSelector) {
      yield AccountSelector();
    } else if (event is NextStep) {
      yield* _mapNextStepState(event);
    } else if (event is PreviousStep) {
      yield* _mapPreviousStepState();
    } else if (event is CandidateTextFieldChanged) {
      yield* _mapCandidateTextFieldChangedState(event);
    } else if (event is CandidateTogglePlatforms) {
      yield* _mapCandidateTogglePlatformsState(event);
    } else if (event is CandidateToggleTechnologies) {
      yield* _mapCandidateToggleTechnologiesState(event);
    } else if (event is CandidateAddProject) {
      yield* _mapCandidateAddProjectState(event);
    } else if (event is CandidateRemoveProject) {
      yield* _mapCandidateRemoveProjectState(event);
    } else if (event is CandidateAddImage) {
      yield* _mapCandidateAddImageState(event);
    } else if (event is SignUp) {
      (state as CandidateRegistration).accountType == AccountType.CANDIDATE ? CandidateRepository.signUp(state) : RecruiterRepository.signUp(state);

    }
  }

  Stream<RegistrationState> _mapSelectCandidateRegistrationState(SelectCandidateRegistration event) async* {
    yield CandidateRegistration(
        accountType: event.accountType,
        currentStep: 0,
        email: '',
        password: '',
        passwordRepeat: '',
        name: '',
        surname: '',
        certificate: 'Bachelier',
        role: '',
        experience: 0,
        platforms: [],
        projects: [],
        technologies: []
        );
  }

  Stream<RegistrationState> _mapNextStepState(NextStep event) async* {
    int nextStep = event.stepFocused == null
        ? (state as CandidateRegistration).currentStep + 1
        : event.stepFocused;
    yield (state as CandidateRegistration).update(currentStep: nextStep);
  }

  Stream<RegistrationState> _mapPreviousStepState() async* {
    int previousStep = (state as CandidateRegistration).currentStep - 1;
    yield (state as CandidateRegistration).update(currentStep: previousStep);
  }

  Stream<RegistrationState> _mapCandidateTogglePlatformsState(
      CandidateTogglePlatforms event) async* {
    List<String> newPlatformsList = List<String>();
    if (event.newValue) {
      newPlatformsList = List.from((state as CandidateRegistration).platforms)
        ..add(event.platformName);
    } else {
      newPlatformsList = List.from((state as CandidateRegistration).platforms)
        ..remove(event.platformName);
    }

    yield (state as CandidateRegistration).update(platforms: newPlatformsList);
  }

  Stream<RegistrationState> _mapCandidateToggleTechnologiesState(
      CandidateToggleTechnologies event) async* {
    List<Technology> newTechnologiesList = List<Technology>();

    if ((state as CandidateRegistration)
            .technologies
            .indexOf(event.technology) >
        -1) {
      newTechnologiesList =
          List.from((state as CandidateRegistration).technologies)
            ..remove(event.technology);
    } else {
      newTechnologiesList =
          List.from((state as CandidateRegistration).technologies)
            ..add(event.technology);
    }

    yield (state as CandidateRegistration).update(technologies: newTechnologiesList);
  }


  Stream<RegistrationState> _mapCandidateAddProjectState(CandidateAddProject event) async* {
    List<Project> newProjectsList = List.from((state as CandidateRegistration).projects)..add(event.project);
    yield (state as CandidateRegistration).update(projects: newProjectsList);
  }

    Stream<RegistrationState> _mapCandidateRemoveProjectState(CandidateRemoveProject event) async* {
    List<Project> newProjectsList = List.from((state as CandidateRegistration).projects)..remove(event.project);
    yield (state as CandidateRegistration).update(projects: newProjectsList);
  }

  Stream<RegistrationState> _mapCandidateAddImageState(CandidateAddImage event) async* {
    yield (state as CandidateRegistration).update(image: event.image);
  }

  Stream<RegistrationState> _mapCandidateTextFieldChangedState(
      CandidateTextFieldChanged event) async* {
    switch (event.fieldName) {
      case FieldName.EMAIL:
        yield (state as CandidateRegistration).update(email: event.value);
        break;
      case FieldName.PASSWORD:
        yield (state as CandidateRegistration).update(password: event.value);
        break;
      case FieldName.PASSWORDREPEAT:
        yield (state as CandidateRegistration)
            .update(passwordRepeat: event.value);
        break;
      case FieldName.NAME:
        yield (state as CandidateRegistration).update(name: event.value);
        break;
      case FieldName.SURNAME:
        yield (state as CandidateRegistration).update(surname: event.value);
        break;
      case FieldName.CERTIFICATE:
        yield (state as CandidateRegistration).update(certificate: event.value);
        break;
      case FieldName.ROLE:
        yield (state as CandidateRegistration).update(role: event.value);
        break;
      case FieldName.EXPERIENCE:
        yield (state as CandidateRegistration).update(experience: int.parse(event.value));
        break;
      case FieldName.PLATFORMS:
        yield (state as CandidateRegistration).update(platforms: event.value);
        break;
      case FieldName.PROJECTS:
        yield (state as CandidateRegistration).update(projects: event.value);
        break;
      case FieldName.TECHNOLOGIES:
        yield (state as CandidateRegistration)
            .update(technologies: event.value);
        break;
      default:
        yield state;
    }
  }
}
