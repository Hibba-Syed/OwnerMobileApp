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
  String? type;
  String? backgroundImageUrl;
  int? unitCount;
  String? address;
  String? city;
  String? state;
  String? country;

  Association({
    this.id,
    this.name,
    this.type,
    this.backgroundImageUrl,
    this.unitCount,
    this.address,
    this.city,
    this.state,
    this.country,
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        backgroundImageUrl: json["background_image_url"],
        unitCount: json["unit_count"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "background_image_url": backgroundImageUrl,
        "unit_count": unitCount,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
      };
}
