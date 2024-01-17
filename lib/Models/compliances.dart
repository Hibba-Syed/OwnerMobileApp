// To parse this JSON data, do
//
//     final compliancesModel = compliancesModelFromJson(jsonString);

import 'dart:convert';

CompliancesModel compliancesModelFromJson(String str) =>
    CompliancesModel.fromJson(json.decode(str));

String compliancesModelToJson(CompliancesModel data) =>
    json.encode(data.toJson());

class CompliancesModel {
  int? totalCompliance;
  List<Compliance>? compliances;
  String? currentPage;
  int? perPage;
  int? totalPages;

  CompliancesModel({
    this.totalCompliance,
    this.compliances,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory CompliancesModel.fromJson(Map<String, dynamic> json) =>
      CompliancesModel(
        totalCompliance: json["totalCompliance"],
        compliances: json["compliances"] == null
            ? []
            : List<Compliance>.from(
                json["compliances"]!.map((x) => Compliance.fromJson(x))),
        currentPage: json["current_page"]?.toString(),
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalCompliance": totalCompliance,
        "compliances": compliances == null
            ? []
            : List<dynamic>.from(compliances!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class Compliance {
  int? id;
  String? name;
  DateTime? duedate;
  DateTime? expiry;
  String? certificate;
  int? notApplicable;
  String? description;

  Compliance({
    this.id,
    this.name,
    this.duedate,
    this.expiry,
    this.certificate,
    this.notApplicable,
    this.description,
  });

  factory Compliance.fromJson(Map<String, dynamic> json) => Compliance(
        id: json["id"],
        name: json["name"],
        duedate:
            json["duedate"] == null ? null : DateTime.parse(json["duedate"]),
        expiry: json["expiry"] == null ? null : DateTime.parse(json["expiry"]),
        certificate: json["certificate"],
        notApplicable: json["not_applicable"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duedate": duedate?.toIso8601String(),
        "expiry": expiry?.toIso8601String(),
        "certificate": certificate,
        "not_applicable": notApplicable,
        "description": description,
      };
}
