// To parse this JSON data, do
//
//     final ledgerTypesModel = ledgerTypesModelFromJson(jsonString);

import 'dart:convert';

LedgerTypesModel ledgerTypesModelFromJson(String str) => LedgerTypesModel.fromJson(json.decode(str));

String ledgerTypesModelToJson(LedgerTypesModel data) => json.encode(data.toJson());

class LedgerTypesModel {
    String? status;
    Record? record;
    int? code;
    dynamic meta;
    bool? requestStatus;
    String? message;

    LedgerTypesModel({
        this.status,
        this.record,
        this.code,
        this.meta,
        this.requestStatus,
        this.message,
    });

    factory LedgerTypesModel.fromJson(Map<String, dynamic> json) => LedgerTypesModel(
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
    List<IndividualLedger>? ledgers;

    Record({
        this.ledgers,
    });

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        ledgers: json["ledgers"] == null ? [] : List<IndividualLedger>.from(json["ledgers"]!.map((x) => IndividualLedger.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ledgers": ledgers == null ? [] : List<dynamic>.from(ledgers!.map((x) => x.toJson())),
    };
}

class IndividualLedger {
    int? id;
    String? name;

    IndividualLedger({
        this.id,
        this.name,
    });

    factory IndividualLedger.fromJson(Map<String, dynamic> json) => IndividualLedger(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
