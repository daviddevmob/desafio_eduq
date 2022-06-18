// To parse this JSON data, do
//
//     final characterModel = characterModelFromJson(jsonString);

import 'dart:convert';

CharacterModel characterModelFromJson(String str) =>
    CharacterModel.fromJson(json.decode(str));

String characterModelToJson(CharacterModel data) => json.encode(data.toJson());

class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.created,
    required this.location,
    required this.origin,
    required this.episode,
  });

  String id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  String image;
  DateTime created;
  Location location;
  Location origin;
  List<Episode> episode;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        image: json["image"],
        created: DateTime.parse(json["created"]),
        location: Location.fromJson(json["location"]),
        origin: Location.fromJson(json["origin"]),
        episode:
            List<Episode>.from(json["episode"].map((x) => Episode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "image": image,
        "created": created.toIso8601String(),
        "location": location.toJson(),
        "origin": origin.toJson(),
        "episode": List<dynamic>.from(episode.map((x) => x.toJson())),
      };
}

class Episode {
  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.charactersAlongSide,
  });

  String id;
  String name;
  String airDate;
  String episode;
  List<CharacterAlongSide> charactersAlongSide;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        charactersAlongSide: List<CharacterAlongSide>.from(
            json["characters"].map((x) => CharacterAlongSide.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters":
            List<dynamic>.from(charactersAlongSide.map((x) => x.toJson())),
      };
}

class CharacterAlongSide {
  CharacterAlongSide({
    required this.name,
    required this.image,
    required this.id,
    this.qty = 1,
  });

  String name;
  String image;
  String id;
  int qty;

  factory CharacterAlongSide.fromJson(Map<String, dynamic> json) =>
      CharacterAlongSide(
        name: json["name"],
        image: json["image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "id": id,
      };
}

class Location {
  Location({
    required this.name,
  });

  String name;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
