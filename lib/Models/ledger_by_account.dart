// To parse this JSON data, do
//
//     final ledgerByAccountModel = ledgerByAccountModelFromJson(jsonString);

import 'dart:convert';

LedgerByAccountModel ledgerByAccountModelFromJson(String str) =>
    LedgerByAccountModel.fromJson(json.decode(str));

String ledgerByAccountModelToJson(LedgerByAccountModel data) =>
    json.encode(data.toJson());

class LedgerByAccountModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  LedgerByAccountModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory LedgerByAccountModel.fromJson(Map<String, dynamic> json) =>
      LedgerByAccountModel(
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
  List<AccountDatum>? data;
  Meta? meta;

  Record({
    this.data,
    this.meta,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        data: json["data"] == null
            ? []
            : List<AccountDatum>.from(
                json["data"]!.map((x) => AccountDatum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class AccountDatum {
  String? ledgerName;
  List<LedgerAccountDatum>? ledgers;

  AccountDatum({
    this.ledgerName,
    this.ledgers,
  });

  factory AccountDatum.fromJson(Map<String, dynamic> json) => AccountDatum(
        ledgerName: json["ledger_name"],
        ledgers: json["ledgers"] == null
            ? []
            : List<LedgerAccountDatum>.from(
                json["ledgers"]!.map((x) => LedgerAccountDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ledger_name": ledgerName,
        "ledgers": ledgers == null
            ? []
            : List<dynamic>.from(ledgers!.map((x) => x.toJson())),
      };
}

class LedgerAccountDatum {
  int? id;
  DateTime? date;
  String? document;
  String? reference;
  String? type;
  String? transactionNo;
  String? description;
  dynamic debit;
  double? credit;
  double? balance;

  LedgerAccountDatum({
    this.id,
    this.date,
    this.document,
    this.reference,
    this.type,
    this.transactionNo,
    this.description,
    this.debit,
    this.credit,
    this.balance,
  });

  factory LedgerAccountDatum.fromJson(Map<String, dynamic> json) =>
      LedgerAccountDatum(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        document: json["document"],
        reference: json["reference"],
        type: json["type"],
        transactionNo: json["transaction_no"],
        description: json["description"],
        debit: json["debit"],
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
