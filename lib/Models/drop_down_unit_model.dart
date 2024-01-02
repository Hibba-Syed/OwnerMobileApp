// To parse this JSON data, do
//
//     final dropdownUnitModel = dropdownUnitModelFromJson(jsonString);

import 'dart:convert';

DropdownUnitModel dropdownUnitModelFromJson(String str) =>
    DropdownUnitModel.fromJson(json.decode(str));

String dropdownUnitModelToJson(DropdownUnitModel data) =>
    json.encode(data.toJson());

class DropdownUnitModel {
  String? status;
  List<Record>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  DropdownUnitModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory DropdownUnitModel.fromJson(Map<String, dynamic> json) =>
      DropdownUnitModel(
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
  int? id;
  String? unitNumber;
  HappinessCenterConfig? happinessCenterConfig;

  Record({
    this.id,
    this.unitNumber,
    this.happinessCenterConfig,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        unitNumber: json["unit_number"],
        happinessCenterConfig: json["happiness_center_config"] == null
            ? null
            : HappinessCenterConfig.fromJson(json["happiness_center_config"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_number": unitNumber,
        "happiness_center_config": happinessCenterConfig?.toJson(),
      };
}

class HappinessCenterConfig {
  List<CommonArea>? unit;
  List<CommonArea>? commonArea;

  HappinessCenterConfig({
    this.unit,
    this.commonArea,
  });

  factory HappinessCenterConfig.fromJson(Map<String, dynamic> json) =>
      HappinessCenterConfig(
        unit: json["Unit"] == null
            ? []
            : List<CommonArea>.from(
                json["Unit"]!.map((x) => CommonArea.fromJson(x))),
        commonArea: json["Common Area"] == null
            ? []
            : List<CommonArea>.from(
                json["Common Area"]!.map((x) => CommonArea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Unit": unit == null
            ? []
            : List<dynamic>.from(unit!.map((x) => x.toJson())),
        "Common Area": commonArea == null
            ? []
            : List<dynamic>.from(commonArea!.map((x) => x.toJson())),
      };
}

class CommonArea {
  int? id;
  String? serviceName;

  CommonArea({
    this.id,
    this.serviceName,
  });

  factory CommonArea.fromJson(Map<String, dynamic> json) => CommonArea(
        id: json["id"],
        serviceName: json["service_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
      };
}
