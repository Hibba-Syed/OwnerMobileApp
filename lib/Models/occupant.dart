// To parse this JSON data, do
//
//     final occupantModel = occupantModelFromJson(jsonString);

import 'dart:convert';

OccupantModel occupantModelFromJson(String str) =>
    OccupantModel.fromJson(json.decode(str));

String occupantModelToJson(OccupantModel data) => json.encode(data.toJson());

class OccupantModel {
  Occupant? occupant;

  OccupantModel({
    this.occupant,
  });

  factory OccupantModel.fromJson(Map<String, dynamic> json) => OccupantModel(
        occupant: json["occupant"] == null
            ? null
            : Occupant.fromJson(json["occupant"]),
      );

  Map<String, dynamic> toJson() => {
        "occupant": occupant?.toJson(),
      };
}

class Occupant {
  Details? details;
  EmergencyContactDetails? emergencyContactDetails;
  List? vehicles;
  Documents? documents;

  Occupant({
    this.details,
    this.emergencyContactDetails,
    this.vehicles,
    this.documents,
  });

  factory Occupant.fromJson(Map<String, dynamic> json) => Occupant(
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        emergencyContactDetails: json["emergency_contact_details"] == null
            ? null
            : EmergencyContactDetails.fromJson(
                json["emergency_contact_details"]),
        vehicles: json["vehicles"],
        documents: json["documents"] == null
            ? null
            : Documents.fromJson(json["documents"]),
      );

  Map<String, dynamic> toJson() => {
        "details": details?.toJson(),
        "emergency_contact_details": emergencyContactDetails?.toJson(),
        "vehicles": vehicles,
        "documents": documents?.toJson(),
      };
}

class Details {
  String? name;
  String? primaryEmail;
  String? primaryPhone;
  String? passportNumber;
  DateTime? passportExpiry;
  String? emiratesIdNumber;
  DateTime? emiratesIdExpiry;
  String? trnNumber;
  DateTime? dob;
  DateTime? tenancyContractExpiry;
  String? titleDeedNumber;
  String? country;
  String? state;
  String? city;
  String? fullAddress;
  String? type;

  Details({
    this.name,
    this.primaryEmail,
    this.primaryPhone,
    this.passportNumber,
    this.passportExpiry,
    this.emiratesIdNumber,
    this.emiratesIdExpiry,
    this.type,
    this.trnNumber,
    this.dob,
    this.tenancyContractExpiry,
    this.titleDeedNumber,
    this.country,
    this.state,
    this.city,
    this.fullAddress,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        name: json["name"],
        primaryEmail: json["primary_email"],
        primaryPhone: json["primary_phone"],
        passportNumber: json["passport_number"],
        passportExpiry: json["passport_expiry"] == null
            ? null
            : DateTime.parse(json["passport_expiry"]),
        emiratesIdNumber: json["emirates_id_number"],
        emiratesIdExpiry: json["emirates_id_expiry"] == null
            ? null
            : DateTime.parse(json["emirates_id_expiry"]),
        trnNumber: json["trn_number"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        tenancyContractExpiry: json["tenancy_contract_expiry"] == null
            ? null
            : DateTime.parse(json["tenancy_contract_expiry"]),
        titleDeedNumber: json["title_deed_number"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        fullAddress: json["full_address"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "primary_email": primaryEmail,
        "primary_phone": primaryPhone,
        "passport_number": passportNumber,
        "passport_expiry":
            "${passportExpiry!.year.toString().padLeft(4, '0')}-${passportExpiry!.month.toString().padLeft(2, '0')}-${passportExpiry!.day.toString().padLeft(2, '0')}",
        "emirates_id_number": emiratesIdNumber,
        "emirates_id_expiry":
            "${emiratesIdExpiry!.year.toString().padLeft(4, '0')}-${emiratesIdExpiry!.month.toString().padLeft(2, '0')}-${emiratesIdExpiry!.day.toString().padLeft(2, '0')}",
        "trn_number": trnNumber,
        "dob": dob,
        "tenancy_contract_expiry":
            "${tenancyContractExpiry!.year.toString().padLeft(4, '0')}-${tenancyContractExpiry!.month.toString().padLeft(2, '0')}-${tenancyContractExpiry!.day.toString().padLeft(2, '0')}",
        "title_deed_number": titleDeedNumber,
        "country": country,
        "state": state,
        "city": city,
        "full_address": fullAddress,
        "type": type,
      };
}

class Documents {
  String? titleDeed;
  String? tenancyContract;
  String? passportFile;
  String? idFile;

  Documents({
    this.titleDeed,
    this.tenancyContract,
    this.passportFile,
    this.idFile,
  });

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        titleDeed: json["title_deed"],
        tenancyContract: json["tenancy_contract"],
        passportFile: json["passport_file"],
        idFile: json["id_file"],
      );

  Map<String, dynamic> toJson() => {
        "title_deed": titleDeed,
        "tenancy_contract": tenancyContract,
        "passport_file": passportFile,
        "id_file": idFile,
      };
}

class EmergencyContactDetails {
  String? emergencyContactName;
  String? emergencyContactPhone;
  String? alternativeEmergencyContactName;
  String? alternativeEmergencyContactPhone;

  EmergencyContactDetails({
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.alternativeEmergencyContactName,
    this.alternativeEmergencyContactPhone,
  });

  factory EmergencyContactDetails.fromJson(Map<String, dynamic> json) =>
      EmergencyContactDetails(
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactPhone: json["emergency_contact_phone"],
        alternativeEmergencyContactName:
            json["alternative_emergency_contact_name"],
        alternativeEmergencyContactPhone:
            json["alternative_emergency_contact_phone"],
      );

  Map<String, dynamic> toJson() => {
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_phone": emergencyContactPhone,
        "alternative_emergency_contact_name": alternativeEmergencyContactName,
        "alternative_emergency_contact_phone": alternativeEmergencyContactPhone,
      };
}
