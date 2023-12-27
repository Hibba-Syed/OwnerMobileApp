// To parse this JSON data, do
//
//     final unitFinancialsModel = unitFinancialsModelFromJson(jsonString);

import 'dart:convert';

UnitFinancialsModel unitFinancialsModelFromJson(String str) => UnitFinancialsModel.fromJson(json.decode(str));

String unitFinancialsModelToJson(UnitFinancialsModel data) => json.encode(data.toJson());

class UnitFinancialsModel {
    int? totalUnitSummaries;
    List<UnitSummary>? unitSummaries;
    String? currentPage;
    int? perPage;
    int? totalPages;

    UnitFinancialsModel({
        this.totalUnitSummaries,
        this.unitSummaries,
        this.currentPage,
        this.perPage,
        this.totalPages,
    });

    factory UnitFinancialsModel.fromJson(Map<String, dynamic> json) => UnitFinancialsModel(
        totalUnitSummaries: json["totalUnitSummaries"],
        unitSummaries: json["unit_summaries"] == null ? [] : List<UnitSummary>.from(json["unit_summaries"]!.map((x) => UnitSummary.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "totalUnitSummaries": totalUnitSummaries,
        "unit_summaries": unitSummaries == null ? [] : List<dynamic>.from(unitSummaries!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
    };
}

class UnitSummary {
    int? unitId;
    String? communityName;
    String? unitNumber;
    double? balance;

    UnitSummary({
        this.unitId,
        this.communityName,
        this.unitNumber,
        this.balance,
    });

    factory UnitSummary.fromJson(Map<String, dynamic> json) => UnitSummary(
        unitId: json["unit_id"],
        communityName: json["community_name"],
        unitNumber: json["unit_number"],
        balance: json["balance"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "unit_id": unitId,
        "community_name": communityName,
        "unit_number": unitNumber,
        "balance": balance,
    };
}
