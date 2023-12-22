// To parse this JSON data, do
//
//     final tpDetailsModel = tpDetailsModelFromJson(jsonString);

import 'dart:convert';

TpDetailsModel tpDetailsModelFromJson(String str) => TpDetailsModel.fromJson(json.decode(str));

String tpDetailsModelToJson(TpDetailsModel data) => json.encode(data.toJson());

class TpDetailsModel {
    String? status;
    Record? record;
    int? code;
    dynamic meta;
    bool? requestStatus;
    String? message;

    TpDetailsModel({
        this.status,
        this.record,
        this.code,
        this.meta,
        this.requestStatus,
        this.message,
    });

    factory TpDetailsModel.fromJson(Map<String, dynamic> json) => TpDetailsModel(
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
    dynamic titleDeed;
    dynamic titleDeedNumber;
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
    };
}

class Application {
    int? id;
    dynamic clientId;
    String? requesterType;
    String? buyerRequesterType;
    String? sellerRequesterType;
    dynamic attorneyName;
    dynamic attorneyEmail;
    dynamic attorneyContact;
    dynamic documentsStatus;
    dynamic serviceChargeStatus;
    dynamic rejectionNote;
    dynamic moreDocuments;
    dynamic requestStatus;
    dynamic transferFee;
    dynamic transferFeeRefrence;
    dynamic transferSecurityDeposit;
    dynamic transferSecurityChequeDetails;
    dynamic transferSecurityChequeAttachment;
    dynamic transferSecurityStatus;
    dynamic transferFeeStatus;
    dynamic developerName;
    dynamic developerAddress;
    dynamic serviceChargeClearTill;
    dynamic nocValidity;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic salePurchaseAgreement;
    String? undertaking;
    dynamic attorneyPoa;
    dynamic attorneyPassport;
    dynamic attorneyIdFile;
    dynamic buyerCompanyTradeLicense;
    dynamic sellerCompanyTradeLicense;
    String? ownershipFile;
    String? attorneyPassportUrl;
    String? attorneyPoaUrl;
    String? attorneyIdFileUrl;
    String? buyerCompanyTradeLicenseUrl;
    String? sellerCompanyTradeLicenseUrl;
    String? transferSecurityChequeAttachmentUrl;
    String? undertakingUrl;
    String? ownershipFileUrl;
    List<Buyer>? buyers;
    List<Seller>? sellers;

