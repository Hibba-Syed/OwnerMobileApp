// To parse this JSON data, do
//
//     final ledgerByStatementModel = ledgerByStatementModelFromJson(jsonString);

import 'dart:convert';

LedgerByStatementModel ledgerByStatementModelFromJson(String str) =>
    LedgerByStatementModel.fromJson(json.decode(str));

String ledgerByStatementModelToJson(LedgerByStatementModel data) =>
    json.encode(data.toJson());

class LedgerByStatementModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  LedgerByStatementModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory LedgerByStatementModel.fromJson(Map<String, dynamic> json) =>
      LedgerByStatementModel(
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
  Data? data;
  Meta? meta;

  Record({
    this.data,
    this.meta,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Data {
  int? totalLedgers;
  List<Ledger>? ledgers;
  int? currentPage;
  int? perPage;
  int? totalPages;

  Data({
    this.totalLedgers,
    this.ledgers,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalLedgers: json["totalLedgers"],
        ledgers: json["ledgers"] == null
            ? []
            : List<Ledger>.from(
                json["ledgers"]!.map((x) => Ledger.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalLedgers": totalLedgers,
        "ledgers": ledgers == null
            ? []
            : List<dynamic>.from(ledgers!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class Ledger {
  DateTime? date;
  String? document;
  String? reference;
  String? type;
  String? description;
  double? debit;
  double? credit;
  double? balance;

  Ledger({
    this.date,
    this.document,
    this.reference,
    this.type,
    this.description,
    this.debit,
    this.credit,
    this.balance,
  });

  factory Ledger.fromJson(Map<String, dynamic> json) => Ledger(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        document: json["document"],
        reference: json["reference"],
        type: json["type"],
        description: json["description"],
        debit: json["debit"]?.toDouble(),
        credit: json["credit"]?.toDouble(),
        balance: json["balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "document": document,
        "reference": reference,
        "type": type,
        "description": description,
        "debit": debit,
        "credit": credit,
        "balance": balance,
      };
}

class Meta {
  double? openingBalance;
  double? closingBalance;

  Meta({
    this.openingBalance,
    this.closingBalance,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        openingBalance: json["opening_balance"]?.toDouble(),
        closingBalance: json["closing_balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "opening_balance": openingBalance,
        "closing_balance": closingBalance,
      };
}
