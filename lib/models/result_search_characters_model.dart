// To parse this JSON data, do
//
//     final resultSearchCharacters = resultSearchCharactersFromJson(jsonString);

import 'dart:convert';

ResultSearchCharacters resultSearchCharactersFromJson(String str) =>
    ResultSearchCharacters.fromJson(json.decode(str));

String resultSearchCharactersToJson(ResultSearchCharacters data) =>
    json.encode(data.toJson());

class ResultSearchCharacters {
  ResultSearchCharacters({
    required this.info,
    required this.results,
  });

  Info info;
  List<Character> results;

  factory ResultSearchCharacters.fromJson(Map<String, dynamic> json) =>
      ResultSearchCharacters(
        info: Info.fromJson(json["info"]),
        results: List<Character>.from(
            json["results"].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.count,
  });

  int? count;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}

class Character {
  Character({
    required this.id,
    required this.name,
    this.status,
    this.species,
    required this.type,
    this.gender,
    required this.image,
    required this.created,
  });

  String id;
  String name;
  Status? status;
  Species? species;
  String type;
  Gender? gender;
  String image;
  DateTime created;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]],
        species: speciesValues.map[json["species"]],
        type: json["type"],
        gender: genderValues.map[json["gender"]],
        image: json["image"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "image": image,
        "created": created.toIso8601String(),
      };
}

enum Gender { MALE, FEMALE, UNKNOWN }

final genderValues = EnumValues(
    {"Female": Gender.FEMALE, "Male": Gender.MALE, "unknown": Gender.UNKNOWN});

enum Species { HUMAN, ALIEN }

final speciesValues =
    EnumValues({"Alien": Species.ALIEN, "Human": Species.HUMAN});

enum Status { ALIVE, UNKNOWN, DEAD }

final statusValues = EnumValues(
    {"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
