// To parse this JSON data, do
//
//     final requestsFiltersModel = requestsFiltersModelFromJson(jsonString);

import 'dart:convert';

RequestsFiltersModel requestsFiltersModelFromJson(String str) => RequestsFiltersModel.fromJson(json.decode(str));

String requestsFiltersModelToJson(RequestsFiltersModel data) => json.encode(data.toJson());

class RequestsFiltersModel {
    List<String>? applicationType;
    List<String>? status;

    RequestsFiltersModel({
        this.applicationType,
        this.status,
    });

    factory RequestsFiltersModel.fromJson(Map<String, dynamic> json) => RequestsFiltersModel(
        applicationType: json["application_type"] == null ? [] : List<String>.from(json["application_type"]!.map((x) => x)),
        status: json["status"] == null ? [] : List<String>.from(json["status"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "application_type": applicationType == null ? [] : List<dynamic>.from(applicationType!.map((x) => x)),
        "status": status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
    };
}
