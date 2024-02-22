// To parse this JSON data, do
//
//     final ownersModel = ownersModelFromJson(jsonString);

import 'dart:convert';

OwnersModel ownersModelFromJson(String str) => OwnersModel.fromJson(json.decode(str));

String ownersModelToJson(OwnersModel data) => json.encode(data.toJson());

class OwnersModel {
    int? totalUnitOwners;
    Units? units;
    int? currentPage;
    int? perPage;
    int? totalPages;

    OwnersModel({
        this.totalUnitOwners,
        this.units,
        this.currentPage,
        this.perPage,
        this.totalPages,
    });

    factory OwnersModel.fromJson(Map<String, dynamic> json) => OwnersModel(
        totalUnitOwners: json["totalUnitOwners"],
        units: json["units"] == null ? null : Units.fromJson(json["units"]),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "totalUnitOwners": totalUnitOwners,
        "units": units?.toJson(),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
    };
}

class Units {
    String? unitNumber;
    List<Owner>? owners;

    Units({
        this.unitNumber,
        this.owners,
    });

    factory Units.fromJson(Map<String, dynamic> json) => Units(
        unitNumber: json["unit_number"],
        owners: json["owners"] == null ? [] : List<Owner>.from(json["owners"]!.map((x) => Owner.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "unit_number": unitNumber,
        "owners": owners == null ? [] : List<dynamic>.from(owners!.map((x) => x.toJson())),
    };
}

class Owner {
    Detail? detail;
    List<Document>? documents;

    Owner({
        this.detail,
        this.documents,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
        documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
    };
}

class Detail {
    int? id;
    String? name;
    int? isPrimary;
    String? arabicName;
    String? mollakOwnerNumber;
    String? primaryEmail;
    String? secondaryEmail;
    String? primaryPhone;
    String? secondaryPhone;
    String? passportNumber;
    DateTime? passportExpiry;
    String? emiratesIdNumber;
    dynamic emiratesIdExpiry;
    String? trnNumber;
    String? titleDeedNumber;
    DateTime? dob;
    String? country;
    String? state;
    String? city;
    String? fullAddress;

    Detail({
        this.id,
        this.name,
        this.isPrimary,
        this.arabicName,
        this.mollakOwnerNumber,
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
        id: json["id"],
        name: json["name"],
        isPrimary: json["is_primary"],
        arabicName: json["arabic_name"],
        mollakOwnerNumber: json["mollak_owner_number"],
        primaryEmail: json["primary_email"],
        secondaryEmail: json["secondary_email"],
        primaryPhone: json["primary_phone"],
        secondaryPhone: json["secondary_phone"],
        passportNumber: json["passport_number"],
        passportExpiry: json["passport_expiry"] == null ? null : DateTime.parse(json["passport_expiry"]),
        emiratesIdNumber: json["emirates_id_number"],
        emiratesIdExpiry: json["emirates_id_expiry"],
        trnNumber: json["trn_number"],
        titleDeedNumber: json["title_deed_number"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        country: json["country"],
        state: json["state"],
        city: json["city"],
        fullAddress: json["full_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_primary": isPrimary,
        "arabic_name": arabicName,
        "mollak_owner_number": mollakOwnerNumber,
        "primary_email": primaryEmail,
        "secondary_email": secondaryEmail,
        "primary_phone": primaryPhone,
        "secondary_phone": secondaryPhone,
        "passport_number": passportNumber,
        "passport_expiry": "${passportExpiry!.year.toString().padLeft(4, '0')}-${passportExpiry!.month.toString().padLeft(2, '0')}-${passportExpiry!.day.toString().padLeft(2, '0')}",
        "emirates_id_number": emiratesIdNumber,
        "emirates_id_expiry": emiratesIdExpiry,
        "trn_number": trnNumber,
        "title_deed_number": titleDeedNumber,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "country": country,
        "state": state,
        "city": city,
        "full_address": fullAddress,
    };
}

class Document {
    String? name;
    String? url;

    Document({
        this.name,
        this.url,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
