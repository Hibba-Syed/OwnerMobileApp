// To parse this JSON data, do
//
//     final invoicesModel = invoicesModelFromJson(jsonString);

import 'dart:convert';

InvoicesModel invoicesModelFromJson(String str) =>
    InvoicesModel.fromJson(json.decode(str));

String invoicesModelToJson(InvoicesModel data) => json.encode(data.toJson());

class InvoicesModel {
  int? totalInvoices;
  List<Invoice>? invoices;
  String? currentPage;
  int? perPage;
  int? totalPages;

  InvoicesModel({
    this.totalInvoices,
    this.invoices,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory InvoicesModel.fromJson(Map<String, dynamic> json) => InvoicesModel(
        totalInvoices: json["totalInvoices"],
        invoices: json["invoices"] == null
            ? []
            : List<Invoice>.from(
                json["invoices"]!.map((x) => Invoice.fromJson(x))),
        currentPage: json["current_page"]?.toString(),
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalInvoices": totalInvoices,
        "invoices": invoices == null
            ? []
            : List<dynamic>.from(invoices!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class Invoice {
  int? id;
  DateTime? date;
  DateTime? dueDate;
  String? reference;
  String? mollakReference;
  String? description;
  String? documents;

  Invoice(
      {this.id,
      this.date,
      this.dueDate,
      this.reference,
      this.mollakReference,
      this.description,
      this.documents});

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      id: json["id"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      dueDate:
          json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
      reference: json["reference"],
      mollakReference: json["mollak_reference"],
      description: json["description"],
      documents: json["document"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "reference": reference,
        "mollak_reference": mollakReference,
        "description": description,
        "document": documents
      };
}
