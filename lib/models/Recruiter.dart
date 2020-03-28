import 'package:hireme/models/Technology.dart';
import 'package:hireme/models/User.dart';

class Recruiter extends User {
  String _companyName;
  String _companyLocation;

  Recruiter.fromJson(String documentID, Map<String, dynamic> json, List<Technology> technologies)
      : super.fromJson(documentID, json, AccountType.RECRUITER, technologies) {
    this._companyName = json["name"];
    this._companyLocation = json["companyLocation"];
  }

  String get companyName => _companyName;



    @override
  String toString() {
    return {
      'id': id,
      'companyName': _companyName,
      'companyLocation': _companyLocation,
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
