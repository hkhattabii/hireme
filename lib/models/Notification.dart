class UserNotification {
  String _id;
  String _message;

  UserNotification(String id , String message) {
    this._message = message;
    this._id = id;
  }

  UserNotification.fromJson(String documentID, Map<String, dynamic> json) {
    this._id = documentID;
    this._message = json["message"];
  }

  String get id => _id;
  String get message => _message;


  @override
  String toString() {
    // TODO: implement toString
    return {'id': _id, 'message': _message}.toString();
  }
}