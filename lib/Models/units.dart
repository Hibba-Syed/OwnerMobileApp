// To parse this JSON data, do
//
//     final unitsModel = unitsModelFromJson(jsonString);

import 'dart:convert';

UnitsModel unitsModelFromJson(String str) =>
    UnitsModel.fromJson(json.decode(str));

String unitsModelToJson(UnitsModel data) => json.encode(data.toJson());

class UnitsModel {
  int? totalUnits;
  List<Unit>? units;
  String? currentPage;
  String? perPage;
  int? totalPages;

  UnitsModel({
    this.totalUnits,
    this.units,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory UnitsModel.fromJson(Map<String, dynamic> json) => UnitsModel(
        totalUnits: json["totalUnits"],
        units: json["units"] == null
            ? []
            : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
        currentPage: json["current_page"]?.toString(),
        perPage: json["per_page"]?.toString(),
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalUnits": totalUnits,
        "units": units == null
            ? []
            : List<dynamic>.from(units!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class Unit {
  String? name;
  String? slug;
  String? residentName;
  int? unitId;
  String? unitNumber;
  int? unitSizeSqft;
  int? bedroomCount;
  int? bathroomCount;
  int? parkings;
  double? unitCharges;
  double? unitPayment;
  double? unitBalance;
  bool? isLegalNoticeActive;
  bool? isRdcActive;

  Unit({
    this.name,
    this.slug,
    this.residentName,
    this.unitId,
    this.unitNumber,
    this.unitSizeSqft,
    this.bedroomCount,
    this.bathroomCount,
    this.parkings,
    this.unitCharges,
    this.unitPayment,
    this.unitBalance,
    this.isLegalNoticeActive,
    this.isRdcActive,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        name: json["name"],
        slug: json["slug"],
        residentName: json["resident_name"],
        unitId: json["unit_id"],
        unitNumber: json["unit_number"],
        unitSizeSqft: json["unit_size_sqft"],
        bedroomCount: json["bedroom_count"],
        bathroomCount: json["bathroom_count"],
        parkings: json["parkings"],
        unitCharges: json["unit_charges"]?.toDouble(),
        unitPayment: json["unit_payment"]?.toDouble(),
        unitBalance: json["unit_balance"]?.toDouble(),
        isLegalNoticeActive: json["is_legal_notice_active"],
        isRdcActive: json["is_rdc_active"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "resident_name": residentName,
        "unit_id": unitId,
        "unit_number": unitNumber,
        "unit_size_sqft": unitSizeSqft,
        "bedroom_count": bedroomCount,
        "bathroom_count": bathroomCount,
        "parkings": parkings,
        "unit_charges": unitCharges,
        "unit_payment": unitPayment,
        "unit_balance": unitBalance,
        "is_legal_notice_active": isLegalNoticeActive,
        "is_rdc_active": isRdcActive,
      };
}
