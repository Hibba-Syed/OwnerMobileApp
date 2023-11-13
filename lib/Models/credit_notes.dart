// To parse this JSON data, do
//
//     final creditNotesModel = creditNotesModelFromJson(jsonString);

import 'dart:convert';

CreditNotesModel creditNotesModelFromJson(String str) =>
    CreditNotesModel.fromJson(json.decode(str));

String creditNotesModelToJson(CreditNotesModel data) =>
    json.encode(data.toJson());

class CreditNotesModel {
  int? totalCreditNotes;
  List<CreditNote>? creditNotes;
  int? currentPage;
  int? perPage;
  int? totalPages;

  CreditNotesModel({
    this.totalCreditNotes,
    this.creditNotes,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory CreditNotesModel.fromJson(Map<String, dynamic> json) =>
      CreditNotesModel(
        totalCreditNotes: json["totalCreditNotes"],
        creditNotes: json["credit_notes"] == null
            ? []
            : List<CreditNote>.from(
                json["credit_notes"]!.map((x) => CreditNote.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalCreditNotes": totalCreditNotes,
        "credit_notes": creditNotes == null
            ? []
            : List<dynamic>.from(creditNotes!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class CreditNote {
  DateTime? date;
  String? reference;
  String? description;
  int? amount;

  CreditNote({
    this.date,
    this.reference,
    this.description,
    this.amount,
  });

  factory CreditNote.fromJson(Map<String, dynamic> json) => CreditNote(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        reference: json["reference"],
        description: json["description"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "reference": reference,
        "description": description,
        "amount": amount,
      };
}
