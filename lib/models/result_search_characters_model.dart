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
    required this.image,
  });

  String id;
  String name;
  String image;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
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
