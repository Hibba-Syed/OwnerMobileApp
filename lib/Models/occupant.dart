// To parse this JSON data, do
//
//     final occupantModel = occupantModelFromJson(jsonString);

import 'dart:convert';

OccupantModel occupantModelFromJson(String str) => OccupantModel.fromJson(json.decode(str));

String occupantModelToJson(OccupantModel data) => json.encode(data.toJson());

class OccupantModel {
    Occupant? occupant;

    OccupantModel({
        this.occupant,
    });

    factory OccupantModel.fromJson(Map<String, dynamic> json) => OccupantModel(
        occupant: json["occupant"] == null ? null : Occupant.fromJson(json["occupant"]),
    );

    Map<String, dynamic> toJson() => {
        "occupant": occupant?.toJson(),
    };
}

class Occupant {
    Details? details;
    EmergencyContactDetails? emergencyContactDetails;
    List<dynamic>? vehicles;
    List<Document>? documents;

    Occupant({
        this.details,
        this.emergencyContactDetails,
        this.vehicles,
        this.documents,
    });

    factory Occupant.fromJson(Map<String, dynamic> json) => Occupant(
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
        emergencyContactDetails: json["emergency_contact_details"] == null ? null : EmergencyContactDetails.fromJson(json["emergency_contact_details"]),
        vehicles: json["vehicles"] == null ? [] : List<dynamic>.from(json["vehicles"]!.map((x) => x)),
        documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "details": details?.toJson(),
        "emergency_contact_details": emergencyContactDetails?.toJson(),
        "vehicles": vehicles == null ? [] : List<dynamic>.from(vehicles!.map((x) => x)),
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
    };
}

class Details {
    String? name;
    dynamic primaryEmail;
    dynamic primaryPhone;
    dynamic passportNumber;
    dynamic passportExpiry;
    dynamic emiratesIdNumber;
    dynamic emiratesIdExpiry;
    dynamic trnNumber;
    String? type;
    dynamic dob;
    DateTime? tenancyContractExpiry;
    String? titleDeedNumber;
    dynamic country;
    dynamic state;
    String? city;
    String? fullAddress;

    Details({
        this.name,
        this.primaryEmail,
        this.primaryPhone,
        this.passportNumber,
        this.passportExpiry,
        this.emiratesIdNumber,
        this.emiratesIdExpiry,
        this.trnNumber,
        this.type,
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
        passportExpiry: json["passport_expiry"],
        emiratesIdNumber: json["emirates_id_number"],
        emiratesIdExpiry: json["emirates_id_expiry"],
        trnNumber: json["trn_number"],
        type: json["type"],
        dob: json["dob"],
        tenancyContractExpiry: json["tenancy_contract_expiry"] == null ? null : DateTime.parse(json["tenancy_contract_expiry"]),
        titleDeedNumber: json["title_deed_number"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        fullAddress: json["full_address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "primary_email": primaryEmail,
        "primary_phone": primaryPhone,
        "passport_number": passportNumber,
        "passport_expiry": passportExpiry,
        "emirates_id_number": emiratesIdNumber,
        "emirates_id_expiry": emiratesIdExpiry,
        "trn_number": trnNumber,
        "type": type,
        "dob": dob,
        "tenancy_contract_expiry": "${tenancyContractExpiry!.year.toString().padLeft(4, '0')}-${tenancyContractExpiry!.month.toString().padLeft(2, '0')}-${tenancyContractExpiry!.day.toString().padLeft(2, '0')}",
        "title_deed_number": titleDeedNumber,
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

class EmergencyContactDetails {
    String? emergencyContactName;
    dynamic emergencyContactPhone;
    dynamic alternativeEmergencyContactName;
    dynamic alternativeEmergencyContactPhone;

    EmergencyContactDetails({
        this.emergencyContactName,
        this.emergencyContactPhone,
        this.alternativeEmergencyContactName,
        this.alternativeEmergencyContactPhone,
    });

    factory EmergencyContactDetails.fromJson(Map<String, dynamic> json) => EmergencyContactDetails(
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactPhone: json["emergency_contact_phone"],
        alternativeEmergencyContactName: json["alternative_emergency_contact_name"],
        alternativeEmergencyContactPhone: json["alternative_emergency_contact_phone"],
    );

    Map<String, dynamic> toJson() => {
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_phone": emergencyContactPhone,
        "alternative_emergency_contact_name": alternativeEmergencyContactName,
        "alternative_emergency_contact_phone": alternativeEmergencyContactPhone,
    };
}
