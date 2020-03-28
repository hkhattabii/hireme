class Project {
  String id;
  String name;
  String url;

  Project({this.name, this.url});

  Project.fromJson(String documentID, Map<String, dynamic> json) {
    this.id = documentID;
    this.name = json["name"];
    this.url = json["url"];
  }

  @override
  String toString() {
    return {
      'id': id,
      'name': name,
      'url': url,
    }.toString();
  }
}
