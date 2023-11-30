// To parse this JSON data, do
//
//     final companiesModel = companiesModelFromJson(jsonString);

import 'dart:convert';

CompaniesModel companiesModelFromJson(String str) =>
    CompaniesModel.fromJson(json.decode(str));

String companiesModelToJson(CompaniesModel data) => json.encode(data.toJson());

class CompaniesModel {
  String? status;
  List<CompaniesRecord>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CompaniesModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CompaniesModel.fromJson(Map<String, dynamic> json) => CompaniesModel(
        status: json["status"],
        record: json["record"] == null
            ? []
            : List<CompaniesRecord>.from(json["record"]!.map((x) => CompaniesRecord.fromJson(x))),
        code: json["code"],
        meta: json["meta"],
        requestStatus: json["request_status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": record == null
            ? []
            : List<dynamic>.from(record!.map((x) => x.toJson())),
        "code": code,
        "meta": meta,
        "request_status": requestStatus,
        "message": message,
      };
}

class CompaniesRecord {
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

  CompaniesRecord({
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
  });

  factory CompaniesRecord.fromJson(Map<String, dynamic> json) => CompaniesRecord(
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
      };
}
