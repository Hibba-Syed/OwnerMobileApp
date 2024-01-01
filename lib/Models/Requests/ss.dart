// To parse this JSON data, do
//
//     final ssDetailsModel = ssDetailsModelFromJson(jsonString);

import 'dart:convert';

SsDetailsModel ssDetailsModelFromJson(String str) =>
    SsDetailsModel.fromJson(json.decode(str));

String ssDetailsModelToJson(SsDetailsModel data) => json.encode(data.toJson());

class SsDetailsModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  SsDetailsModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory SsDetailsModel.fromJson(Map<String, dynamic> json) => SsDetailsModel(
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
  String? reference;
  int? companyId;
  int? associationId;
  int? unitId;
  dynamic accountId;
  dynamic incomeType;
  int? assigneeId;
  String? applicationType;
  int? applicationId;
  dynamic parentId;
  String? clientName;
  String? clientEmail;
  String? clientPhone;
  String? firstName;
  dynamic lastName;
  String? email;
  dynamic profilePicture;
  String? clientIdType;
  dynamic clientIdNumber;
  dynamic clientIdFile;
  dynamic clientIdExpiry;
  dynamic passportFile;
  dynamic passportExpiry;
  dynamic passportNumber;
  dynamic clientCountryId;
  String? clientType;
  dynamic description;
  dynamic deletedAt;
  String? status;
  dynamic securityNumber;
  dynamic payableAmount;
  dynamic securityDeposit;
  dynamic paymentStatus;
  dynamic paymentRef;
  int? documentsStatus;
  int? securityDepositRefundStatus;
  int? termsConditions;
  dynamic tradeLicense;
  dynamic contractNumber;
  dynamic tradeLicenseExpiry;
  String? titleDeed;
  dynamic titleDeedNumber;
  dynamic tenancyContract;
  dynamic tenancyContractExpiry;
  dynamic notifyStatus;
  dynamic serviceChargeStatus;
  dynamic convenienceFee;
  dynamic convenienceFeeAccount;
  dynamic approvalNote;
  String? rejectionNote;
  dynamic holdNote;
  dynamic cancelNote;
  dynamic completionNote;
  dynamic requestNote;
  dynamic processNote;
  dynamic documentNote;
  dynamic securityNote;
  dynamic nocNote;
  dynamic refundNote;
  dynamic paymentNote;
  dynamic terms;
  DateTime? createdAt;
  DateTime? updatedAt;
  Application? application;
  Unit? unit;
  Association? association;
  Company? company;

  Record(
      {this.id,
      this.reference,
      this.companyId,
      this.associationId,
      this.unitId,
      this.accountId,
      this.incomeType,
      this.assigneeId,
      this.applicationType,
      this.applicationId,
      this.parentId,
      this.clientName,
      this.clientEmail,
      this.clientPhone,
      this.firstName,
      this.lastName,
      this.email,
      this.profilePicture,
      this.clientIdType,
      this.clientIdNumber,
      this.clientIdFile,
      this.clientIdExpiry,
      this.passportFile,
      this.passportExpiry,
      this.passportNumber,
      this.clientCountryId,
      this.clientType,
      this.description,
      this.deletedAt,
      this.status,
      this.securityNumber,
      this.payableAmount,
      this.securityDeposit,
      this.paymentStatus,
      this.paymentRef,
      this.documentsStatus,
      this.securityDepositRefundStatus,
      this.termsConditions,
      this.tradeLicense,
      this.contractNumber,
      this.tradeLicenseExpiry,
      this.titleDeed,
      this.titleDeedNumber,
      this.tenancyContract,
      this.tenancyContractExpiry,
      this.notifyStatus,
      this.serviceChargeStatus,
      this.convenienceFee,
      this.convenienceFeeAccount,
      this.approvalNote,
      this.rejectionNote,
      this.holdNote,
      this.cancelNote,
      this.completionNote,
      this.requestNote,
      this.processNote,
      this.documentNote,
      this.securityNote,
      this.nocNote,
      this.refundNote,
      this.paymentNote,
      this.terms,
      this.createdAt,
      this.updatedAt,
      this.application,
      this.unit,
      this.association,
      this.company});

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        reference: json["reference"],
        companyId: json["company_id"],
        associationId: json["association_id"],
        unitId: json["unit_id"],
        accountId: json["account_id"],
        incomeType: json["income_type"],
        assigneeId: json["assignee_id"],
        applicationType: json["application_type"],
        applicationId: json["application_id"],
        parentId: json["parent_id"],
        clientName: json["client_name"],
        clientEmail: json["client_email"],
        clientPhone: json["client_phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profilePicture: json["profile_picture"],
        clientIdType: json["client_id_type"],
        clientIdNumber: json["client_id_number"],
        clientIdFile: json["client_id_file"],
        clientIdExpiry: json["client_id_expiry"],
        passportFile: json["passport_file"],
        passportExpiry: json["passport_expiry"],
        passportNumber: json["passport_number"],
        clientCountryId: json["client_country_id"],
        clientType: json["client_type"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        status: json["status"],
        securityNumber: json["security_number"],
        payableAmount: json["payable_amount"],
        securityDeposit: json["security_deposit"],
        paymentStatus: json["payment_status"],
        paymentRef: json["payment_ref"],
        documentsStatus: json["documents_status"],
        securityDepositRefundStatus: json["security_deposit_refund_status"],
        termsConditions: json["terms_conditions"],
        tradeLicense: json["trade_license"],
        contractNumber: json["contract_number"],
        tradeLicenseExpiry: json["trade_license_expiry"],
        titleDeed: json["title_deed"],
        titleDeedNumber: json["title_deed_number"],
        tenancyContract: json["tenancy_contract"],
        tenancyContractExpiry: json["tenancy_contract_expiry"],
        notifyStatus: json["notify_status"],
        serviceChargeStatus: json["service_charge_status"],
        convenienceFee: json["convenience_fee"],
        convenienceFeeAccount: json["convenience_fee_account"],
        approvalNote: json["approval_note"],
        rejectionNote: json["rejection_note"],
        holdNote: json["hold_note"],
        cancelNote: json["cancel_note"],
        completionNote: json["completion_note"],
        requestNote: json["request_note"],
        processNote: json["process_note"],
        documentNote: json["document_note"],
        securityNote: json["security_note"],
        nocNote: json["noc_note"],
        refundNote: json["refund_note"],
        paymentNote: json["payment_note"],
        terms: json["terms"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        application: json["application"] == null
            ? null
            : Application.fromJson(json["application"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        association: json["association"] == null
            ? null
            : Association.fromJson(json["association"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "company_id": companyId,
        "association_id": associationId,
        "unit_id": unitId,
        "account_id": accountId,
        "income_type": incomeType,
        "assignee_id": assigneeId,
        "application_type": applicationType,
        "application_id": applicationId,
        "parent_id": parentId,
        "client_name": clientName,
        "client_email": clientEmail,
        "client_phone": clientPhone,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profile_picture": profilePicture,
        "client_id_type": clientIdType,
        "client_id_number": clientIdNumber,
        "client_id_file": clientIdFile,
        "client_id_expiry": clientIdExpiry,
        "passport_file": passportFile,
        "passport_expiry": passportExpiry,
        "passport_number": passportNumber,
        "client_country_id": clientCountryId,
        "client_type": clientType,
        "description": description,
        "deleted_at": deletedAt,
        "status": status,
        "security_number": securityNumber,
        "payable_amount": payableAmount,
        "security_deposit": securityDeposit,
        "payment_status": paymentStatus,
        "payment_ref": paymentRef,
        "documents_status": documentsStatus,
        "security_deposit_refund_status": securityDepositRefundStatus,
        "terms_conditions": termsConditions,
        "trade_license": tradeLicense,
        "contract_number": contractNumber,
        "trade_license_expiry": tradeLicenseExpiry,
        "title_deed": titleDeed,
        "title_deed_number": titleDeedNumber,
        "tenancy_contract": tenancyContract,
        "tenancy_contract_expiry": tenancyContractExpiry,
        "notify_status": notifyStatus,
        "service_charge_status": serviceChargeStatus,
        "convenience_fee": convenienceFee,
        "convenience_fee_account": convenienceFeeAccount,
        "approval_note": approvalNote,
        "rejection_note": rejectionNote,
        "hold_note": holdNote,
        "cancel_note": cancelNote,
        "completion_note": completionNote,
        "request_note": requestNote,
        "process_note": processNote,
        "document_note": documentNote,
        "security_note": securityNote,
        "noc_note": nocNote,
        "refund_note": refundNote,
        "payment_note": paymentNote,
        "terms": terms,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "application": application?.toJson(),
      };
}

class Application {
  int? id;
  DateTime? startDate;
  DateTime? endDate;
  int? numberOfPeople;
  String? peoples;
  dynamic description;
  dynamic companyName;
  dynamic tourismLicense;
  dynamic tourismLicenseExpiry;
  dynamic companyRiskInsurance;
  dynamic companyRiskInsuranceExpiry;
  dynamic reraId;
  dynamic reraIdExpiry;
  dynamic visaCopy;
  dynamic visaCopyExpiry;
  String? dtcmPermit;
  DateTime? dtcmPermitExpiry;
  DateTime? createdAt;
  DateTime? updatedAt;

  Application({
    this.id,
    this.startDate,
    this.endDate,
    this.numberOfPeople,
    this.peoples,
    this.description,
    this.companyName,
    this.tourismLicense,
    this.tourismLicenseExpiry,
    this.companyRiskInsurance,
    this.companyRiskInsuranceExpiry,
    this.reraId,
    this.reraIdExpiry,
    this.visaCopy,
    this.visaCopyExpiry,
    this.dtcmPermit,
    this.dtcmPermitExpiry,
    this.createdAt,
    this.updatedAt,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        numberOfPeople: json["number_of_people"],
        peoples: json["peoples"],
        description: json["description"],
        companyName: json["company_name"],
        tourismLicense: json["tourism_license"],
        tourismLicenseExpiry: json["tourism_license_expiry"],
        companyRiskInsurance: json["company_risk_insurance"],
        companyRiskInsuranceExpiry: json["company_risk_insurance_expiry"],
        reraId: json["rera_id"],
        reraIdExpiry: json["rera_id_expiry"],
        visaCopy: json["visa_copy"],
        visaCopyExpiry: json["visa_copy_expiry"],
        dtcmPermit: json["dtcm_permit"],
        dtcmPermitExpiry: json["dtcm_permit_expiry"] == null
            ? null
            : DateTime.parse(json["dtcm_permit_expiry"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "number_of_people": numberOfPeople,
        "peoples": peoples,
        "description": description,
        "company_name": companyName,
        "tourism_license": tourismLicense,
        "tourism_license_expiry": tourismLicenseExpiry,
        "company_risk_insurance": companyRiskInsurance,
        "company_risk_insurance_expiry": companyRiskInsuranceExpiry,
        "rera_id": reraId,
        "rera_id_expiry": reraIdExpiry,
        "visa_copy": visaCopy,
        "visa_copy_expiry": visaCopyExpiry,
        "dtcm_permit": dtcmPermit,
        "dtcm_permit_expiry":
            "${dtcmPermitExpiry!.year.toString().padLeft(4, '0')}-${dtcmPermitExpiry!.month.toString().padLeft(2, '0')}-${dtcmPermitExpiry!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Association {
  int? id;
  String? name;
  dynamic city;
  dynamic associationType;

  Association({
    this.id,
    this.name,
    this.city,
    this.associationType,
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        associationType: json["association_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "association_type": associationType,
      };
}

class Unit {
  int? id;
  String? unitNumber;
  bool? isLegalNoticeActive;
  bool? isRdcActive;

  Unit({
    this.id,
    this.unitNumber,
    this.isLegalNoticeActive,
    this.isRdcActive,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        unitNumber: json["unit_number"],
        isLegalNoticeActive: json["is_legal_notice_active"],
        isRdcActive: json["is_rdc_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_number": unitNumber,
        "is_legal_notice_active": isLegalNoticeActive,
        "is_rdc_active": isRdcActive,
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
    this.user,
  });

  factory Company.fromRawJson(String str) => Company.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? reference;
  String? username;
  int? roleId;
  int? userTypeId;
  String? email;
  int? status;
  String? firstName;
  String? lastName;
  String? mobile;
  dynamic designation;
  String? profilePicture;
  dynamic dob;
  dynamic passportNumber;
  dynamic passportExpiry;
  dynamic emiratesId;
  dynamic emiratesIdExpiry;
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
  dynamic pcLimit;
  String? deviceToken;
  String? deviceType;
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

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
        dob: json["dob"],
        passportNumber: json["passport_number"],
        passportExpiry: json["passport_expiry"],
        emiratesId: json["emirates_id"],
        emiratesIdExpiry: json["emirates_id_expiry"],
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
        "dob": dob,
        "passport_number": passportNumber,
        "passport_expiry": passportExpiry,
        "emirates_id": emiratesId,
        "emirates_id_expiry": emiratesIdExpiry,
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