    Application({
        this.id,
        this.clientId,
        this.requesterType,
        this.buyerRequesterType,
        this.sellerRequesterType,
        this.attorneyName,
        this.attorneyEmail,
        this.attorneyContact,
        this.documentsStatus,
        this.serviceChargeStatus,
        this.rejectionNote,
        this.moreDocuments,
        this.requestStatus,
        this.transferFee,
        this.transferFeeRefrence,
        this.transferSecurityDeposit,
        this.transferSecurityChequeDetails,
        this.transferSecurityChequeAttachment,
        this.transferSecurityStatus,
        this.transferFeeStatus,
        this.developerName,
        this.developerAddress,
        this.serviceChargeClearTill,
        this.nocValidity,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.salePurchaseAgreement,
        this.undertaking,
        this.attorneyPoa,
        this.attorneyPassport,
        this.attorneyIdFile,
        this.buyerCompanyTradeLicense,
        this.sellerCompanyTradeLicense,
        this.ownershipFile,
        this.attorneyPassportUrl,
        this.attorneyPoaUrl,
        this.attorneyIdFileUrl,
        this.buyerCompanyTradeLicenseUrl,
        this.sellerCompanyTradeLicenseUrl,
        this.transferSecurityChequeAttachmentUrl,
        this.undertakingUrl,
        this.ownershipFileUrl,
        this.buyers,
        this.sellers,
    });

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        clientId: json["client_id"],
        requesterType: json["requester_type"],
        buyerRequesterType: json["buyer_requester_type"],
        sellerRequesterType: json["seller_requester_type"],
        attorneyName: json["attorney_name"],
        attorneyEmail: json["attorney_email"],
        attorneyContact: json["attorney_contact"],
        documentsStatus: json["documents_status"],
        serviceChargeStatus: json["service_charge_status"],
        rejectionNote: json["rejection_note"],
        moreDocuments: json["more_documents"],
        requestStatus: json["request_status"],
        transferFee: json["transfer_fee"],
        transferFeeRefrence: json["transfer_fee_refrence"],
        transferSecurityDeposit: json["transfer_security_deposit"],
        transferSecurityChequeDetails: json["transfer_security_cheque_details"],
        transferSecurityChequeAttachment: json["transfer_security_cheque_attachment"],
        transferSecurityStatus: json["transfer_security_status"],
        transferFeeStatus: json["transfer_fee_status"],
        developerName: json["developer_name"],
        developerAddress: json["developer_address"],
        serviceChargeClearTill: json["service_charge_clear_till"],
        nocValidity: json["noc_validity"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        salePurchaseAgreement: json["sale_purchase_agreement"],
        undertaking: json["undertaking"],
        attorneyPoa: json["attorney_poa"],
        attorneyPassport: json["attorney_passport"],
        attorneyIdFile: json["attorney_id_file"],
        buyerCompanyTradeLicense: json["buyer_company_trade_license"],
        sellerCompanyTradeLicense: json["seller_company_trade_license"],
        ownershipFile: json["ownership_file"],
        attorneyPassportUrl: json["attorney_passport_url"],
        attorneyPoaUrl: json["attorney_poa_url"],
        attorneyIdFileUrl: json["attorney_id_file_url"],
        buyerCompanyTradeLicenseUrl: json["buyer_company_trade_license_url"],
        sellerCompanyTradeLicenseUrl: json["seller_company_trade_license_url"],
        transferSecurityChequeAttachmentUrl: json["transfer_security_cheque_attachment_url"],
        undertakingUrl: json["undertaking_url"],
        ownershipFileUrl: json["ownership_file_url"],
        buyers: json["buyers"] == null ? [] : List<Buyer>.from(json["buyers"]!.map((x) => Buyer.fromJson(x))),
        sellers: json["sellers"] == null ? [] : List<Seller>.from(json["sellers"]!.map((x) => Seller.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "requester_type": requesterType,
        "buyer_requester_type": buyerRequesterType,
        "seller_requester_type": sellerRequesterType,
        "attorney_name": attorneyName,
        "attorney_email": attorneyEmail,
        "attorney_contact": attorneyContact,
        "documents_status": documentsStatus,
        "service_charge_status": serviceChargeStatus,
        "rejection_note": rejectionNote,
        "more_documents": moreDocuments,
        "request_status": requestStatus,
        "transfer_fee": transferFee,
        "transfer_fee_refrence": transferFeeRefrence,
        "transfer_security_deposit": transferSecurityDeposit,
        "transfer_security_cheque_details": transferSecurityChequeDetails,
        "transfer_security_cheque_attachment": transferSecurityChequeAttachment,
        "transfer_security_status": transferSecurityStatus,
        "transfer_fee_status": transferFeeStatus,
        "developer_name": developerName,
        "developer_address": developerAddress,
        "service_charge_clear_till": serviceChargeClearTill,
        "noc_validity": nocValidity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "sale_purchase_agreement": salePurchaseAgreement,
        "undertaking": undertaking,
        "attorney_poa": attorneyPoa,
        "attorney_passport": attorneyPassport,
        "attorney_id_file": attorneyIdFile,
        "buyer_company_trade_license": buyerCompanyTradeLicense,
        "seller_company_trade_license": sellerCompanyTradeLicense,
        "ownership_file": ownershipFile,
        "attorney_passport_url": attorneyPassportUrl,
        "attorney_poa_url": attorneyPoaUrl,
        "attorney_id_file_url": attorneyIdFileUrl,
        "buyer_company_trade_license_url": buyerCompanyTradeLicenseUrl,
        "seller_company_trade_license_url": sellerCompanyTradeLicenseUrl,
        "transfer_security_cheque_attachment_url": transferSecurityChequeAttachmentUrl,
        "undertaking_url": undertakingUrl,
        "ownership_file_url": ownershipFileUrl,
        "buyers": buyers == null ? [] : List<dynamic>.from(buyers!.map((x) => x.toJson())),
        "sellers": sellers == null ? [] : List<dynamic>.from(sellers!.map((x) => x.toJson())),
    };
}

class Buyer {
    int? id;
    int? transferPropertyRequestId;
    dynamic buyerAuthorizedPerson;
    dynamic buyerAuthorizedPersonArabic;
    dynamic buyerTradeLicenseNumber;
    String? buyerName;
    String? buyerArabicName;
    String? gender;
    String? buyerBirthAddress;
    DateTime? buyerDob;
    DateTime? buyerPassportStart;
    String? buyerPassportPlace;
    int? buyerSharedValue;
    String? buyerResidenceNumber;
    String? buyerCellularNumber;
    String? buyerOfficeNumber;
    String? buyerPassportNumber;
    DateTime? buyerPassportExpiry;
    String? buyerEmail;
    String? buyerCitizenship;
    String? buyerEmiratesIdNumber;
    String? buyerResidentialStreetAddress;
    String? buyerResidentialCity;
    String? buyerResidentialCountry;
    String? buyerResidentialPobox;
    String? buyerResidentialZip;
    String? buyerCommunicationStreetAddress;
    String? buyerCommunicationCity;
    String? buyerCommunicationCountry;
    String? buyerCommunicationPobox;
    String? buyerCommunicationZip;
    String? buyerPassport;
    dynamic buyerVisa;
    String? buyerEmiratesId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? buyerPassportUrl;
    String? buyerVisaUrl;
    String? buyerEmiratesIdUrl;
    Country? country;

    Buyer({
        this.id,
        this.transferPropertyRequestId,
        this.buyerAuthorizedPerson,
        this.buyerAuthorizedPersonArabic,
        this.buyerTradeLicenseNumber,
        this.buyerName,
        this.buyerArabicName,
        this.gender,
        this.buyerBirthAddress,
        this.buyerDob,
        this.buyerPassportStart,
        this.buyerPassportPlace,
        this.buyerSharedValue,
        this.buyerResidenceNumber,
        this.buyerCellularNumber,
        this.buyerOfficeNumber,
        this.buyerPassportNumber,
        this.buyerPassportExpiry,
        this.buyerEmail,
        this.buyerCitizenship,
        this.buyerEmiratesIdNumber,
        this.buyerResidentialStreetAddress,
        this.buyerResidentialCity,
        this.buyerResidentialCountry,
        this.buyerResidentialPobox,
        this.buyerResidentialZip,
        this.buyerCommunicationStreetAddress,
        this.buyerCommunicationCity,
        this.buyerCommunicationCountry,
        this.buyerCommunicationPobox,
        this.buyerCommunicationZip,
        this.buyerPassport,
        this.buyerVisa,
        this.buyerEmiratesId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.buyerPassportUrl,
        this.buyerVisaUrl,
        this.buyerEmiratesIdUrl,
        this.country,
    });

    factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        id: json["id"],
        transferPropertyRequestId: json["transfer_property_request_id"],
        buyerAuthorizedPerson: json["buyer_authorized_person"],
        buyerAuthorizedPersonArabic: json["buyer_authorized_person_arabic"],
        buyerTradeLicenseNumber: json["buyer_trade_license_number"],
        buyerName: json["buyer_name"],
        buyerArabicName: json["buyer_arabic_name"],
        gender: json["gender"],
        buyerBirthAddress: json["buyer_birth_address"],
        buyerDob: json["buyer_dob"] == null ? null : DateTime.parse(json["buyer_dob"]),
        buyerPassportStart: json["buyer_passport_start"] == null ? null : DateTime.parse(json["buyer_passport_start"]),
        buyerPassportPlace: json["buyer_passport_place"],
        buyerSharedValue: json["buyer_shared_value"],
        buyerResidenceNumber: json["buyer_residence_number"],
        buyerCellularNumber: json["buyer_cellular_number"],
        buyerOfficeNumber: json["buyer_office_number"],
        buyerPassportNumber: json["buyer_passport_number"],
        buyerPassportExpiry: json["buyer_passport_expiry"] == null ? null : DateTime.parse(json["buyer_passport_expiry"]),
        buyerEmail: json["buyer_email"],
        buyerCitizenship: json["buyer_citizenship"],
        buyerEmiratesIdNumber: json["buyer_emirates_id_number"],
        buyerResidentialStreetAddress: json["buyer_residential_street_address"],
        buyerResidentialCity: json["buyer_residential_city"],
        buyerResidentialCountry: json["buyer_residential_country"],
        buyerResidentialPobox: json["buyer_residential_pobox"],
        buyerResidentialZip: json["buyer_residential_zip"],
        buyerCommunicationStreetAddress: json["buyer_communication_street_address"],
        buyerCommunicationCity: json["buyer_communication_city"],
        buyerCommunicationCountry: json["buyer_communication_country"],
        buyerCommunicationPobox: json["buyer_communication_pobox"],
        buyerCommunicationZip: json["buyer_communication_zip"],
        buyerPassport: json["buyer_passport"],
        buyerVisa: json["buyer_visa"],
        buyerEmiratesId: json["buyer_emirates_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        buyerPassportUrl: json["buyer_passport_url"],
        buyerVisaUrl: json["buyer_visa_url"],
        buyerEmiratesIdUrl: json["buyer_emirates_id_url"],
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transfer_property_request_id": transferPropertyRequestId,
        "buyer_authorized_person": buyerAuthorizedPerson,
        "buyer_authorized_person_arabic": buyerAuthorizedPersonArabic,
        "buyer_trade_license_number": buyerTradeLicenseNumber,
        "buyer_name": buyerName,
        "buyer_arabic_name": buyerArabicName,
        "gender": gender,
        "buyer_birth_address": buyerBirthAddress,
        "buyer_dob": buyerDob?.toIso8601String(),
        "buyer_passport_start": buyerPassportStart?.toIso8601String(),
        "buyer_passport_place": buyerPassportPlace,
        "buyer_shared_value": buyerSharedValue,
        "buyer_residence_number": buyerResidenceNumber,
        "buyer_cellular_number": buyerCellularNumber,
        "buyer_office_number": buyerOfficeNumber,
        "buyer_passport_number": buyerPassportNumber,
        "buyer_passport_expiry": buyerPassportExpiry?.toIso8601String(),
        "buyer_email": buyerEmail,
        "buyer_citizenship": buyerCitizenship,
        "buyer_emirates_id_number": buyerEmiratesIdNumber,
        "buyer_residential_street_address": buyerResidentialStreetAddress,
        "buyer_residential_city": buyerResidentialCity,
        "buyer_residential_country": buyerResidentialCountry,
        "buyer_residential_pobox": buyerResidentialPobox,
        "buyer_residential_zip": buyerResidentialZip,
        "buyer_communication_street_address": buyerCommunicationStreetAddress,
        "buyer_communication_city": buyerCommunicationCity,
        "buyer_communication_country": buyerCommunicationCountry,
        "buyer_communication_pobox": buyerCommunicationPobox,
        "buyer_communication_zip": buyerCommunicationZip,
        "buyer_passport": buyerPassport,
        "buyer_visa": buyerVisa,
        "buyer_emirates_id": buyerEmiratesId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "buyer_passport_url": buyerPassportUrl,
        "buyer_visa_url": buyerVisaUrl,
        "buyer_emirates_id_url": buyerEmiratesIdUrl,
        "country": country?.toJson(),
    };
}

class Country {
    int? id;
    String? name;
    String? label;
    String? value;

    Country({
        this.id,
        this.name,
        this.label,
        this.value,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        label: json["label"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "label": label,
        "value": value,
    };
}

class Seller {
    int? id;
    int? transferPropertyRequestId;
    dynamic sellerAuthorizedPerson;
    dynamic sellerTradeLicenseNumber;
    String? sellerName;
    dynamic sellerResidenceNumber;
    String? sellerCellularNumber;
    dynamic sellerOfficeNumber;
    dynamic sellerPassportNumber;
    dynamic sellerPassportExpiry;
    String? sellerEmail;
    dynamic sellerCitizenship;
    dynamic sellerResidentialStreetAddress;
    dynamic sellerResidentialCity;
    dynamic sellerResidentialCountry;
    dynamic sellerResidentialPobox;
    dynamic sellerResidentialZip;
    dynamic sellerCommunicationStreetAddress;
    dynamic sellerCommunicationCity;
    dynamic sellerCommunicationCountry;
    dynamic sellerCommunicationPobox;
    dynamic sellerCommunicationZip;
    String? sellerPassport;
    dynamic sellerVisa;
    String? sellerEmiratesId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? sellerPassportUrl;
    String? sellerVisaUrl;
    String? sellerEmiratesIdUrl;
    dynamic country;

    Seller({
        this.id,
        this.transferPropertyRequestId,
        this.sellerAuthorizedPerson,
        this.sellerTradeLicenseNumber,
        this.sellerName,
        this.sellerResidenceNumber,
        this.sellerCellularNumber,
        this.sellerOfficeNumber,
        this.sellerPassportNumber,
        this.sellerPassportExpiry,
        this.sellerEmail,
        this.sellerCitizenship,
        this.sellerResidentialStreetAddress,
        this.sellerResidentialCity,
        this.sellerResidentialCountry,
        this.sellerResidentialPobox,
        this.sellerResidentialZip,
        this.sellerCommunicationStreetAddress,
        this.sellerCommunicationCity,
        this.sellerCommunicationCountry,
        this.sellerCommunicationPobox,
        this.sellerCommunicationZip,
        this.sellerPassport,
        this.sellerVisa,
        this.sellerEmiratesId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.sellerPassportUrl,
        this.sellerVisaUrl,
        this.sellerEmiratesIdUrl,
        this.country,
    });

    factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        transferPropertyRequestId: json["transfer_property_request_id"],
        sellerAuthorizedPerson: json["seller_authorized_person"],
        sellerTradeLicenseNumber: json["seller_trade_license_number"],
        sellerName: json["seller_name"],
        sellerResidenceNumber: json["seller_residence_number"],
        sellerCellularNumber: json["seller_cellular_number"],
        sellerOfficeNumber: json["seller_office_number"],
        sellerPassportNumber: json["seller_passport_number"],
        sellerPassportExpiry: json["seller_passport_expiry"],
        sellerEmail: json["seller_email"],
        sellerCitizenship: json["seller_citizenship"],
        sellerResidentialStreetAddress: json["seller_residential_street_address"],
        sellerResidentialCity: json["seller_residential_city"],
        sellerResidentialCountry: json["seller_residential_country"],
        sellerResidentialPobox: json["seller_residential_pobox"],
        sellerResidentialZip: json["seller_residential_zip"],
        sellerCommunicationStreetAddress: json["seller_communication_street_address"],
        sellerCommunicationCity: json["seller_communication_city"],
        sellerCommunicationCountry: json["seller_communication_country"],
        sellerCommunicationPobox: json["seller_communication_pobox"],
        sellerCommunicationZip: json["seller_communication_zip"],
        sellerPassport: json["seller_passport"],
        sellerVisa: json["seller_visa"],
        sellerEmiratesId: json["seller_emirates_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        sellerPassportUrl: json["seller_passport_url"],
        sellerVisaUrl: json["seller_visa_url"],
        sellerEmiratesIdUrl: json["seller_emirates_id_url"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transfer_property_request_id": transferPropertyRequestId,
        "seller_authorized_person": sellerAuthorizedPerson,
        "seller_trade_license_number": sellerTradeLicenseNumber,
        "seller_name": sellerName,
        "seller_residence_number": sellerResidenceNumber,
        "seller_cellular_number": sellerCellularNumber,
        "seller_office_number": sellerOfficeNumber,
        "seller_passport_number": sellerPassportNumber,
        "seller_passport_expiry": sellerPassportExpiry,
        "seller_email": sellerEmail,
        "seller_citizenship": sellerCitizenship,
        "seller_residential_street_address": sellerResidentialStreetAddress,
        "seller_residential_city": sellerResidentialCity,
        "seller_residential_country": sellerResidentialCountry,
        "seller_residential_pobox": sellerResidentialPobox,
        "seller_residential_zip": sellerResidentialZip,
        "seller_communication_street_address": sellerCommunicationStreetAddress,
        "seller_communication_city": sellerCommunicationCity,
        "seller_communication_country": sellerCommunicationCountry,
        "seller_communication_pobox": sellerCommunicationPobox,
        "seller_communication_zip": sellerCommunicationZip,
        "seller_passport": sellerPassport,
        "seller_visa": sellerVisa,
        "seller_emirates_id": sellerEmiratesId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "seller_passport_url": sellerPassportUrl,
        "seller_visa_url": sellerVisaUrl,
        "seller_emirates_id_url": sellerEmiratesIdUrl,
        "country": country,
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
