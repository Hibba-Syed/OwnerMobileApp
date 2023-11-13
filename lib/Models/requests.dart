// To parse this JSON data, do
//
//     final requestsModel = requestsModelFromJson(jsonString);

import 'dart:convert';

RequestsModel requestsModelFromJson(String str) =>
    RequestsModel.fromJson(json.decode(str));

String requestsModelToJson(RequestsModel data) => json.encode(data.toJson());

class RequestsModel {
  int? totalApplications;
  List<Application>? applications;
  int? currentPage;
  int? perPage;
  int? totalPages;

  RequestsModel({
    this.totalApplications,
    this.applications,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) => RequestsModel(
        totalApplications: json["totalApplications"],
        applications: json["applications"] == null
            ? []
            : List<Application>.from(
                json["applications"]!.map((x) => Application.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalApplications": totalApplications,
        "applications": applications == null
            ? []
            : List<dynamic>.from(applications!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class Application {
  int? id;
  int? unitId;
  String? reference;
  String? applicationType;
  String? clientName;
  String? clientPhone;
  DateTime? createdAt;
  String? status;
  String? clientIdFileUrl;
  String? passportFileUrl;
  String? titleDeedUrl;
  String? tenancyContractUrl;
  String? tradeLicenseUrl;
  bool? isMailable;
  String? fullName;
  String? profileImageUrl;

  Application({
    this.id,
    this.unitId,
    this.reference,
    this.applicationType,
    this.clientName,
    this.clientPhone,
    this.createdAt,
    this.status,
    this.clientIdFileUrl,
    this.passportFileUrl,
    this.titleDeedUrl,
    this.tenancyContractUrl,
    this.tradeLicenseUrl,
    this.isMailable,
    this.fullName,
    this.profileImageUrl,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        unitId: json["unit_id"],
        reference: json["reference"],
        applicationType: json["application_type"],
        clientName: json["client_name"],
        clientPhone: json["client_phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"],
        clientIdFileUrl: json["client_id_file_url"],
        passportFileUrl: json["passport_file_url"],
        titleDeedUrl: json["title_deed_url"],
        tenancyContractUrl: json["tenancy_contract_url"],
        tradeLicenseUrl: json["trade_license_url"],
        isMailable: json["is_mailable"],
        fullName: json["full_name"],
        profileImageUrl: json["profile_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_id": unitId,
        "reference": reference,
        "application_type": applicationType,
        "client_name": clientName,
        "client_phone": clientPhone,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "client_id_file_url": clientIdFileUrl,
        "passport_file_url": passportFileUrl,
        "title_deed_url": titleDeedUrl,
        "tenancy_contract_url": tenancyContractUrl,
        "trade_license_url": tradeLicenseUrl,
        "is_mailable": isMailable,
        "full_name": fullName,
        "profile_image_url": profileImageUrl,
      };
}
