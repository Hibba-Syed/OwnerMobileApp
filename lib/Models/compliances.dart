// To parse this JSON data, do
//
//     final compliancesModel = compliancesModelFromJson(jsonString);

import 'dart:convert';

CompliancesModel compliancesModelFromJson(String str) => CompliancesModel.fromJson(json.decode(str));

String compliancesModelToJson(CompliancesModel data) => json.encode(data.toJson());

class CompliancesModel {
    int? totalCompliance;
    List<ComplianceElement>? compliance;
    int? currentPage;
    int? perPage;
    int? totalPages;

    CompliancesModel({
        this.totalCompliance,
        this.compliance,
        this.currentPage,
        this.perPage,
        this.totalPages,
    });

    factory CompliancesModel.fromJson(Map<String, dynamic> json) => CompliancesModel(
        totalCompliance: json["totalCompliance"],
        compliance: json["compliance"] == null ? [] : List<ComplianceElement>.from(json["compliance"]!.map((x) => ComplianceElement.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "totalCompliance": totalCompliance,
        "compliance": compliance == null ? [] : List<dynamic>.from(compliance!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
    };
}

class ComplianceElement {
    int? id;
    String? name;
    bool? isDeleteable;
    ComplianceCompliance? compliance;

    ComplianceElement({
        this.id,
        this.name,
        this.isDeleteable,
        this.compliance,
    });

    factory ComplianceElement.fromJson(Map<String, dynamic> json) => ComplianceElement(
        id: json["id"],
        name: json["name"],
        isDeleteable: json["is_deleteable"],
        compliance: json["compliance"] == null ? null : ComplianceCompliance.fromJson(json["compliance"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_deleteable": isDeleteable,
        "compliance": compliance?.toJson(),
    };
}

class ComplianceCompliance {
    DateTime? datetime;
    DateTime? expiry;
    int? compliancelabelId;

    ComplianceCompliance({
        this.datetime,
        this.expiry,
        this.compliancelabelId,
    });

    factory ComplianceCompliance.fromJson(Map<String, dynamic> json) => ComplianceCompliance(
        datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        expiry: json["expiry"] == null ? null : DateTime.parse(json["expiry"]),
        compliancelabelId: json["compliancelabel_id"],
    );

    Map<String, dynamic> toJson() => {
        "datetime": datetime?.toIso8601String(),
        "expiry": expiry?.toIso8601String(),
        "compliancelabel_id": compliancelabelId,
    };
}
