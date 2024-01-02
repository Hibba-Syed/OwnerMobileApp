// To parse this JSON data, do
//
//     final companiesModel = companiesModelFromJson(jsonString);

import 'dart:convert';

CompaniesModel companiesModelFromJson(String str) =>
    CompaniesModel.fromJson(json.decode(str));

String companiesModelToJson(CompaniesModel data) => json.encode(data.toJson());

class CompaniesModel {
  String? status;
  List<CompaniesRecord>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CompaniesModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CompaniesModel.fromJson(Map<String, dynamic> json) => CompaniesModel(
        status: json["status"],
        record: json["record"] == null
            ? []
            : List<CompaniesRecord>.from(json["record"]!.map((x) => CompaniesRecord.fromJson(x))),
        code: json["code"],
        meta: json["meta"],
        requestStatus: json["request_status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": record == null
            ? []
            : List<dynamic>.from(record!.map((x) => x.toJson())),
        "code": code,
        "meta": meta,
        "request_status": requestStatus,
        "message": message,
      };
}

class CompaniesRecord {
  int? id;
  String? name;

  CompaniesRecord({
    this.id,
    this.name,
  });

  factory CompaniesRecord.fromJson(Map<String, dynamic> json) => CompaniesRecord(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
