// To parse this JSON data, do
//
//     final shortStayOccupantModel = shortStayOccupantModelFromJson(jsonString);

import 'dart:convert';

ShortStayOccupantModel shortStayOccupantModelFromJson(String str) => ShortStayOccupantModel.fromJson(json.decode(str));

String shortStayOccupantModelToJson(ShortStayOccupantModel data) => json.encode(data.toJson());

class ShortStayOccupantModel {
    String? status;
    Record? record;
    int? code;
    dynamic meta;
    bool? requestStatus;
    String? message;

    ShortStayOccupantModel({
        this.status,
        this.record,
        this.code,
        this.meta,
        this.requestStatus,
        this.message,
    });

    factory ShortStayOccupantModel.fromJson(Map<String, dynamic> json) => ShortStayOccupantModel(
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
    dynamic approverId;
    dynamic statusBy;
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
    int? allSecurityPersonnel;
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
    String? approvalNote;
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
    ShortStayApplication? shortStayApplication;

    Record({
        this.id,
        this.reference,
        this.companyId,
        this.associationId,
        this.unitId,
        this.accountId,
        this.incomeType,
        this.assigneeId,
        this.approverId,
        this.statusBy,
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
        this.allSecurityPersonnel,
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
        this.shortStayApplication,
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
        approverId: json["approver_id"],
        statusBy: json["status_by"],
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
        allSecurityPersonnel: json["all_security_personnel"],
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        clientIdFileUrl: json["client_id_file_url"],
        passportFileUrl: json["passport_file_url"],
        titleDeedUrl: json["title_deed_url"],
        tenancyContractUrl: json["tenancy_contract_url"],
        tradeLicenseUrl: json["trade_license_url"],
        isMailable: json["is_mailable"],
        fullName: json["full_name"],
        profileImageUrl: json["profile_image_url"],
        shortStayApplication: json["short_stay_application"] == null ? null : ShortStayApplication.fromJson(json["short_stay_application"]),
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
        "approver_id": approverId,
        "status_by": statusBy,
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
        "all_security_personnel": allSecurityPersonnel,
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
        "short_stay_application": shortStayApplication?.toJson(),
    };
}

class ShortStayApplication {
    int? id;
    DateTime? startDate;
    DateTime? endDate;
    dynamic terminationDate;
    dynamic terminationNote;
    int? numberOfPeople;
    String? peoples;
    String? description;
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
    String? tourismLicenseUrl;
    String? companyRiskInsuranceUrl;
    String? visaCopyUrl;
    String? reraIdUrl;
    String? dtcmPermitUrl;
    bool? isTourismLicenseExpired;
    bool? isCompanyRiskInsuranceExpired;
    bool? isVisaCopyExpired;
    bool? isReraIdExpired;
    bool? isDtcmPermitExpired;
    List<Guest>? guests;

    ShortStayApplication({
        this.id,
        this.startDate,
        this.endDate,
        this.terminationDate,
        this.terminationNote,
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
        this.tourismLicenseUrl,
        this.companyRiskInsuranceUrl,
        this.visaCopyUrl,
        this.reraIdUrl,
        this.dtcmPermitUrl,
        this.isTourismLicenseExpired,
        this.isCompanyRiskInsuranceExpired,
        this.isVisaCopyExpired,
        this.isReraIdExpired,
        this.isDtcmPermitExpired,
        this.guests,
    });

    factory ShortStayApplication.fromJson(Map<String, dynamic> json) => ShortStayApplication(
        id: json["id"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        terminationDate: json["termination_date"],
        terminationNote: json["termination_note"],
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
        dtcmPermitExpiry: json["dtcm_permit_expiry"] == null ? null : DateTime.parse(json["dtcm_permit_expiry"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        tourismLicenseUrl: json["tourism_license_url"],
        companyRiskInsuranceUrl: json["company_risk_insurance_url"],
        visaCopyUrl: json["visa_copy_url"],
        reraIdUrl: json["rera_id_url"],
        dtcmPermitUrl: json["dtcm_permit_url"],
        isTourismLicenseExpired: json["is_tourism_license_expired"],
        isCompanyRiskInsuranceExpired: json["is_company_risk_insurance_expired"],
        isVisaCopyExpired: json["is_visa_copy_expired"],
        isReraIdExpired: json["is_rera_id_expired"],
        isDtcmPermitExpired: json["is_dtcm_permit_expired"],
        guests: json["guests"] == null ? [] : List<Guest>.from(json["guests"]!.map((x) => Guest.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "termination_date": terminationDate,
        "termination_note": terminationNote,
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
        "dtcm_permit_expiry": "${dtcmPermitExpiry!.year.toString().padLeft(4, '0')}-${dtcmPermitExpiry!.month.toString().padLeft(2, '0')}-${dtcmPermitExpiry!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "tourism_license_url": tourismLicenseUrl,
        "company_risk_insurance_url": companyRiskInsuranceUrl,
        "visa_copy_url": visaCopyUrl,
        "rera_id_url": reraIdUrl,
        "dtcm_permit_url": dtcmPermitUrl,
        "is_tourism_license_expired": isTourismLicenseExpired,
        "is_company_risk_insurance_expired": isCompanyRiskInsuranceExpired,
        "is_visa_copy_expired": isVisaCopyExpired,
        "is_rera_id_expired": isReraIdExpired,
        "is_dtcm_permit_expired": isDtcmPermitExpired,
        "guests": guests == null ? [] : List<dynamic>.from(guests!.map((x) => x.toJson())),
    };
}

class Guest {
    String? name;
    String? code;
    String? phone;
    String? fileName;
    String? fileUrl;

    Guest({
        this.name,
        this.code,
        this.phone,
        this.fileName,
        this.fileUrl,
    });

    factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        name: json["name"],
        code: json["code"],
        phone: json["phone"],
        fileName: json["file_name"],
        fileUrl: json["file_url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "phone": phone,
        "file_name": fileName,
        "file_url": fileUrl,
    };
}
