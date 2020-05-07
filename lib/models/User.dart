import 'package:hireme/models/Technology.dart';

enum AccountType { RECRUITER, CANDIDATE }

class User {
  String _id;
  String _avatarURL;
  String _role;
  String _certificate;
  String _token;
  int _experience;
  List<String> _platforms;
  List<Technology> _technologies;
  AccountType _accountType;
  Map<String, double> _location;


  User.fromJson(
      String documentID, Map<String, dynamic> json, AccountType accountType, List<Technology> technologies) {
    this._id = documentID;
    this._avatarURL = json["avatarURL"];
    this._role = json["role"];
    this._certificate = json["certificate"];
    this._token = json["token"];
    this._experience = json["experience"];
    this._platforms = json["platform"].cast<String>();
    this._technologies = technologies;
    this._accountType = accountType;
  }

  //ENCAPSULATION
  String get id => _id;
  String get avatarURL => _avatarURL;
  String get role => _role;
  String get certificate => _certificate;
  String get token => _token;
  int get experience => _experience;
  List<String> get platforms => _platforms;
  List<Technology> get technologies => _technologies;
  AccountType get accountType => _accountType;
  Map<String, double> get location => _location;

  void set token(String token) {
    _token = token;
  }
}
