// To parse this JSON data, do
//
//     final sharedDocumentsModel = sharedDocumentsModelFromJson(jsonString);

import 'dart:convert';

SharedDocumentsModel sharedDocumentsModelFromJson(String str) =>
    SharedDocumentsModel.fromJson(json.decode(str));

String sharedDocumentsModelToJson(SharedDocumentsModel data) =>
    json.encode(data.toJson());

class SharedDocumentsModel {
  int? totalDocuments;
  List<SharedDocument>? sharedDocuments;
  String? currentPage;
  int? perPage;
  int? totalPages;

  SharedDocumentsModel({
    this.totalDocuments,
    this.sharedDocuments,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory SharedDocumentsModel.fromJson(Map<String, dynamic> json) =>
      SharedDocumentsModel(
        totalDocuments: json["totalDocuments"],
        sharedDocuments: json["shared_documents"] == null
            ? []
            : List<SharedDocument>.from(json["shared_documents"]!
                .map((x) => SharedDocument.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalDocuments": totalDocuments,
        "shared_documents": sharedDocuments == null
            ? []
            : List<dynamic>.from(sharedDocuments!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class SharedDocument {
  String? documentName;
  String? title;
  DateTime? expiryDate;
  List<String>? tags;
  String? documents;

  SharedDocument({
    this.documentName,
    this.title,
    this.expiryDate,
    this.tags,
    this.documents,
  });

  factory SharedDocument.fromJson(Map<String, dynamic> json) => SharedDocument(
        documentName: json["document_name"],
        title: json["title"],
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.parse(json["expiry_date"]),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        documents: json["documents"],
      );

  Map<String, dynamic> toJson() => {
        "document_name": documentName,
        "title": title,
        "expiry_date": expiryDate,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "documents": documents,
      };
}
