// To parse this JSON data, do
//
//     final unitFinancialsModel = unitFinancialsModelFromJson(jsonString);

import 'dart:convert';

UnitFinancialsModel unitFinancialsModelFromJson(String str) =>
    UnitFinancialsModel.fromJson(json.decode(str));

String unitFinancialsModelToJson(UnitFinancialsModel data) =>
    json.encode(data.toJson());

class UnitFinancialsModel {
  String? status;
  List<Record>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  UnitFinancialsModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory UnitFinancialsModel.fromJson(Map<String, dynamic> json) =>
      UnitFinancialsModel(
        status: json["status"],
        record: json["record"] == null
            ? []
            : List<Record>.from(json["record"]!.map((x) => Record.fromJson(x))),
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

class Record {
  int? unitId;
  String? communityName;
  String? unitNumber;
  double? balance;

  Record({
    this.unitId,
    this.communityName,
    this.unitNumber,
    this.balance,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        unitId: json["unit_id"],
        communityName: json["community_name"],
        unitNumber: json["unit_number"],
        balance: json["balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "unit_id": unitId,
        "community_name": communityName,
        "unit_number": unitNumber,
        "balance": balance,
      };
}
