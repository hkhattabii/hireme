class Technology {
  String id;
  String name;
  String logo;

  Technology({this.id, this.name, this.logo});

  Technology.fromJson(String documentID, Map<String, dynamic> json) {
    this.id = documentID;
    this.name = json["name"];
    this.logo = json["logo"];
  }

  @override
  String toString() {
    return {'id': id, 'name': name, 'logo': logo}.toString();
  }
}
