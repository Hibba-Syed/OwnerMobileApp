// To parse this JSON data, do
//
//     final sharedDocumentsModel = sharedDocumentsModelFromJson(jsonString);

import 'dart:convert';

SharedDocumentsModel sharedDocumentsModelFromJson(String str) =>
    SharedDocumentsModel.fromJson(json.decode(str));

String sharedDocumentsModelToJson(SharedDocumentsModel data) =>
    json.encode(data.toJson());

class SharedDocumentsModel {
  String? status;
  List<SharedDocumentsRecord>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  SharedDocumentsModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory SharedDocumentsModel.fromJson(Map<String, dynamic> json) =>
      SharedDocumentsModel(
        status: json["status"],
        record: json["record"] == null
            ? []
            : List<SharedDocumentsRecord>.from(json["record"]!.map((x) => SharedDocumentsRecord.fromJson(x))),
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

class SharedDocumentsRecord {
  String? documentName;
  String? title;
  DateTime? expiryDate;
  List<String>? tags;
  String? documents;

  SharedDocumentsRecord({
    this.documentName,
    this.title,
    this.expiryDate,
    this.tags,
    this.documents,
  });

  factory SharedDocumentsRecord.fromJson(Map<String, dynamic> json) => SharedDocumentsRecord(
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
        "expiry_date":
            "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "documents": documents,
      };
}
