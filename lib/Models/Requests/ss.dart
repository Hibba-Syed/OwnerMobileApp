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
      this.association});

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
