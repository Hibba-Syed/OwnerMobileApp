// To parse this JSON data, do
//
//     final ownersModel = ownersModelFromJson(jsonString);

import 'dart:convert';

OwnersModel ownersModelFromJson(String str) =>
    OwnersModel.fromJson(json.decode(str));

String ownersModelToJson(OwnersModel data) => json.encode(data.toJson());

class OwnersModel {
  int? totalUnits;
  Units? units;
  int? currentPage;
  int? perPage;
  int? totalPages;

  OwnersModel({
    this.totalUnits,
    this.units,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory OwnersModel.fromJson(Map<String, dynamic> json) => OwnersModel(
        totalUnits: json["totalUnits"],
        units: json["units"] == null ? null : Units.fromJson(json["units"]),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "totalUnits": totalUnits,
        "units": units?.toJson(),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
      };
}

class Units {
  dynamic unitNumber;
  List<Owner>? owners;

  Units({
    this.unitNumber,
    this.owners,
  });

  factory Units.fromJson(Map<String, dynamic> json) => Units(
        unitNumber: json["unit_number"],
        owners: json["owners"] == null
            ? []
            : List<Owner>.from(json["owners"]!.map((x) => Owner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "unit_number": unitNumber,
        "owners": owners == null
            ? []
            : List<dynamic>.from(owners!.map((x) => x.toJson())),
      };
}

class Owner {
  Detail? detail;
  Documents? documents;

  Owner({
    this.detail,
    this.documents,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
        documents: json["documents"] == null
            ? null
            : Documents.fromJson(json["documents"]),
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "documents": documents?.toJson(),
      };
}

class Detail {
  String? name;
  int? isPrimary;
  String? arabicName;
  String? primaryEmail;
  String? secondaryEmail;
  String? primaryPhone;
  String? secondaryPhone;
  String? passportNumber;
  String? passportExpiry;
  String? emiratesIdNumber;
  String? emiratesIdExpiry;
  String? trnNumber;
  String? titleDeedNumber;
  String? dob;
  String? country;
  String? state;
  String? city;
  String? fullAddress;

  Detail({
    this.name,
    this.isPrimary,
    this.arabicName,
    this.primaryEmail,
    this.secondaryEmail,
    this.primaryPhone,
    this.secondaryPhone,
    this.passportNumber,
    this.passportExpiry,
    this.emiratesIdNumber,
    this.emiratesIdExpiry,
    this.trnNumber,
    this.titleDeedNumber,
    this.dob,
    this.country,
    this.state,
    this.city,
    this.fullAddress,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        name: json["name"],
        isPrimary: json["is_primary"],
        arabicName: json["arabic_name"],
        primaryEmail: json["primary_email"],
        secondaryEmail: json["secondary_email"],
        primaryPhone: json["primary_phone"],
        secondaryPhone: json["secondary_phone"],
        passportNumber: json["passport_number"],
        passportExpiry: json["passport_expiry"],
        emiratesIdNumber: json["emirates_id_number"],
        emiratesIdExpiry: json["emirates_id_expiry"],
        trnNumber: json["trn_number"],
        titleDeedNumber: json["title_deed_number"],
        dob: json["dob"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        fullAddress: json["full_address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_primary": isPrimary,
        "arabic_name": arabicName,
        "primary_email": primaryEmail,
        "secondary_email": secondaryEmail,
        "primary_phone": primaryPhone,
        "secondary_phone": secondaryPhone,
        "passport_number": passportNumber,
        "passport_expiry": passportExpiry,
        "emirates_id_number": emiratesIdNumber,
        "emirates_id_expiry": emiratesIdExpiry,
        "trn_number": trnNumber,
        "title_deed_number": titleDeedNumber,
        "dob": dob,
        "country": country,
        "state": state,
        "city": city,
        "full_address": fullAddress,
      };
}

class Documents {
  dynamic titleDeed;
  String? passportFile;
  dynamic idFile;

  Documents({
    this.titleDeed,
    this.passportFile,
    this.idFile,
  });

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        titleDeed: json["title_deed"],
        passportFile: json["passport_file"],
        idFile: json["id_file"],
      );

  Map<String, dynamic> toJson() => {
        "title_deed": titleDeed,
        "passport_file": passportFile,
        "id_file": idFile,
      };
}
