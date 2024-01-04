// To parse this JSON data, do
//
//     final requestsFiltersModel = requestsFiltersModelFromJson(jsonString);

import 'dart:convert';

RequestsFiltersModel requestsFiltersModelFromJson(String str) => RequestsFiltersModel.fromJson(json.decode(str));

String requestsFiltersModelToJson(RequestsFiltersModel data) => json.encode(data.toJson());

class RequestsFiltersModel {
    List<ApplicationType>? applicationType;
    List<String>? status;

    RequestsFiltersModel({
        this.applicationType,
        this.status,
    });

    factory RequestsFiltersModel.fromJson(Map<String, dynamic> json) => RequestsFiltersModel(
        applicationType: json["application_type"] == null ? [] : List<ApplicationType>.from(json["application_type"]!.map((x) => ApplicationType.fromJson(x))),
        status: json["status"] == null ? [] : List<String>.from(json["status"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "application_type": applicationType == null ? [] : List<dynamic>.from(applicationType!.map((x) => x.toJson())),
        "status": status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
    };
}

class ApplicationType {
    String? name;
    String? key;

    ApplicationType({
        this.name,
        this.key,
    });

    factory ApplicationType.fromJson(Map<String, dynamic> json) => ApplicationType(
        name: json["name"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
    };
}
