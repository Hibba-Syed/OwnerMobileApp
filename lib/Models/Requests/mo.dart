// To parse this JSON data, do
//
//     final moDetailsModel = moDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'ad.dart';

MoDetailsModel moDetailsModelFromJson(String str) =>
    MoDetailsModel.fromJson(json.decode(str));

String moDetailsModelToJson(MoDetailsModel data) => json.encode(data.toJson());

class MoDetailsModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  MoDetailsModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory MoDetailsModel.fromJson(Map<String, dynamic> json) => MoDetailsModel(
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
  dynamic clientIdType;
  String? clientIdNumber;
  dynamic clientIdFile;
  dynamic clientIdExpiry;
  String? passportFile;
  dynamic passportExpiry;
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
  dynamic titleDeed;
  String? titleDeedNumber;
  dynamic tenancyContract;
  dynamic tenancyContractExpiry;
  dynamic notifyStatus;
  dynamic serviceChargeStatus;
  dynamic convenienceFee;
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
  List<Document>? documents;

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
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
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
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}

class Application {
  int? id;
  String? requestType;
  dynamic emergencyNumber;
  DateTime? moveDate;
  String? moveTimeFrom;
  String? moveTimeTo;
  dynamic repairCost;
  dynamic refundAmount;
  dynamic securityDeposit;
  dynamic handoverMoveout;
  dynamic noteForSecurity;
  dynamic assetCondition;
  dynamic postEventReport;
  dynamic postEventReportBy;
  dynamic applicantDamageNote;
  dynamic completeChecklist;
  dynamic dubaiSiliconOasisPermit;
  dynamic serviceChargeStatus;
  dynamic residentRequestId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic residentInformation;

  Application({
    this.id,
    this.requestType,
    this.emergencyNumber,
    this.moveDate,
    this.moveTimeFrom,
    this.moveTimeTo,
    this.repairCost,
    this.refundAmount,
    this.securityDeposit,
    this.handoverMoveout,
    this.noteForSecurity,
    this.assetCondition,
    this.postEventReport,
    this.postEventReportBy,
    this.applicantDamageNote,
    this.completeChecklist,
    this.dubaiSiliconOasisPermit,
    this.serviceChargeStatus,
    this.residentRequestId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.residentInformation,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        requestType: json["request_type"],
        emergencyNumber: json["emergency_number"],
        moveDate: json["move_date"] == null
            ? null
            : DateTime.parse(json["move_date"]),
        moveTimeFrom: json["move_time_from"],
        moveTimeTo: json["move_time_to"],
        repairCost: json["repair_cost"],
        refundAmount: json["refund_amount"],
        securityDeposit: json["security_deposit"],
        handoverMoveout: json["handover_moveout"],
        noteForSecurity: json["note_for_security"],
        assetCondition: json["asset_condition"],
        postEventReport: json["post_event_report"],
        postEventReportBy: json["post_event_report_by"],
        applicantDamageNote: json["applicant_damage_note"],
        completeChecklist: json["complete_checklist"],
        dubaiSiliconOasisPermit: json["dubai_silicon_oasis_permit"],
        serviceChargeStatus: json["service_charge_status"],
        residentRequestId: json["resident_request_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        residentInformation: json["resident_information"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "request_type": requestType,
        "emergency_number": emergencyNumber,
        "move_date":
            "${moveDate!.year.toString().padLeft(4, '0')}-${moveDate!.month.toString().padLeft(2, '0')}-${moveDate!.day.toString().padLeft(2, '0')}",
        "move_time_from": moveTimeFrom,
        "move_time_to": moveTimeTo,
        "repair_cost": repairCost,
        "refund_amount": refundAmount,
        "security_deposit": securityDeposit,
        "handover_moveout": handoverMoveout,
        "note_for_security": noteForSecurity,
        "asset_condition": assetCondition,
        "post_event_report": postEventReport,
        "post_event_report_by": postEventReportBy,
        "applicant_damage_note": applicantDamageNote,
        "complete_checklist": completeChecklist,
        "dubai_silicon_oasis_permit": dubaiSiliconOasisPermit,
        "service_charge_status": serviceChargeStatus,
        "resident_request_id": residentRequestId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "resident_information": residentInformation,
      };
}


class Document {
  int? id;
  int? companyId;
  dynamic userId;
  int? objectId;
  String? objectType;
  String? name;
  dynamic folderName;
  dynamic description;
  String? path;
  String? fileType;
  String? mimeType;
  String? fileExt;
  dynamic issueDate;
  dynamic expiryDate;
  String? status;
  dynamic type;
  String? category;
  dynamic note;
  dynamic shareWith;
  dynamic shareEndDate;
  dynamic shareWithUnit;
  dynamic shareEndDateUnit;
  dynamic emailSent;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? pathUrl;

  Document({
    this.id,
    this.companyId,
    this.userId,
    this.objectId,
    this.objectType,
    this.name,
    this.folderName,
    this.description,
    this.path,
    this.fileType,
    this.mimeType,
    this.fileExt,
    this.issueDate,
    this.expiryDate,
    this.status,
    this.type,
    this.category,
    this.note,
    this.shareWith,
    this.shareEndDate,
    this.shareWithUnit,
    this.shareEndDateUnit,
    this.emailSent,
    this.createdAt,
    this.updatedAt,
    this.pathUrl,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        objectId: json["object_id"],
        objectType: json["object_type"],
        name: json["name"],
        folderName: json["folder_name"],
        description: json["description"],
        path: json["path"],
        fileType: json["file_type"],
        mimeType: json["mime_type"],
        fileExt: json["file_ext"],
        issueDate: json["issue_date"],
        expiryDate: json["expiry_date"],
        status: json["status"],
        type: json["type"],
        category: json["category"],
        note: json["note"],
        shareWith: json["share_with"],
        shareEndDate: json["share_end_date"],
        shareWithUnit: json["share_with_unit"],
        shareEndDateUnit: json["share_end_date_unit"],
        emailSent: json["email_sent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pathUrl: json["path_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "user_id": userId,
        "object_id": objectId,
        "object_type": objectType,
        "name": name,
        "folder_name": folderName,
        "description": description,
        "path": path,
        "file_type": fileType,
        "mime_type": mimeType,
        "file_ext": fileExt,
        "issue_date": issueDate,
        "expiry_date": expiryDate,
        "status": status,
        "type": type,
        "category": category,
        "note": note,
        "share_with": shareWith,
        "share_end_date": shareEndDate,
        "share_with_unit": shareWithUnit,
        "share_end_date_unit": shareEndDateUnit,
        "email_sent": emailSent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "path_url": pathUrl,
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
