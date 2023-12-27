// To parse this JSON data, do
//
//     final communitiesModel = communitiesModelFromJson(jsonString);

import 'dart:convert';

CommunitiesModel communitiesModelFromJson(String str) =>
    CommunitiesModel.fromJson(json.decode(str));

String communitiesModelToJson(CommunitiesModel data) =>
    json.encode(data.toJson());

class CommunitiesModel {
  int? totalAssociations;
  List<Association>? associations;
  String? currentPage;
  int? perPage;
  int? totalPages;

  CommunitiesModel({
    this.totalAssociations,
    this.associations,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory CommunitiesModel.fromJson(Map<String, dynamic> json) =>
      CommunitiesModel(
        totalAssociations: json["totalAssociations"],
        associations: json["associations"] == null
            ? []
            : List<Association>.from(
                json["associations"]!.map((x) => Association.fromJson(x))),
        currentPage: json["current_page"]?.toString(),
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalAssociations": totalAssociations,
        "associations": associations == null
            ? []
            : List<dynamic>.from(associations!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class Association {
  int? id;
  String? name;
  String? backgroundImage;
  int? unitCount;
  List<String>? units;
  String? backgroundImageUrl;

  Association({
    this.id,
    this.name,
    this.backgroundImage,
    this.unitCount,
    this.units,
    this.backgroundImageUrl,
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
        id: json["id"],
        name: json["name"],
        backgroundImage: json["background_image"],
        unitCount: json["unit_count"],
        units: json["units"] == null
            ? []
            : List<String>.from(json["units"]!.map((x) => x)),
        backgroundImageUrl: json["background_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "background_image": backgroundImage,
        "unit_count": unitCount,
        "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x)),
        "background_image_url": backgroundImageUrl,
      };
}
