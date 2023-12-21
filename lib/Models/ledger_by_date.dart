// To parse this JSON data, do
//
//     final ledgerByDateModel = ledgerByDateModelFromJson(jsonString);

import 'dart:convert';

LedgerByDateModel ledgerByDateModelFromJson(String str) =>
    LedgerByDateModel.fromJson(json.decode(str));

String ledgerByDateModelToJson(LedgerByDateModel data) =>
    json.encode(data.toJson());

class LedgerByDateModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  LedgerByDateModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory LedgerByDateModel.fromJson(Map<String, dynamic> json) =>
      LedgerByDateModel(
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
  List<LedgerByDateDatum>? data;
  Meta? meta;

  Record({
    this.data,
    this.meta,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        data: json["data"] == null
            ? []
            : List<LedgerByDateDatum>.from(json["data"]!.map((x) => LedgerByDateDatum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class LedgerByDateDatum {
  int? id;
  DateTime? date;
  String? document;
  String? reference;
  String? type;
  String? transactionNo;
  String? account;
  String? description;
  double? debit;
  double? credit;
  double? balance;

  LedgerByDateDatum({
    this.id,
    this.date,
    this.document,
    this.reference,
    this.type,
    this.transactionNo,
    this.account,
    this.description,
    this.debit,
    this.credit,
    this.balance,
  });

  factory LedgerByDateDatum.fromJson(Map<String, dynamic> json) => LedgerByDateDatum(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        document: json["document"],
        reference: json["reference"],
        type: json["type"],
        transactionNo: json["transaction_no"],
        account: json["account"],
        description: json["description"],
        debit: json["debit"]?.toDouble(),
        credit: json["credit"]?.toDouble(),
        balance: json["balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "document": document,
        "reference": reference,
        "type": type,
        "transaction_no": transactionNo,
        "account": account,
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
