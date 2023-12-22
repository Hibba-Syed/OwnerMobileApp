// To parse this JSON data, do
//
//     final foDetailsModel = foDetailsModelFromJson(jsonString);

import 'dart:convert';

FoDetailsModel foDetailsModelFromJson(String str) => FoDetailsModel.fromJson(json.decode(str));

String foDetailsModelToJson(FoDetailsModel data) => json.encode(data.toJson());

class FoDetailsModel {
    String? status;
    Record? record;
    int? code;
    dynamic meta;
    bool? requestStatus;
    String? message;

    FoDetailsModel({
        this.status,
        this.record,
        this.code,
        this.meta,
        this.requestStatus,
        this.message,
    });

    factory FoDetailsModel.fromJson(Map<String, dynamic> json) => FoDetailsModel(
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
    dynamic payableAmount;
    dynamic securityDeposit;
    String? paymentStatus;
    dynamic paymentRef;
    int? documentsStatus;
    int? securityDepositRefundStatus;
    int? termsConditions;
    String? tradeLicense;
    dynamic contractNumber;
    dynamic tradeLicenseExpiry;
    String? titleDeed;
    String? titleDeedNumber;
    String? tenancyContract;
    DateTime? tenancyContractExpiry;
    dynamic notifyStatus;
    int? serviceChargeStatus;
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
    String? nocNote;
    dynamic refundNote;
    dynamic paymentNote;
    dynamic terms;
    DateTime? createdAt;
    DateTime? updatedAt;
    Association? association;
    String? clientIdFileUrl;
    String? passportFileUrl;
    String? titleDeedUrl;
    String? tenancyContractUrl;
    String? tradeLicenseUrl;
    bool? isMailable;
    String? fullName;
    String? profileImageUrl;
    Application? application;
    Unit? unit;
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
        this.association,
        this.clientIdFileUrl,
        this.passportFileUrl,
        this.titleDeedUrl,
        this.tenancyContractUrl,
        this.tradeLicenseUrl,
        this.isMailable,
        this.fullName,
        this.profileImageUrl,
        this.application,
        this.unit,
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
        clientIdExpiry: json["client_id_expiry"] == null ? null : DateTime.parse(json["client_id_expiry"]),
        passportFile: json["passport_file"],
        passportExpiry: json["passport_expiry"] == null ? null : DateTime.parse(json["passport_expiry"]),
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
        tenancyContractExpiry: json["tenancy_contract_expiry"] == null ? null : DateTime.parse(json["tenancy_contract_expiry"]),
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
        association: json["association"] == null ? null : Association.fromJson(json["association"]),
        clientIdFileUrl: json["client_id_file_url"],
        passportFileUrl: json["passport_file_url"],
        titleDeedUrl: json["title_deed_url"],
        tenancyContractUrl: json["tenancy_contract_url"],
        tradeLicenseUrl: json["trade_license_url"],
        isMailable: json["is_mailable"],
        fullName: json["full_name"],
        profileImageUrl: json["profile_image_url"],
        application: json["application"] == null ? null : Application.fromJson(json["application"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        documents: json["documents"] == null ? [] : List<dynamic>.from(json["documents"]!.map((x) => x)),
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
        "client_id_expiry": "${clientIdExpiry!.year.toString().padLeft(4, '0')}-${clientIdExpiry!.month.toString().padLeft(2, '0')}-${clientIdExpiry!.day.toString().padLeft(2, '0')}",
        "passport_file": passportFile,
        "passport_expiry": "${passportExpiry!.year.toString().padLeft(4, '0')}-${passportExpiry!.month.toString().padLeft(2, '0')}-${passportExpiry!.day.toString().padLeft(2, '0')}",
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
        "tenancy_contract_expiry": "${tenancyContractExpiry!.year.toString().padLeft(4, '0')}-${tenancyContractExpiry!.month.toString().padLeft(2, '0')}-${tenancyContractExpiry!.day.toString().padLeft(2, '0')}",
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
        "association": association?.toJson(),
        "client_id_file_url": clientIdFileUrl,
        "passport_file_url": passportFileUrl,
        "title_deed_url": titleDeedUrl,
        "tenancy_contract_url": tenancyContractUrl,
        "trade_license_url": tradeLicenseUrl,
        "is_mailable": isMailable,
        "full_name": fullName,
        "profile_image_url": profileImageUrl,
        "application": application?.toJson(),
        "unit": unit?.toJson(),
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
    };
}

class Application {
    int? id;
    String? contractorName;
    String? contactPerson;
    String? contractorPhone;
    int? noOfStaffExpected;
    DateTime? startDate;
    DateTime? endDate;
    dynamic fitoutFee;
    String? feePaymentStatus;
    dynamic paymentRef;
    int? totalPayableFee;
    dynamic securityDeposit;
    dynamic securityDepositDetails;
    String? securityDepositStatus;
    dynamic securityChequeDetails;
    dynamic securityChequeAttachment;
    dynamic rejectionNote;
    dynamic assetCondition;
    dynamic repairCost;
    dynamic refundSecurityAmount;
    dynamic postEventReport;
    dynamic postEventReportBy;
    dynamic contractorCoverLetter;
    dynamic nocFromOwner;
    dynamic appointmentLetter;
    dynamic tradeLicenseContractor;
    dynamic contractorInsurance;
    dynamic workDrawing;
    dynamic dubaiCivilDefenceApproval;
    dynamic dcdApprovalFireFighting;
    dynamic requiredDocsCas;
    dynamic nocStatus;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic securityNumber;
    int? isElectricity;
    String? type;
    int? isDewaNocApplied;
    int? isFinalNocApplied;
    dynamic dewaNocFee;
    dynamic finalNocFee;
    dynamic dewaNocPaymentStatus;
    dynamic finalNocPaymentStatus;
    int? finalNocDocumentStatus;
    String? appointmentLetterUrl;
    String? tradeLicenseContractorUrl;
    String? securityChequeAttachmentUrl;
    String? contractorInsuranceUrl;
    String? workDrawingUrl;
    String? nocFromOwnerUrl;
    String? contractorCoverLetterUrl;
    String? dubaiCivilDefenceApprovalUrl;
    String? dcdApprovalFireFightingUrl;
    String? securityDepositStatusLbl;
    String? feePaymentStatusLbl;
    String? dewaNocPaymentStatusLbl;
    String? finalNocPaymentStatusLbl;
    List<dynamic>? addons;
    List<Dewanoc>? dewanoc;

    Application({
        this.id,
        this.contractorName,
        this.contactPerson,
        this.contractorPhone,
        this.noOfStaffExpected,
        this.startDate,
        this.endDate,
        this.fitoutFee,
        this.feePaymentStatus,
        this.paymentRef,
        this.totalPayableFee,
        this.securityDeposit,
        this.securityDepositDetails,
        this.securityDepositStatus,
        this.securityChequeDetails,
        this.securityChequeAttachment,
        this.rejectionNote,
        this.assetCondition,
        this.repairCost,
        this.refundSecurityAmount,
        this.postEventReport,
        this.postEventReportBy,
        this.contractorCoverLetter,
        this.nocFromOwner,
        this.appointmentLetter,
        this.tradeLicenseContractor,
        this.contractorInsurance,
        this.workDrawing,
        this.dubaiCivilDefenceApproval,
        this.dcdApprovalFireFighting,
        this.requiredDocsCas,
        this.nocStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.securityNumber,
        this.isElectricity,
        this.type,
        this.isDewaNocApplied,
        this.isFinalNocApplied,
        this.dewaNocFee,
        this.finalNocFee,
        this.dewaNocPaymentStatus,
        this.finalNocPaymentStatus,
        this.finalNocDocumentStatus,
        this.appointmentLetterUrl,
        this.tradeLicenseContractorUrl,
        this.securityChequeAttachmentUrl,
        this.contractorInsuranceUrl,
        this.workDrawingUrl,
        this.nocFromOwnerUrl,
        this.contractorCoverLetterUrl,
        this.dubaiCivilDefenceApprovalUrl,
        this.dcdApprovalFireFightingUrl,
        this.securityDepositStatusLbl,
        this.feePaymentStatusLbl,
        this.dewaNocPaymentStatusLbl,
        this.finalNocPaymentStatusLbl,
        this.addons,
        this.dewanoc,
    });

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        contractorName: json["contractor_name"],
        contactPerson: json["contact_person"],
        contractorPhone: json["contractor_phone"],
        noOfStaffExpected: json["no_of_staff_expected"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        fitoutFee: json["fitout_fee"],
        feePaymentStatus: json["fee_payment_status"],
        paymentRef: json["payment_ref"],
        totalPayableFee: json["total_payable_fee"],
        securityDeposit: json["security_deposit"],
        securityDepositDetails: json["security_deposit_details"],
        securityDepositStatus: json["security_deposit_status"],
        securityChequeDetails: json["security_cheque_details"],
        securityChequeAttachment: json["security_cheque_attachment"],
        rejectionNote: json["rejection_note"],
        assetCondition: json["asset_condition"],
        repairCost: json["repair_cost"],
        refundSecurityAmount: json["refund_security_amount"],
        postEventReport: json["post_event_report"],
        postEventReportBy: json["post_event_report_by"],
        contractorCoverLetter: json["contractor_cover_letter"],
        nocFromOwner: json["noc_from_owner"],
        appointmentLetter: json["appointment_letter"],
        tradeLicenseContractor: json["trade_license_contractor"],
        contractorInsurance: json["contractor_insurance"],
        workDrawing: json["work_drawing"],
        dubaiCivilDefenceApproval: json["dubai_civil_defence_approval"],
        dcdApprovalFireFighting: json["dcd_approval_fire_fighting"],
        requiredDocsCas: json["required_docs_cas"],
        nocStatus: json["noc_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        securityNumber: json["security_number"],
        isElectricity: json["is_electricity"],
        type: json["type"],
        isDewaNocApplied: json["is_dewa_noc_applied"],
        isFinalNocApplied: json["is_final_noc_applied"],
        dewaNocFee: json["dewa_noc_fee"],
        finalNocFee: json["final_noc_fee"],
        dewaNocPaymentStatus: json["dewa_noc_payment_status"],
        finalNocPaymentStatus: json["final_noc_payment_status"],
        finalNocDocumentStatus: json["final_noc_document_status"],
        appointmentLetterUrl: json["appointment_letter_url"],
        tradeLicenseContractorUrl: json["trade_license_contractor_url"],
        securityChequeAttachmentUrl: json["security_cheque_attachment_url"],
        contractorInsuranceUrl: json["contractor_insurance_url"],
        workDrawingUrl: json["work_drawing_url"],
        nocFromOwnerUrl: json["noc_from_owner_url"],
        contractorCoverLetterUrl: json["contractor_cover_letter_url"],
        dubaiCivilDefenceApprovalUrl: json["dubai_civil_defence_approval_url"],
        dcdApprovalFireFightingUrl: json["dcd_approval_fire_fighting_url"],
        securityDepositStatusLbl: json["security_deposit_status_lbl"],
        feePaymentStatusLbl: json["fee_payment_status_lbl"],
        dewaNocPaymentStatusLbl: json["dewa_noc_payment_status_lbl"],
        finalNocPaymentStatusLbl: json["final_noc_payment_status_lbl"],
        addons: json["addons"] == null ? [] : List<dynamic>.from(json["addons"]!.map((x) => x)),
        dewanoc: json["dewanoc"] == null ? [] : List<Dewanoc>.from(json["dewanoc"]!.map((x) => Dewanoc.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contractor_name": contractorName,
        "contact_person": contactPerson,
        "contractor_phone": contractorPhone,
        "no_of_staff_expected": noOfStaffExpected,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "fitout_fee": fitoutFee,
        "fee_payment_status": feePaymentStatus,
        "payment_ref": paymentRef,
        "total_payable_fee": totalPayableFee,
        "security_deposit": securityDeposit,
        "security_deposit_details": securityDepositDetails,
        "security_deposit_status": securityDepositStatus,
        "security_cheque_details": securityChequeDetails,
        "security_cheque_attachment": securityChequeAttachment,
        "rejection_note": rejectionNote,
        "asset_condition": assetCondition,
        "repair_cost": repairCost,
        "refund_security_amount": refundSecurityAmount,
        "post_event_report": postEventReport,
        "post_event_report_by": postEventReportBy,
        "contractor_cover_letter": contractorCoverLetter,
        "noc_from_owner": nocFromOwner,
        "appointment_letter": appointmentLetter,
        "trade_license_contractor": tradeLicenseContractor,
        "contractor_insurance": contractorInsurance,
        "work_drawing": workDrawing,
        "dubai_civil_defence_approval": dubaiCivilDefenceApproval,
        "dcd_approval_fire_fighting": dcdApprovalFireFighting,
        "required_docs_cas": requiredDocsCas,
        "noc_status": nocStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "security_number": securityNumber,
        "is_electricity": isElectricity,
        "type": type,
        "is_dewa_noc_applied": isDewaNocApplied,
        "is_final_noc_applied": isFinalNocApplied,
        "dewa_noc_fee": dewaNocFee,
        "final_noc_fee": finalNocFee,
        "dewa_noc_payment_status": dewaNocPaymentStatus,
        "final_noc_payment_status": finalNocPaymentStatus,
        "final_noc_document_status": finalNocDocumentStatus,
        "appointment_letter_url": appointmentLetterUrl,
        "trade_license_contractor_url": tradeLicenseContractorUrl,
        "security_cheque_attachment_url": securityChequeAttachmentUrl,
        "contractor_insurance_url": contractorInsuranceUrl,
        "work_drawing_url": workDrawingUrl,
        "noc_from_owner_url": nocFromOwnerUrl,
        "contractor_cover_letter_url": contractorCoverLetterUrl,
        "dubai_civil_defence_approval_url": dubaiCivilDefenceApprovalUrl,
        "dcd_approval_fire_fighting_url": dcdApprovalFireFightingUrl,
        "security_deposit_status_lbl": securityDepositStatusLbl,
        "fee_payment_status_lbl": feePaymentStatusLbl,
        "dewa_noc_payment_status_lbl": dewaNocPaymentStatusLbl,
        "final_noc_payment_status_lbl": finalNocPaymentStatusLbl,
        "addons": addons == null ? [] : List<dynamic>.from(addons!.map((x) => x)),
        "dewanoc": dewanoc == null ? [] : List<dynamic>.from(dewanoc!.map((x) => x.toJson())),
    };
}

class Dewanoc {
    int? id;
    int? applicationFitOutId;
    String? plotNo;
    String? meterAcNo;
    String? meterPremiseNo;
    String? approvedLoad;
    String? connectedLoad;
    String? mdbReference;
    String? smdbReference;
    DateTime? createdAt;
    DateTime? updatedAt;

    Dewanoc({
        this.id,
        this.applicationFitOutId,
        this.plotNo,
        this.meterAcNo,
        this.meterPremiseNo,
        this.approvedLoad,
        this.connectedLoad,
        this.mdbReference,
        this.smdbReference,
        this.createdAt,
        this.updatedAt,
    });

    factory Dewanoc.fromJson(Map<String, dynamic> json) => Dewanoc(
        id: json["id"],
        applicationFitOutId: json["application_fit_out_id"],
        plotNo: json["plot_no"],
        meterAcNo: json["meter_ac_no"],
        meterPremiseNo: json["meter_premise_no"],
        approvedLoad: json["approved_load"],
        connectedLoad: json["connected_load"],
        mdbReference: json["mdb_reference"],
        smdbReference: json["smdb_reference"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "application_fit_out_id": applicationFitOutId,
        "plot_no": plotNo,
        "meter_ac_no": meterAcNo,
        "meter_premise_no": meterPremiseNo,
        "approved_load": approvedLoad,
        "connected_load": connectedLoad,
        "mdb_reference": mdbReference,
        "smdb_reference": smdbReference,
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
