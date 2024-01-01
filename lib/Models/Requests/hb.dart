// To parse this JSON data, do
//
//     final hbDetailsModel = hbDetailsModelFromJson(jsonString);

import 'dart:convert';

HbDetailsModel hbDetailsModelFromJson(String str) =>
    HbDetailsModel.fromJson(json.decode(str));

String hbDetailsModelToJson(HbDetailsModel data) => json.encode(data.toJson());

class HbDetailsModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  HbDetailsModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory HbDetailsModel.fromJson(Map<String, dynamic> json) => HbDetailsModel(
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
  int? accountId;
  String? incomeType;
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
  String? clientIdNumber;
  String? clientIdFile;
  DateTime? clientIdExpiry;
  String? passportFile;
  DateTime? passportExpiry;
  String? passportNumber;
  dynamic clientCountryId;
  String? clientType;
  dynamic description;
  dynamic deletedAt;
  String? status;
  dynamic securityNumber;
  int? payableAmount;
  int? securityDeposit;
  dynamic paymentStatus;
  dynamic paymentRef;
  int? documentsStatus;
  int? securityDepositRefundStatus;
  int? termsConditions;
  String? tradeLicense;
  dynamic contractNumber;
  dynamic tradeLicenseExpiry;
  String? titleDeed;
  String? titleDeedNumber;
  dynamic tenancyContract;
  dynamic tenancyContractExpiry;
  dynamic notifyStatus;
  dynamic serviceChargeStatus;
  int? convenienceFee;
  dynamic convenienceFeeAccount;
  dynamic approvalNote;
  dynamic rejectionNote;
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
  String? clientIdFileUrl;
  String? passportFileUrl;
  String? titleDeedUrl;
  String? tenancyContractUrl;
  String? tradeLicenseUrl;
  bool? isMailable;
  String? fullName;
  String? profileImageUrl;
  Association? association;
  Unit? unit;
  Application? application;
  List<dynamic>? documents;

  Record({
    this.id,
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
    this.clientIdFileUrl,
    this.passportFileUrl,
    this.titleDeedUrl,
    this.tenancyContractUrl,
    this.tradeLicenseUrl,
    this.isMailable,
    this.fullName,
    this.profileImageUrl,
    this.association,
    this.unit,
    this.application,
    this.documents,
  });

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
        clientIdExpiry: json["client_id_expiry"] == null
            ? null
            : DateTime.parse(json["client_id_expiry"]),
        passportFile: json["passport_file"],
        passportExpiry: json["passport_expiry"] == null
            ? null
            : DateTime.parse(json["passport_expiry"]),
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
        clientIdFileUrl: json["client_id_file_url"],
        passportFileUrl: json["passport_file_url"],
        titleDeedUrl: json["title_deed_url"],
        tenancyContractUrl: json["tenancy_contract_url"],
        tradeLicenseUrl: json["trade_license_url"],
        isMailable: json["is_mailable"],
        fullName: json["full_name"],
        profileImageUrl: json["profile_image_url"],
        association: json["association"] == null
            ? null
            : Association.fromJson(json["association"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        application: json["application"] == null
            ? null
            : Application.fromJson(json["application"]),
        documents: json["documents"] == null
            ? []
            : List<dynamic>.from(json["documents"]!.map((x) => x)),
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
        "client_id_expiry":
            "${clientIdExpiry!.year.toString().padLeft(4, '0')}-${clientIdExpiry!.month.toString().padLeft(2, '0')}-${clientIdExpiry!.day.toString().padLeft(2, '0')}",
        "passport_file": passportFile,
        "passport_expiry":
            "${passportExpiry!.year.toString().padLeft(4, '0')}-${passportExpiry!.month.toString().padLeft(2, '0')}-${passportExpiry!.day.toString().padLeft(2, '0')}",
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
        "client_id_file_url": clientIdFileUrl,
        "passport_file_url": passportFileUrl,
        "title_deed_url": titleDeedUrl,
        "tenancy_contract_url": tenancyContractUrl,
        "trade_license_url": tradeLicenseUrl,
        "is_mailable": isMailable,
        "full_name": fullName,
        "profile_image_url": profileImageUrl,
        "association": association?.toJson(),
        "unit": unit?.toJson(),
        "application": application?.toJson(),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
      };
}

class Application {
  int? id;
  String? natureOfFunction;
  String? facility;
  int? expectedGuests;
  DateTime? bookingDate;
  String? startTime;
  String? endTime;
  dynamic repairCost;
  dynamic refundAmount;
  dynamic assetCondition;
  dynamic postEventReport;
  dynamic postEventReportBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Application({
    this.id,
    this.natureOfFunction,
    this.facility,
    this.expectedGuests,
    this.bookingDate,
    this.startTime,
    this.endTime,
    this.repairCost,
    this.refundAmount,
    this.assetCondition,
    this.postEventReport,
    this.postEventReportBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        natureOfFunction: json["nature_of_function"],
        facility: json["facility"],
        expectedGuests: json["expected_guests"],
        bookingDate: json["booking_date"] == null
            ? null
            : DateTime.parse(json["booking_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        repairCost: json["repair_cost"],
        refundAmount: json["refund_amount"],
        assetCondition: json["asset_condition"],
        postEventReport: json["post_event_report"],
        postEventReportBy: json["post_event_report_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nature_of_function": natureOfFunction,
        "facility": facility,
        "expected_guests": expectedGuests,
        "booking_date":
            "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "repair_cost": repairCost,
        "refund_amount": refundAmount,
        "asset_condition": assetCondition,
        "post_event_report": postEventReport,
        "post_event_report_by": postEventReportBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Association {
  int? id;
  String? name;
  int? remainingUnit;
  String? aboutPageImageUrl;
  String? backgroundImageUrl;
  String? logoImageUrl;
  String? fullAddress;
  int? unitsArea;
  int? applicableArea;
  int? suiteArea;
  int? balconyArea;
  String? filledParkings;
  dynamic subdomain;
  String? contractUrl;
  dynamic gmap;
  int? paymentGatewayEnabled;
  dynamic city;
  dynamic associationType;

  Association({
    this.id,
    this.name,
    this.remainingUnit,
    this.aboutPageImageUrl,
    this.backgroundImageUrl,
    this.logoImageUrl,
    this.fullAddress,
    this.unitsArea,
    this.applicableArea,
    this.suiteArea,
    this.balconyArea,
    this.filledParkings,
    this.subdomain,
    this.contractUrl,
    this.gmap,
    this.paymentGatewayEnabled,
    this.city,
    this.associationType,
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
        id: json["id"],
        name: json["name"],
        remainingUnit: json["remaining_unit"],
        aboutPageImageUrl: json["about_page_image_url"],
        backgroundImageUrl: json["background_image_url"],
        logoImageUrl: json["logo_image_url"],
        fullAddress: json["full_address"],
        unitsArea: json["units_area"],
        applicableArea: json["applicable_area"],
        suiteArea: json["suite_area"],
        balconyArea: json["balcony_area"],
        filledParkings: json["filled_parkings"],
        subdomain: json["subdomain"],
        contractUrl: json["contract_url"],
        gmap: json["gmap"],
        paymentGatewayEnabled: json["payment_gateway_enabled"],
        city: json["city"],
        associationType: json["association_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "remaining_unit": remainingUnit,
        "about_page_image_url": aboutPageImageUrl,
        "background_image_url": backgroundImageUrl,
        "logo_image_url": logoImageUrl,
        "full_address": fullAddress,
        "units_area": unitsArea,
        "applicable_area": applicableArea,
        "suite_area": suiteArea,
        "balcony_area": balconyArea,
        "filled_parkings": filledParkings,
        "subdomain": subdomain,
        "contract_url": contractUrl,
        "gmap": gmap,
        "payment_gateway_enabled": paymentGatewayEnabled,
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
