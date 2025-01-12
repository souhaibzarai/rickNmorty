class Character {
  late int id;
  late String name;
  late String status;
  late String speciesIfHumanOrDifferentType;
  late String type;
  late String gender;
  late Map<String, dynamic> origin;
  late Map<String, dynamic> location;
  late String image;
  late String created;

  Character.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"] ?? 'Unknown';
    status = json["status"];
    speciesIfHumanOrDifferentType = json["species"];
    type = json["type"] ?? '';
    gender = json["gender"];
    origin = json["origin"] ?? {};
    location = json["location"] ?? {};
    image = json["image"];
    created = json["created"];
  }
}
