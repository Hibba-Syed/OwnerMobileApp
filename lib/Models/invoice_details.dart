// To parse this JSON data, do
//
//     final invoiceDetailsModel = invoiceDetailsModelFromJson(jsonString);

import 'dart:convert';

InvoiceDetailsModel invoiceDetailsModelFromJson(String str) =>
    InvoiceDetailsModel.fromJson(json.decode(str));

String invoiceDetailsModelToJson(InvoiceDetailsModel data) =>
    json.encode(data.toJson());

class InvoiceDetailsModel {
  int? id;
  String? reference;
  String? referenceCounter;
  String? title;
  String? type;
  dynamic externalId;
  dynamic invoiceExternalReference;
  dynamic invoiceImportId;
  int? associationId;
  int? companyId;
  int? unitId;
  String? books;
  String? invoiceableType;
  int? invoiceableId;
  int? userId;
  dynamic memo;
  dynamic note;
  String? status;
  String? allocatedStatus;
  DateTime? datetime;
  DateTime? dueDate;
  dynamic invoiceExternalPdf;
  String? pdfPath;
  int? showResident;
  int? showPaymentLink;
  dynamic bankAccountId;
  String? spo;
  dynamic sentTo;
  dynamic sent;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  double? amount;
  double? vat;
  bool? isBalanced;
  String? description;
  String? pdfUrl;
  List<Transaction>? transactions;
  List<dynamic>? documents;
  Association? association;
  Invoiceable? invoiceable;
  List<dynamic>? externalEntries;
  dynamic invoiceImports;

