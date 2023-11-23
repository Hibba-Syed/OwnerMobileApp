// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoggedInOwner? owner;
  String? tokenType;
  int? expiresIn;
  String? accessToken;

  LoginModel({
    this.owner,
    this.tokenType,
    this.expiresIn,
    this.accessToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        owner: json["owner"] == null
            ? null
            : LoggedInOwner.fromJson(json["owner"]),
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner?.toJson(),
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
      };
}

class LoggedInOwner {
  int? id;
  int? companyId;
  String? firstName;
  String? lastName;
  dynamic arabicName;
  String? type;
  String? participantType;
  String? email;
  String? mobile;
  String? primaryEmail;
  dynamic secondaryEmail;
  String? primaryPhone;
  String? secondaryPhone;
  String? deviceToken;
  String? deviceType;
  dynamic address1;
  dynamic address2;
  dynamic stateId;
  dynamic cityId;
  dynamic countryId;
  dynamic postalCode;
  dynamic comments;
  dynamic dob;
  dynamic licenseNumber;
  dynamic tradeLicense;
  dynamic tradeLicenseExpiry;
  dynamic idFile;
  dynamic idExpiry;
  dynamic idType;
  dynamic idNumber;
  dynamic emiratesIdNumber;
  String? emiratesIdFile;
  dynamic emiratesIdExpiry;
  dynamic passportNumber;
  String? passportFile;
  dynamic passportExpiry;
  dynamic visaFile;
  dynamic emergencyContactName;
  dynamic emergencyContactEmail;
  dynamic emergencyContactPhone;
  dynamic alternativeEmergencyContactName;
  dynamic alternativeEmergencyContactPhone;
  dynamic alternativeEmergencyContactEmail;
  dynamic titleDeed;
  dynamic agentDocName;
  dynamic agentDocPath;
  dynamic tenancyContract;
  dynamic contractNumber;
  dynamic tenancyContractExpiry;
  dynamic tenancyStartDate;
  dynamic citizenship;
  int? isActive;
  String? ownerNumber;
  dynamic titleDeedNumber;
  String? trnNumber;
  dynamic profilePicture;
  int? isLogged;
  dynamic ownerExternalId;
  int? isPushed;
  dynamic loginAt;
  String? view;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? fullName;
  String? idFileUrl;
  String? titleDeedUrl;
  String? tenancyContractUrl;
  String? tradeLicenseUrl;
  String? passportFileUrl;
  String? emiratesIdFileUrl;
  String? profileImageUrl;
  String? fullAddress;
  String? agentDocUrl;
  Company? company;

  LoggedInOwner({
    this.id,
    this.companyId,
    this.firstName,
    this.lastName,
    this.arabicName,
    this.type,
    this.participantType,
    this.email,
    this.mobile,
    this.primaryEmail,
    this.secondaryEmail,
    this.primaryPhone,
    this.secondaryPhone,
    this.deviceToken,
    this.deviceType,
    this.address1,
    this.address2,
    this.stateId,
    this.cityId,
    this.countryId,
    this.postalCode,
    this.comments,
    this.dob,
    this.licenseNumber,
    this.tradeLicense,
    this.tradeLicenseExpiry,
    this.idFile,
    this.idExpiry,
    this.idType,
    this.idNumber,
    this.emiratesIdNumber,
    this.emiratesIdFile,
    this.emiratesIdExpiry,
    this.passportNumber,
    this.passportFile,
    this.passportExpiry,
    this.visaFile,
    this.emergencyContactName,
    this.emergencyContactEmail,
    this.emergencyContactPhone,
    this.alternativeEmergencyContactName,
    this.alternativeEmergencyContactPhone,
    this.alternativeEmergencyContactEmail,
    this.titleDeed,
    this.agentDocName,
    this.agentDocPath,
    this.tenancyContract,
    this.contractNumber,
    this.tenancyContractExpiry,
    this.tenancyStartDate,
    this.citizenship,
    this.isActive,
    this.ownerNumber,
    this.titleDeedNumber,
    this.trnNumber,
    this.profilePicture,
    this.isLogged,
    this.ownerExternalId,
    this.isPushed,
    this.loginAt,
    this.view,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.fullName,
    this.idFileUrl,
    this.titleDeedUrl,
    this.tenancyContractUrl,
    this.tradeLicenseUrl,
    this.passportFileUrl,
    this.emiratesIdFileUrl,
    this.profileImageUrl,
    this.fullAddress,
    this.agentDocUrl,
    this.company,
  });

