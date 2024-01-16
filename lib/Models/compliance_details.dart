// To parse this JSON data, do
//
//     final complianceDetailsModel = complianceDetailsModelFromJson(jsonString);

import 'dart:convert';

ComplianceDetailsModel complianceDetailsModelFromJson(String str) =>
    ComplianceDetailsModel.fromJson(json.decode(str));

String complianceDetailsModelToJson(ComplianceDetailsModel data) =>
    json.encode(data.toJson());

class ComplianceDetailsModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  ComplianceDetailsModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory ComplianceDetailsModel.fromJson(Map<String, dynamic> json) =>
      ComplianceDetailsModel(
        status: json["status"],
        record: json["record"] == null ? null : Record.fromJson(json["record"]),
        code: json["code"],
        meta: json["meta"],
        requestStatus: json["request_status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": record?.toJson(),
        "code": code,
        "meta": meta,
        "request_status": requestStatus,
        "message": message,
      };
}

class Record {
  int? id;
  String? name;
  String? date;
  String? expiryDate;
  String? description;
  String? certificate;
  int? notApplicable;
  List<History>? history;

  Record({
    this.id,
    this.name,
    this.date,
    this.expiryDate,
    this.description,
    this.certificate,
    this.notApplicable,
    this.history,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        expiryDate: json["expiry_date"],
        description: json["description"],
        certificate: json["certificate"],
        notApplicable: json["not_applicable"],
        history: json["history"] == null
            ? []
            : List<History>.from(
                json["history"]!.map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "expiry_date": expiryDate,
        "description": description,
        "certificate": certificate,
        "not_applicable": notApplicable,
        "history": history == null
            ? []
            : List<dynamic>.from(history!.map((x) => x.toJson())),
      };
}

class History {
  String? date;
  String? expiryDate;
  String? certificate;

  History({
    this.date,
    this.expiryDate,
    this.certificate,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        date: json["date"],
        expiryDate: json["expiry_date"],
        certificate: json["certificate"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "expiry_date": expiryDate,
        "certificate": certificate,
      };
}