  InvoiceDetailsModel({
    this.id,
    this.reference,
    this.referenceCounter,
    this.title,
    this.type,
    this.externalId,
    this.invoiceExternalReference,
    this.invoiceImportId,
    this.associationId,
    this.companyId,
    this.unitId,
    this.books,
    this.invoiceableType,
    this.invoiceableId,
    this.userId,
    this.memo,
    this.note,
    this.status,
    this.allocatedStatus,
    this.datetime,
    this.dueDate,
    this.invoiceExternalPdf,
    this.pdfPath,
    this.showResident,
    this.showPaymentLink,
    this.bankAccountId,
    this.spo,
    this.sentTo,
    this.sent,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.amount,
    this.vat,
    this.isBalanced,
    this.description,
    this.pdfUrl,
    this.transactions,
    this.documents,
    this.association,
    this.invoiceable,
    this.externalEntries,
    this.invoiceImports,
  });

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsModel(
        id: json["id"],
        reference: json["reference"],
        referenceCounter: json["reference_counter"],
        title: json["title"],
        type: json["type"],
        externalId: json["external_id"],
        invoiceExternalReference: json["invoice_external_reference"],
        invoiceImportId: json["invoice_import_id"],
        associationId: json["association_id"],
        companyId: json["company_id"],
        unitId: json["unit_id"],
        books: json["books"],
        invoiceableType: json["invoiceable_type"],
        invoiceableId: json["invoiceable_id"],
        userId: json["user_id"],
        memo: json["memo"],
        note: json["note"],
        status: json["status"],
        allocatedStatus: json["allocated_status"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        invoiceExternalPdf: json["invoice_external_pdf"],
        pdfPath: json["pdf_path"],
        showResident: json["show_resident"],
        showPaymentLink: json["show_payment_link"],
        bankAccountId: json["bank_account_id"],
        spo: json["spo"],
        sentTo: json["sent_to"],
        sent: json["sent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        amount: json["amount"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        isBalanced: json["is_balanced"],
        description: json["description"],
        pdfUrl: json["pdf_url"],
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
        documents: json["documents"] == null
            ? []
            : List<dynamic>.from(json["documents"]!.map((x) => x)),
        association: json["association"] == null
            ? null
            : Association.fromJson(json["association"]),
        invoiceable: json["invoiceable"] == null
            ? null
            : Invoiceable.fromJson(json["invoiceable"]),
        externalEntries: json["external_entries"] == null
            ? []
            : List<dynamic>.from(json["external_entries"]!.map((x) => x)),
        invoiceImports: json["invoice_imports"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "reference_counter": referenceCounter,
        "title": title,
        "type": type,
        "external_id": externalId,
        "invoice_external_reference": invoiceExternalReference,
        "invoice_import_id": invoiceImportId,
        "association_id": associationId,
        "company_id": companyId,
        "unit_id": unitId,
        "books": books,
        "invoiceable_type": invoiceableType,
        "invoiceable_id": invoiceableId,
        "user_id": userId,
        "memo": memo,
        "note": note,
        "status": status,
        "allocated_status": allocatedStatus,
        "datetime":
            "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "invoice_external_pdf": invoiceExternalPdf,
        "pdf_path": pdfPath,
        "show_resident": showResident,
        "show_payment_link": showPaymentLink,
        "bank_account_id": bankAccountId,
        "spo": spo,
        "sent_to": sentTo,
        "sent": sent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "amount": amount,
        "vat": vat,
        "is_balanced": isBalanced,
        "description": description,
        "pdf_url": pdfUrl,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
        "association": association?.toJson(),
        "invoiceable": invoiceable?.toJson(),
        "external_entries": externalEntries == null
            ? []
            : List<dynamic>.from(externalEntries!.map((x) => x)),
        "invoice_imports": invoiceImports,
      };
}

class Association {
  int? id;
  String? name;
  String? email;
  String? address1;
  dynamic address2;
  int? cityId;
  dynamic stateId;
  int? countryId;
  dynamic postcode;
  String? trnNumber;
  int? isTrn;
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
  City? city;
  dynamic associationType;

  Association({
    this.id,
    this.name,
    this.email,
    this.address1,
    this.address2,
    this.cityId,
    this.stateId,
    this.countryId,
    this.postcode,
    this.trnNumber,
    this.isTrn,
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
        email: json["email"],
        address1: json["address1"],
        address2: json["address2"],
        cityId: json["city_id"],
        stateId: json["state_id"],
        countryId: json["country_id"],
        postcode: json["postcode"],
        trnNumber: json["trn_number"],
        isTrn: json["is_trn"],
        remainingUnit: json["remaining_unit"],
        aboutPageImageUrl: json["about_page_image_url"],
        backgroundImageUrl: json["background_image_url"],
        logoImageUrl: json["logo_image_url"],
        fullAddress: json["full_address"],
        unitsArea: json["units_area"],
        applicableArea: json["applicable_area"],
        suiteArea: json["suite_area"],
        balconyArea: json["balcony_area"],
        filledParkings: json["filled_parkings"].toString(),
        subdomain: json["subdomain"],
        contractUrl: json["contract_url"],
        gmap: json["gmap"],
        paymentGatewayEnabled: json["payment_gateway_enabled"],
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        associationType: json["association_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address1": address1,
        "address2": address2,
        "city_id": cityId,
        "state_id": stateId,
        "country_id": countryId,
        "postcode": postcode,
        "trn_number": trnNumber,
        "is_trn": isTrn,
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
        "city": city?.toJson(),
        "association_type": associationType,
      };
}

class City {
  int? id;
  String? name;
  int? stateId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? label;
  String? value;

  City({
    this.id,
    this.name,
    this.stateId,
    this.createdAt,
    this.updatedAt,
    this.label,
    this.value,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "label": label,
        "value": value,
      };
}

class Invoiceable {
  int? id;
  int? associationId;
  String? unitNumber;
  String? name;
  dynamic mollakUnitName;
  int? unitSizeSqft;
  int? unitTypeId;
  int? componentId;
  dynamic subComponentId;
  dynamic balconyArea;
  dynamic suiteArea;
  dynamic applicableArea;
  dynamic virtualAccountNumber;
  dynamic plotNo;
  int? parkingCount;
  int? actualArea;
  int? bedroomCount;
  dynamic bathroomCount;
  int? isOccupied;
  dynamic datePurchased;
  int? isActive;
  dynamic saleDeed;
  int? isParkingAvailable;
  int? parkings;
  dynamic adult;
  dynamic child;
  dynamic residentId;
  dynamic agentId;
  dynamic leaseCompanyId;
  dynamic unitExternalId;
  int? isMollakEnable;
  int? recoveryReminderStatus;
  String? status;
  int? balance;
  dynamic pdc;
  int? isLfpExempt;
  dynamic mollakBuildingEnglishName;
  dynamic mollakBuildingArabicName;
  String? dtcmPermit;
  dynamic dtcmPermitStart;
  dynamic dtcmPermitExpiry;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic deletedAt;
  bool? isLegalNoticeActive;
  bool? isRdcActive;
  InvoiceableOwner? owner;
  dynamic resident;

  Invoiceable({
    this.id,
    this.associationId,
    this.unitNumber,
    this.name,
    this.mollakUnitName,
    this.unitSizeSqft,
    this.unitTypeId,
    this.componentId,
    this.subComponentId,
    this.balconyArea,
    this.suiteArea,
    this.applicableArea,
    this.virtualAccountNumber,
    this.plotNo,
    this.parkingCount,
    this.actualArea,
    this.bedroomCount,
    this.bathroomCount,
    this.isOccupied,
    this.datePurchased,
    this.isActive,
    this.saleDeed,
    this.isParkingAvailable,
    this.parkings,
    this.adult,
    this.child,
    this.residentId,
    this.agentId,
    this.leaseCompanyId,
    this.unitExternalId,
    this.isMollakEnable,
    this.recoveryReminderStatus,
    this.status,
    this.balance,
    this.pdc,
    this.isLfpExempt,
    this.mollakBuildingEnglishName,
    this.mollakBuildingArabicName,
    this.dtcmPermit,
    this.dtcmPermitStart,
    this.dtcmPermitExpiry,
    this.updatedAt,
    this.createdAt,
    this.deletedAt,
    this.isLegalNoticeActive,
    this.isRdcActive,
    this.owner,
    this.resident,
  });

  factory Invoiceable.fromJson(Map<String, dynamic> json) => Invoiceable(
        id: json["id"],
        associationId: json["association_id"],
        unitNumber: json["unit_number"],
        name: json["name"],
        mollakUnitName: json["mollak_unit_name"],
        unitSizeSqft: json["unit_size_sqft"],
        unitTypeId: json["unit_type_id"],
        componentId: json["component_id"],
        subComponentId: json["sub_component_id"],
        balconyArea: json["balcony_area"],
        suiteArea: json["suite_area"],
        applicableArea: json["applicable_area"],
        virtualAccountNumber: json["virtual_account_number"],
        plotNo: json["plot_no"],
        parkingCount: json["parking_count"],
        actualArea: json["actual_area"],
        bedroomCount: json["bedroom_count"],
        bathroomCount: json["bathroom_count"],
        isOccupied: json["is_occupied"],
        datePurchased: json["date_purchased"],
        isActive: json["is_active"],
        saleDeed: json["sale_deed"],
        isParkingAvailable: json["is_parking_available"],
        parkings: json["parkings"],
        adult: json["adult"],
        child: json["child"],
        residentId: json["resident_id"],
        agentId: json["agent_id"],
        leaseCompanyId: json["lease_company_id"],
        unitExternalId: json["unit_external_id"],
        isMollakEnable: json["is_mollak_enable"],
        recoveryReminderStatus: json["recovery_reminder_status"],
        status: json["status"],
        balance: json["balance"],
        pdc: json["pdc"],
        isLfpExempt: json["is_lfp_exempt"],
        mollakBuildingEnglishName: json["mollak_building_english_name"],
        mollakBuildingArabicName: json["mollak_building_arabic_name"],
        dtcmPermit: json["dtcm_permit"],
        dtcmPermitStart: json["dtcm_permit_start"],
        dtcmPermitExpiry: json["dtcm_permit_expiry"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
        isLegalNoticeActive: json["is_legal_notice_active"],
        isRdcActive: json["is_rdc_active"],
        owner: json["owner"] == null
            ? null
            : InvoiceableOwner.fromJson(json["owner"]),
        resident: json["resident"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "association_id": associationId,
        "unit_number": unitNumber,
        "name": name,
        "mollak_unit_name": mollakUnitName,
        "unit_size_sqft": unitSizeSqft,
        "unit_type_id": unitTypeId,
        "component_id": componentId,
        "sub_component_id": subComponentId,
        "balcony_area": balconyArea,
        "suite_area": suiteArea,
        "applicable_area": applicableArea,
        "virtual_account_number": virtualAccountNumber,
        "plot_no": plotNo,
        "parking_count": parkingCount,
        "actual_area": actualArea,
        "bedroom_count": bedroomCount,
        "bathroom_count": bathroomCount,
        "is_occupied": isOccupied,
        "date_purchased": datePurchased,
        "is_active": isActive,
        "sale_deed": saleDeed,
        "is_parking_available": isParkingAvailable,
        "parkings": parkings,
        "adult": adult,
        "child": child,
        "resident_id": residentId,
        "agent_id": agentId,
        "lease_company_id": leaseCompanyId,
        "unit_external_id": unitExternalId,
        "is_mollak_enable": isMollakEnable,
        "recovery_reminder_status": recoveryReminderStatus,
        "status": status,
        "balance": balance,
        "pdc": pdc,
        "is_lfp_exempt": isLfpExempt,
        "mollak_building_english_name": mollakBuildingEnglishName,
        "mollak_building_arabic_name": mollakBuildingArabicName,
        "dtcm_permit": dtcmPermit,
        "dtcm_permit_start": dtcmPermitStart,
        "dtcm_permit_expiry": dtcmPermitExpiry,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "is_legal_notice_active": isLegalNoticeActive,
        "is_rdc_active": isRdcActive,
        "owner": owner?.toJson(),
        "resident": resident,
      };
}

class InvoiceableOwner {
  int? id;
  int? ownerId;
  int? unitId;
  int? isPrimary;
  int? isCurrent;
  String? titleDeedUrl;
  OwnerOwner? owner;

  InvoiceableOwner({
    this.id,
    this.ownerId,
    this.unitId,
    this.isPrimary,
    this.isCurrent,
    this.titleDeedUrl,
    this.owner,
  });

  factory InvoiceableOwner.fromJson(Map<String, dynamic> json) =>
      InvoiceableOwner(
        id: json["id"],
        ownerId: json["owner_id"],
        unitId: json["unit_id"],
        isPrimary: json["is_primary"],
        isCurrent: json["is_current"],
        titleDeedUrl: json["title_deed_url"],
        owner:
            json["owner"] == null ? null : OwnerOwner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "unit_id": unitId,
        "is_primary": isPrimary,
        "is_current": isCurrent,
        "title_deed_url": titleDeedUrl,
        "owner": owner?.toJson(),
      };
}

class OwnerOwner {
  int? id;
  String? firstName;
  String? lastName;
  String? trnNumber;
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

  OwnerOwner({
    this.id,
    this.firstName,
    this.lastName,
    this.trnNumber,
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
  });

  factory OwnerOwner.fromJson(Map<String, dynamic> json) => OwnerOwner(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        trnNumber: json["trn_number"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "trn_number": trnNumber,
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
      };
}

class Transaction {
  int? id;
  int? accountId;
  String? type;
  double? amount;
  double? vat;
  dynamic memo;
  String? note;
  dynamic userReference;
  String? transactionableType;
  int? transactionableId;
  String? reason;
  String? ledgerableName;
  bool? isReconciled;
  bool? isCash;
  List<Ledgerable>? ledgerables;
  double? totalAmount;
  String? description;
  Account? account;

  Transaction({
    this.id,
    this.accountId,
    this.type,
    this.amount,
    this.vat,
    this.memo,
    this.note,
    this.userReference,
    this.transactionableType,
    this.transactionableId,
    this.reason,
    this.ledgerableName,
    this.isReconciled,
    this.isCash,
    this.ledgerables,
    this.totalAmount,
    this.description,
    this.account,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        accountId: json["account_id"],
        type: json["type"],
        amount: json["amount"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        memo: json["memo"],
        note: json["note"],
        userReference: json["user_reference"],
        transactionableType: json["transactionable_type"],
        transactionableId: json["transactionable_id"],
        reason: json["reason"],
        ledgerableName: json["ledgerable_name"],
        isReconciled: json["is_reconciled"],
        isCash: json["is_cash"],
        ledgerables: json["ledgerables"] == null
            ? []
            : List<Ledgerable>.from(
                json["ledgerables"]!.map((x) => Ledgerable.fromJson(x))),
        totalAmount: json["total_amount"]?.toDouble(),
        description: json["description"],
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_id": accountId,
        "type": type,
        "amount": amount,
        "vat": vat,
        "memo": memo,
        "note": note,
        "user_reference": userReference,
        "transactionable_type": transactionableType,
        "transactionable_id": transactionableId,
        "reason": reason,
        "ledgerable_name": ledgerableName,
        "is_reconciled": isReconciled,
        "is_cash": isCash,
        "ledgerables": ledgerables == null
            ? []
            : List<dynamic>.from(ledgerables!.map((x) => x.toJson())),
        "total_amount": totalAmount,
        "description": description,
        "account": account?.toJson(),
      };
}

class Account {
  int? id;
  String? name;
  dynamic invoiceTypeCode;
  int? isVat;
  String? title;
  String? fullName;
  String? longName;
  bool? isUnitPrimary;
  bool? isUnitShown;

  Account({
    this.id,
    this.name,
    this.invoiceTypeCode,
    this.isVat,
    this.title,
    this.fullName,
    this.longName,
    this.isUnitPrimary,
    this.isUnitShown,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        invoiceTypeCode: json["invoice_type_code"],
        isVat: json["is_vat"],
        title: json["title"],
        fullName: json["full_name"],
        longName: json["long_name"],
        isUnitPrimary: json["is_unit_primary"],
        isUnitShown: json["is_unit_shown"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "invoice_type_code": invoiceTypeCode,
        "is_vat": isVat,
        "title": title,
        "full_name": fullName,
        "long_name": longName,
        "is_unit_primary": isUnitPrimary,
        "is_unit_shown": isUnitShown,
      };
}

class Ledgerable {
  int? id;
  String? name;
  String? type;

  Ledgerable({
    this.id,
    this.name,
    this.type,
  });

  factory Ledgerable.fromJson(Map<String, dynamic> json) => Ledgerable(
        id: json["id"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
      };
}
