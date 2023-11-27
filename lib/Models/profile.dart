// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  ProfileModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        record: json["record"] == null ? null : Record.fromJson(json["record"]),
        code: json["code"],
        meta: json["meta"],
        requestStatus: json["request_status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": record?.toJson(),
        "code": code,
        "meta": meta,
        "request_status": requestStatus,
        "message": message,
      };
}

class Record {
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

  Record({
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

  factory Record.fromJson(Map<String, dynamic> json) => Record(
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
  String? type;
  int? userId;
  int? currencyId;
  int? timezoneId;
  String? slug;
  String? companyName;
  String? oaId;
  String? name;
  String? arabicName;
  String? contactNumber;
  String? contactEmail;
  String? communicationEmail;
  String? address1;
  dynamic address2;
  String? postcode;
  String? backgroundImage;
  String? logo;
  int? cityId;
  int? stateId;
  int? countryId;
  dynamic noOfEmployees;
  String? website;
  int? status;
  String? callCenterNumber;
  String? callCenterCompany;
  int? callCenterStatus;
  int? isSetup;
  dynamic licenseNumber;
  dynamic licenseIssueAuthority;
  dynamic licenseCopy;
  dynamic licenseExpiry;
  dynamic licenseIssueDate;
  dynamic licenseCancelDate;
  dynamic serialNo;
  int? isRegistered;
  int? credits;
  String? trnNumber;
  dynamic trnCertificate;
  int? noTrn;
  String? latitude;
  String? longitude;
  dynamic subscribedUnitCount;
  String? subscriptionCycle;
  int? isBlocked;
  dynamic inviterId;
  String? consumerId;
  String? ejariId;
  int? isMollakEnable;
  dynamic mollakCompanyId;
  int? autoPushReceipts;
  int? taxRate;
  int? pricingId;
  String? subscriptionStatus;
  int? enableModules;
  int? disableTime;
  dynamic disableComment;
  dynamic extendedUntil;
  DateTime? billStart;
  int? isIskaan;
  int? isProvider;
  dynamic parentId;
  int? isOwnerLoginEnabled;
  int? showOwnerInvoices;
  int? showOwnerReceipts;
  int? isRfpPriceHidden;
  String? workSchedule;
  dynamic verificationDate;
  dynamic uwAccountId;
  String? favicon;
  String? shortName;
  String? description;
  String? themeColor;
  String? backgroundColor;
  String? textColor;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
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
  String? subdomain;
  String? fullAddress;
  int? isBilled;
  List<int>? offDays;
  User? user;

  Company({
    this.id,
    this.type,
    this.userId,
    this.currencyId,
    this.timezoneId,
    this.slug,
    this.companyName,
    this.oaId,
    this.name,
    this.arabicName,
    this.contactNumber,
    this.contactEmail,
    this.communicationEmail,
    this.address1,
    this.address2,
    this.postcode,
    this.backgroundImage,
    this.logo,
    this.cityId,
    this.stateId,
    this.countryId,
    this.noOfEmployees,
    this.website,
    this.status,
    this.callCenterNumber,
    this.callCenterCompany,
    this.callCenterStatus,
    this.isSetup,
    this.licenseNumber,
    this.licenseIssueAuthority,
    this.licenseCopy,
    this.licenseExpiry,
    this.licenseIssueDate,
    this.licenseCancelDate,
    this.serialNo,
    this.isRegistered,
    this.credits,
    this.trnNumber,
    this.trnCertificate,
    this.noTrn,
    this.latitude,
    this.longitude,
    this.subscribedUnitCount,
    this.subscriptionCycle,
    this.isBlocked,
    this.inviterId,
    this.consumerId,
    this.ejariId,
    this.isMollakEnable,
    this.mollakCompanyId,
    this.autoPushReceipts,
    this.taxRate,
    this.pricingId,
    this.subscriptionStatus,
    this.enableModules,
    this.disableTime,
    this.disableComment,
    this.extendedUntil,
    this.billStart,
    this.isIskaan,
    this.isProvider,
    this.parentId,
    this.isOwnerLoginEnabled,
    this.showOwnerInvoices,
    this.showOwnerReceipts,
    this.isRfpPriceHidden,
    this.workSchedule,
    this.verificationDate,
    this.uwAccountId,
    this.favicon,
    this.shortName,
    this.description,
    this.themeColor,
    this.backgroundColor,
    this.textColor,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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
        type: json["type"],
        userId: json["user_id"],
        currencyId: json["currency_id"],
        timezoneId: json["timezone_id"],
        slug: json["slug"],
        companyName: json["company_name"],
        oaId: json["oa_id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        contactNumber: json["contact_number"],
        contactEmail: json["contact_email"],
        communicationEmail: json["communication_email"],
        address1: json["address_1"],
        address2: json["address_2"],
        postcode: json["postcode"],
        backgroundImage: json["background_image"],
        logo: json["logo"],
        cityId: json["city_id"],
        stateId: json["state_id"],
        countryId: json["country_id"],
        noOfEmployees: json["no_of_employees"],
        website: json["website"],
        status: json["status"],
        callCenterNumber: json["call_center_number"],
        callCenterCompany: json["call_center_company"],
        callCenterStatus: json["call_center_status"],
        isSetup: json["is_setup"],
        licenseNumber: json["license_number"],
        licenseIssueAuthority: json["license_issue_authority"],
        licenseCopy: json["license_copy"],
        licenseExpiry: json["license_expiry"],
        licenseIssueDate: json["license_issue_date"],
        licenseCancelDate: json["license_cancel_date"],
        serialNo: json["serial_no"],
        isRegistered: json["is_registered"],
        credits: json["credits"],
        trnNumber: json["trn_number"],
        trnCertificate: json["trn_certificate"],
        noTrn: json["no_trn"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        subscribedUnitCount: json["subscribed_unit_count"],
        subscriptionCycle: json["subscription_cycle"],
        isBlocked: json["is_blocked"],
        inviterId: json["inviter_id"],
        consumerId: json["consumer_id"],
        ejariId: json["ejari_id"],
        isMollakEnable: json["is_mollak_enable"],
        mollakCompanyId: json["mollak_company_id"],
        autoPushReceipts: json["auto_push_receipts"],
        taxRate: json["tax_rate"],
        pricingId: json["pricing_id"],
        subscriptionStatus: json["subscription_status"],
        enableModules: json["enable_modules"],
        disableTime: json["disable_time"],
        disableComment: json["disable_comment"],
        extendedUntil: json["extended_until"],
        billStart: json["bill_start"] == null
            ? null
            : DateTime.parse(json["bill_start"]),
        isIskaan: json["is_iskaan"],
        isProvider: json["is_provider"],
        parentId: json["parent_id"],
        isOwnerLoginEnabled: json["is_owner_login_enabled"],
        showOwnerInvoices: json["show_owner_invoices"],
        showOwnerReceipts: json["show_owner_receipts"],
        isRfpPriceHidden: json["is_rfp_price_hidden"],
        workSchedule: json["work_schedule"],
        verificationDate: json["verification_date"],
        uwAccountId: json["uw_account_id"],
        favicon: json["favicon"],
        shortName: json["short_name"],
        description: json["description"],
        themeColor: json["theme_color"],
        backgroundColor: json["background_color"],
        textColor: json["text_color"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
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
            : List<int>.from(json["off_days"]!.map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "user_id": userId,
        "currency_id": currencyId,
        "timezone_id": timezoneId,
        "slug": slug,
        "company_name": companyName,
        "oa_id": oaId,
        "name": name,
        "arabic_name": arabicName,
        "contact_number": contactNumber,
        "contact_email": contactEmail,
        "communication_email": communicationEmail,
        "address_1": address1,
        "address_2": address2,
        "postcode": postcode,
        "background_image": backgroundImage,
        "logo": logo,
        "city_id": cityId,
        "state_id": stateId,
        "country_id": countryId,
        "no_of_employees": noOfEmployees,
        "website": website,
        "status": status,
        "call_center_number": callCenterNumber,
        "call_center_company": callCenterCompany,
        "call_center_status": callCenterStatus,
        "is_setup": isSetup,
        "license_number": licenseNumber,
        "license_issue_authority": licenseIssueAuthority,
        "license_copy": licenseCopy,
        "license_expiry": licenseExpiry,
        "license_issue_date": licenseIssueDate,
        "license_cancel_date": licenseCancelDate,
        "serial_no": serialNo,
        "is_registered": isRegistered,
        "credits": credits,
        "trn_number": trnNumber,
        "trn_certificate": trnCertificate,
        "no_trn": noTrn,
        "latitude": latitude,
        "longitude": longitude,
        "subscribed_unit_count": subscribedUnitCount,
        "subscription_cycle": subscriptionCycle,
        "is_blocked": isBlocked,
        "inviter_id": inviterId,
        "consumer_id": consumerId,
        "ejari_id": ejariId,
        "is_mollak_enable": isMollakEnable,
        "mollak_company_id": mollakCompanyId,
        "auto_push_receipts": autoPushReceipts,
        "tax_rate": taxRate,
        "pricing_id": pricingId,
        "subscription_status": subscriptionStatus,
        "enable_modules": enableModules,
        "disable_time": disableTime,
        "disable_comment": disableComment,
        "extended_until": extendedUntil,
        "bill_start":
            "${billStart!.year.toString().padLeft(4, '0')}-${billStart!.month.toString().padLeft(2, '0')}-${billStart!.day.toString().padLeft(2, '0')}",
        "is_iskaan": isIskaan,
        "is_provider": isProvider,
        "parent_id": parentId,
        "is_owner_login_enabled": isOwnerLoginEnabled,
        "show_owner_invoices": showOwnerInvoices,
        "show_owner_receipts": showOwnerReceipts,
        "is_rfp_price_hidden": isRfpPriceHidden,
        "work_schedule": workSchedule,
        "verification_date": verificationDate,
        "uw_account_id": uwAccountId,
        "favicon": favicon,
        "short_name": shortName,
        "description": description,
        "theme_color": themeColor,
        "background_color": backgroundColor,
        "text_color": textColor,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
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
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? reference;
  dynamic username;
  int? roleId;
  int? userTypeId;
  String? email;
  int? status;
  String? firstName;
  String? lastName;
  String? mobile;
  String? designation;
  dynamic profilePicture;
  DateTime? dob;
  String? passportNumber;
  DateTime? passportExpiry;
  String? emiratesId;
  DateTime? emiratesIdExpiry;
  dynamic idFile;
  int? isEmailVerified;
  int? isMobileVerified;
  int? isBlocked;
  String? organizationName;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? companyId;
  String? view;
  int? canViewAll;
  String? intercomHash;
  int? pcLimit;
  dynamic deviceToken;
  dynamic deviceType;
  String? fullName;
  int? isCompanyAvailable;
  String? profileImageUrl;
  List<dynamic>? myCityAssociations;
  String? idFileUrl;

  User({
    this.id,
    this.reference,
    this.username,
    this.roleId,
    this.userTypeId,
    this.email,
    this.status,
    this.firstName,
    this.lastName,
    this.mobile,
    this.designation,
    this.profilePicture,
    this.dob,
    this.passportNumber,
    this.passportExpiry,
    this.emiratesId,
    this.emiratesIdExpiry,
    this.idFile,
    this.isEmailVerified,
    this.isMobileVerified,
    this.isBlocked,
    this.organizationName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.view,
    this.canViewAll,
    this.intercomHash,
    this.pcLimit,
    this.deviceToken,
    this.deviceType,
    this.fullName,
    this.isCompanyAvailable,
    this.profileImageUrl,
    this.myCityAssociations,
    this.idFileUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        reference: json["reference"],
        username: json["username"],
        roleId: json["role_id"],
        userTypeId: json["user_type_id"],
        email: json["email"],
        status: json["status"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        designation: json["designation"],
        profilePicture: json["profile_picture"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        passportNumber: json["passport_number"],
        passportExpiry: json["passport_expiry"] == null
            ? null
            : DateTime.parse(json["passport_expiry"]),
        emiratesId: json["emirates_id"],
        emiratesIdExpiry: json["emirates_id_expiry"] == null
            ? null
            : DateTime.parse(json["emirates_id_expiry"]),
        idFile: json["id_file"],
        isEmailVerified: json["is_email_verified"],
        isMobileVerified: json["is_mobile_verified"],
        isBlocked: json["is_blocked"],
        organizationName: json["organization_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        companyId: json["company_id"],
        view: json["view"],
        canViewAll: json["can_view_all"],
        intercomHash: json["intercom_hash"],
        pcLimit: json["pc_limit"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        fullName: json["full_name"],
        isCompanyAvailable: json["is_company_available"],
        profileImageUrl: json["profile_image_url"],
        myCityAssociations: json["my_city_associations"] == null
            ? []
            : List<dynamic>.from(json["my_city_associations"]!.map((x) => x)),
        idFileUrl: json["id_file_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "username": username,
        "role_id": roleId,
        "user_type_id": userTypeId,
        "email": email,
        "status": status,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "designation": designation,
        "profile_picture": profilePicture,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "passport_number": passportNumber,
        "passport_expiry":
            "${passportExpiry!.year.toString().padLeft(4, '0')}-${passportExpiry!.month.toString().padLeft(2, '0')}-${passportExpiry!.day.toString().padLeft(2, '0')}",
        "emirates_id": emiratesId,
        "emirates_id_expiry":
            "${emiratesIdExpiry!.year.toString().padLeft(4, '0')}-${emiratesIdExpiry!.month.toString().padLeft(2, '0')}-${emiratesIdExpiry!.day.toString().padLeft(2, '0')}",
        "id_file": idFile,
        "is_email_verified": isEmailVerified,
        "is_mobile_verified": isMobileVerified,
        "is_blocked": isBlocked,
        "organization_name": organizationName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "company_id": companyId,
        "view": view,
        "can_view_all": canViewAll,
        "intercom_hash": intercomHash,
        "pc_limit": pcLimit,
        "device_token": deviceToken,
        "device_type": deviceType,
        "full_name": fullName,
        "is_company_available": isCompanyAvailable,
        "profile_image_url": profileImageUrl,
        "my_city_associations": myCityAssociations == null
            ? []
            : List<dynamic>.from(myCityAssociations!.map((x) => x)),
        "id_file_url": idFileUrl,
      };
}
