import 'package:hireme/models/Project.dart';
import 'package:hireme/models/Technology.dart';
import 'package:hireme/models/User.dart';

class Candidate extends User {
  String _name;
  String _surname;
  List<Project> _projects;

  Candidate.fromJson(String documentID, Map<String, dynamic> json, List<Technology> technologies, List<Project> projects)
      : super.fromJson(documentID, json, AccountType.CANDIDATE, technologies) {
    this._name = json["name"];
    this._surname = json["surname"];
    this._projects = projects;
  }

  String get name => _name;
  String get surname => _surname;
  List<Project> get projects => _projects;

  @override
  String toString() {
    return {
      'id': id,
      'name': _name,
      'surname': _surname,
      'projects': _projects,
      'avatarURL': avatarURL,
      'role': role,
      'certificate': certificate,
      'experience': experience,
      'platforms': platforms,
      'technologies': technologies,
      'accountType': accountType,
      'location': location

    }.toString();
  }
}