  factory LoggedInOwner.fromJson(Map<String, dynamic> json) => LoggedInOwner(
        id: json["id"],
        companyId: json["company_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        arabicName: json["arabic_name"],
        type: json["type"],
        participantType: json["participant_type"],
        email: json["email"],
        mobile: json["mobile"],
        primaryEmail: json["primary_email"],
        secondaryEmail: json["secondary_email"],
        primaryPhone: json["primary_phone"],
        secondaryPhone: json["secondary_phone"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        address1: json["address1"],
        address2: json["address2"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        countryId: json["country_id"],
        postalCode: json["postal_code"],
        comments: json["comments"],
        dob: json["dob"],
        licenseNumber: json["license_number"],
        tradeLicense: json["trade_license"],
        tradeLicenseExpiry: json["trade_license_expiry"],
        idFile: json["id_file"],
        idExpiry: json["id_expiry"],
        idType: json["id_type"],
        idNumber: json["id_number"],
        emiratesIdNumber: json["emirates_id_number"],
        emiratesIdFile: json["emirates_id_file"],
        emiratesIdExpiry: json["emirates_id_expiry"],
        passportNumber: json["passport_number"],
        passportFile: json["passport_file"],
        passportExpiry: json["passport_expiry"],
        visaFile: json["visa_file"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactEmail: json["emergency_contact_email"],
        emergencyContactPhone: json["emergency_contact_phone"],
        alternativeEmergencyContactName:
            json["alternative_emergency_contact_name"],
        alternativeEmergencyContactPhone:
            json["alternative_emergency_contact_phone"],
        alternativeEmergencyContactEmail:
            json["alternative_emergency_contact_email"],
        titleDeed: json["title_deed"],
        agentDocName: json["agent_doc_name"],
        agentDocPath: json["agent_doc_path"],
        tenancyContract: json["tenancy_contract"],
        contractNumber: json["contract_number"],
        tenancyContractExpiry: json["tenancy_contract_expiry"],
        tenancyStartDate: json["tenancy_start_date"],
        citizenship: json["citizenship"],
        isActive: json["is_active"],
        ownerNumber: json["owner_number"],
        titleDeedNumber: json["title_deed_number"],
        trnNumber: json["trn_number"],
        profilePicture: json["profile_picture"],
        isLogged: json["is_logged"],
        ownerExternalId: json["owner_external_id"],
        isPushed: json["is_pushed"],
        loginAt: json["login_at"],
        view: json["view"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        fullName: json["full_name"],
        idFileUrl: json["id_file_url"],
        titleDeedUrl: json["title_deed_url"],
        tenancyContractUrl: json["tenancy_contract_url"],
        tradeLicenseUrl: json["trade_license_url"],
        passportFileUrl: json["passport_file_url"],
        emiratesIdFileUrl: json["emirates_id_file_url"],
        profileImageUrl: json["profile_image_url"],
        fullAddress: json["full_address"],
        agentDocUrl: json["agent_doc_url"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "first_name": firstName,
        "last_name": lastName,
        "arabic_name": arabicName,
        "type": type,
        "participant_type": participantType,
        "email": email,
        "mobile": mobile,
        "primary_email": primaryEmail,
        "secondary_email": secondaryEmail,
        "primary_phone": primaryPhone,
        "secondary_phone": secondaryPhone,
        "device_token": deviceToken,
        "device_type": deviceType,
        "address1": address1,
        "address2": address2,
        "state_id": stateId,
        "city_id": cityId,
        "country_id": countryId,
        "postal_code": postalCode,
        "comments": comments,
        "dob": dob,
        "license_number": licenseNumber,
        "trade_license": tradeLicense,
        "trade_license_expiry": tradeLicenseExpiry,
        "id_file": idFile,
        "id_expiry": idExpiry,
        "id_type": idType,
        "id_number": idNumber,
        "emirates_id_number": emiratesIdNumber,
        "emirates_id_file": emiratesIdFile,
        "emirates_id_expiry": emiratesIdExpiry,
        "passport_number": passportNumber,
        "passport_file": passportFile,
        "passport_expiry": passportExpiry,
        "visa_file": visaFile,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_email": emergencyContactEmail,
        "emergency_contact_phone": emergencyContactPhone,
        "alternative_emergency_contact_name": alternativeEmergencyContactName,
        "alternative_emergency_contact_phone": alternativeEmergencyContactPhone,
        "alternative_emergency_contact_email": alternativeEmergencyContactEmail,
        "title_deed": titleDeed,
        "agent_doc_name": agentDocName,
        "agent_doc_path": agentDocPath,
        "tenancy_contract": tenancyContract,
        "contract_number": contractNumber,
        "tenancy_contract_expiry": tenancyContractExpiry,
        "tenancy_start_date": tenancyStartDate,
        "citizenship": citizenship,
        "is_active": isActive,
        "owner_number": ownerNumber,
        "title_deed_number": titleDeedNumber,
        "trn_number": trnNumber,
        "profile_picture": profilePicture,
        "is_logged": isLogged,
        "owner_external_id": ownerExternalId,
        "is_pushed": isPushed,
        "login_at": loginAt,
        "view": view,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "full_name": fullName,
        "id_file_url": idFileUrl,
        "title_deed_url": titleDeedUrl,
        "tenancy_contract_url": tenancyContractUrl,
        "trade_license_url": tradeLicenseUrl,
        "passport_file_url": passportFileUrl,
        "emirates_id_file_url": emiratesIdFileUrl,
        "profile_image_url": profileImageUrl,
        "full_address": fullAddress,
        "agent_doc_url": agentDocUrl,
        "company": company?.toJson(),
      };
}

class Company {
  int? id;
  String? companyName;
  int? isBlocked;
  double? rating;
  String? logoUrl;
  String? jpgLogoUrl;
  String? faviconUrl;
  String? backgroundImageUrl;
  String? trnCertificateUrl;
  String? licenseCopyUrl;
  bool? hasPendingCreditNotes;
  int? paymentGatewayEnabled;
  bool? smsGatewayEnabled;
  dynamic subdomain;
  String? fullAddress;
  int? isBilled;
  List<dynamic>? offDays;
  dynamic user;

  Company({
    this.id,
    this.companyName,
    this.isBlocked,
    this.rating,
    this.logoUrl,
    this.jpgLogoUrl,
    this.faviconUrl,
    this.backgroundImageUrl,
    this.trnCertificateUrl,
    this.licenseCopyUrl,
    this.hasPendingCreditNotes,
    this.paymentGatewayEnabled,
    this.smsGatewayEnabled,
    this.subdomain,
    this.fullAddress,
    this.isBilled,
    this.offDays,
    this.user,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        companyName: json["company_name"],
        isBlocked: json["is_blocked"],
        rating: json["rating"]?.toDouble(),
        logoUrl: json["logo_url"],
        jpgLogoUrl: json["jpg_logo_url"],
        faviconUrl: json["favicon_url"],
        backgroundImageUrl: json["background_image_url"],
        trnCertificateUrl: json["trn_certificate_url"],
        licenseCopyUrl: json["license_copy_url"],
        hasPendingCreditNotes: json["has_pending_credit_notes"],
        paymentGatewayEnabled: json["payment_gateway_enabled"],
        smsGatewayEnabled: json["sms_gateway_enabled"],
        subdomain: json["subdomain"],
        fullAddress: json["full_address"],
        isBilled: json["is_billed"],
        offDays: json["off_days"] == null
            ? []
            : List<dynamic>.from(json["off_days"]!.map((x) => x)),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "is_blocked": isBlocked,
        "rating": rating,
        "logo_url": logoUrl,
        "jpg_logo_url": jpgLogoUrl,
        "favicon_url": faviconUrl,
        "background_image_url": backgroundImageUrl,
        "trn_certificate_url": trnCertificateUrl,
        "license_copy_url": licenseCopyUrl,
        "has_pending_credit_notes": hasPendingCreditNotes,
        "payment_gateway_enabled": paymentGatewayEnabled,
        "sms_gateway_enabled": smsGatewayEnabled,
        "subdomain": subdomain,
        "full_address": fullAddress,
        "is_billed": isBilled,
        "off_days":
            offDays == null ? [] : List<dynamic>.from(offDays!.map((x) => x)),
        "user": user,
      };
}
