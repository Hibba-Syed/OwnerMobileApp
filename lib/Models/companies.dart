// To parse this JSON data, do
//
//     final companiesModel = companiesModelFromJson(jsonString);

import 'dart:convert';

CompaniesModel companiesModelFromJson(String str) =>
    CompaniesModel.fromJson(json.decode(str));

String companiesModelToJson(CompaniesModel data) => json.encode(data.toJson());

class CompaniesModel {
  List<Companies>? companies;

  CompaniesModel({
    this.companies,
  });

  factory CompaniesModel.fromJson(Map<String, dynamic> json) => CompaniesModel(
        companies: json["companies"] == null
            ? []
            : List<Companies>.from(
                json["companies"]!.map((x) => Companies.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "companies": companies == null
            ? []
            : List<dynamic>.from(companies!.map((x) => x.toJson())),
      };
}

class Companies {
  int? id;
  String? companiesName;

  Companies({
    this.id,
    this.companiesName,
  });

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
        id: json["id"],
        companiesName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companiesName,
      };
}
