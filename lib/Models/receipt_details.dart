// To parse this JSON data, do
//
//     final receiptDetailsModel = receiptDetailsModelFromJson(jsonString);

import 'dart:convert';

ReceiptDetailsModel receiptDetailsModelFromJson(String str) =>
    ReceiptDetailsModel.fromJson(json.decode(str));

String receiptDetailsModelToJson(ReceiptDetailsModel data) =>
    json.encode(data.toJson());

class ReceiptDetailsModel {
  int? id;
  String? reference;
  String? title;
  dynamic receiptExternalReference;
  int? associationId;
  int? companyId;
  int? userId;
  int? accountId;
  dynamic receiptableId;
  dynamic receiptableType;
  String? paymentMethod;
  String? payeeType;
  int? payeeId;
  dynamic memo;
  dynamic note;
  String? type;
  String? books;
  int? isPushed;
  dynamic pushedAt;
  int? isLocked;
  dynamic lockReason;
  dynamic pulledAt;
  dynamic syncedAt;
  DateTime? datetime;
  dynamic cancelDate;
  DateTime? paymentDate;
  String? status;
  int? sent;
  dynamic cancelReason;
  dynamic holdTill;
  dynamic holdNote;
  dynamic pdfPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic cancelledAt;
  double? amount;
  double? vat;
  double? advanceAmount;
  double? advanceVat;
  bool? isReconciled;
  bool? isCash;
  bool? isBalanced;
  List<Unitwise>? unitwise;
  bool? isPushable;
  String? description;
  String? pdfUrl;
  List<Transaction>? transactions;
  List<dynamic>? documents;
  Association? association;
  Payee? payee;
  ReceiptDetailsModelAccount? account;

  ReceiptDetailsModel({
    this.id,
    this.reference,
    this.title,
    this.receiptExternalReference,
    this.associationId,
    this.companyId,
    this.userId,
    this.accountId,
    this.receiptableId,
    this.receiptableType,
    this.paymentMethod,
    this.payeeType,
    this.payeeId,
    this.memo,
    this.note,
    this.type,
    this.books,
    this.isPushed,
    this.pushedAt,
    this.isLocked,
    this.lockReason,
    this.pulledAt,
    this.syncedAt,
    this.datetime,
    this.cancelDate,
    this.paymentDate,
    this.status,
    this.sent,
    this.cancelReason,
    this.holdTill,
    this.holdNote,
    this.pdfPath,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cancelledAt,
    this.amount,
    this.vat,
    this.advanceAmount,
    this.advanceVat,
    this.isReconciled,
    this.isCash,
    this.isBalanced,
    this.unitwise,
    this.isPushable,
    this.description,
    this.pdfUrl,
    this.transactions,
    this.documents,
    this.association,
    this.payee,
    this.account,
  });

  factory ReceiptDetailsModel.fromJson(Map<String, dynamic> json) =>
      ReceiptDetailsModel(
        id: json["id"],
        reference: json["reference"],
        title: json["title"],
        receiptExternalReference: json["receipt_external_reference"],
        associationId: json["association_id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        accountId: json["account_id"],
        receiptableId: json["receiptable_id"],
        receiptableType: json["receiptable_type"],
        paymentMethod: json["payment_method"],
        payeeType: json["payee_type"],
        payeeId: json["payee_id"],
        memo: json["memo"],
        note: json["note"],
        type: json["type"],
        books: json["books"],
        isPushed: json["is_pushed"],
        pushedAt: json["pushed_at"],
        isLocked: json["is_locked"],
        lockReason: json["lock_reason"],
        pulledAt: json["pulled_at"],
        syncedAt: json["synced_at"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        cancelDate: json["cancel_date"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        status: json["status"],
        sent: json["sent"],
        cancelReason: json["cancel_reason"],
        holdTill: json["hold_till"],
        holdNote: json["hold_note"],
        pdfPath: json["pdf_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        cancelledAt: json["cancelled_at"],
        amount: json["amount"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        advanceAmount: json["advance_amount"]?.toDouble(),
        advanceVat: json["advance_vat"]?.toDouble(),
        isReconciled: json["is_reconciled"],
        isCash: json["is_cash"],
        isBalanced: json["is_balanced"],
        unitwise: json["unitwise"] == null
            ? []
            : List<Unitwise>.from(
                json["unitwise"]!.map((x) => Unitwise.fromJson(x))),
        isPushable: json["is_pushable"],
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
        payee: json["payee"] == null ? null : Payee.fromJson(json["payee"]),
        account: json["account"] == null
            ? null
            : ReceiptDetailsModelAccount.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "title": title,
        "receipt_external_reference": receiptExternalReference,
        "association_id": associationId,
        "company_id": companyId,
        "user_id": userId,
        "account_id": accountId,
        "receiptable_id": receiptableId,
        "receiptable_type": receiptableType,
        "payment_method": paymentMethod,
        "payee_type": payeeType,
        "payee_id": payeeId,
        "memo": memo,
        "note": note,
        "type": type,
        "books": books,
        "is_pushed": isPushed,
        "pushed_at": pushedAt,
        "is_locked": isLocked,
        "lock_reason": lockReason,
        "pulled_at": pulledAt,
        "synced_at": syncedAt,
        "datetime":
            "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
        "cancel_date": cancelDate,
        "payment_date":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "sent": sent,
        "cancel_reason": cancelReason,
        "hold_till": holdTill,
        "hold_note": holdNote,
        "pdf_path": pdfPath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "cancelled_at": cancelledAt,
        "amount": amount,
        "vat": vat,
        "advance_amount": advanceAmount,
        "advance_vat": advanceVat,
        "is_reconciled": isReconciled,
        "is_cash": isCash,
        "is_balanced": isBalanced,
        "unitwise": unitwise == null
            ? []
            : List<dynamic>.from(unitwise!.map((x) => x.toJson())),
        "is_pushable": isPushable,
        "description": description,
        "pdf_url": pdfUrl,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
        "association": association?.toJson(),
        "payee": payee?.toJson(),
        "account": account?.toJson(),
      };
}

class ReceiptDetailsModelAccount {
  int? id;
  String? name;
  String? prefix;
  dynamic code;
  String? type;
  String? subType;
  int? bankAccountId;
  String? title;
  String? fullName;
  String? longName;
  bool? isUnitPrimary;
  bool? isUnitShown;

  ReceiptDetailsModelAccount({
    this.id,
    this.name,
    this.prefix,
    this.code,
    this.type,
    this.subType,
    this.bankAccountId,
    this.title,
    this.fullName,
    this.longName,
    this.isUnitPrimary,
    this.isUnitShown,
  });

  factory ReceiptDetailsModelAccount.fromJson(Map<String, dynamic> json) =>
      ReceiptDetailsModelAccount(
        id: json["id"],
        name: json["name"],
        prefix: json["prefix"],
        code: json["code"],
        type: json["type"],
        subType: json["sub_type"],
        bankAccountId: json["bank_account_id"],
        title: json["title"],
        fullName: json["full_name"],
        longName: json["long_name"],
        isUnitPrimary: json["is_unit_primary"],
        isUnitShown: json["is_unit_shown"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "prefix": prefix,
        "code": code,
        "type": type,
        "sub_type": subType,
        "bank_account_id": bankAccountId,
        "title": title,
        "full_name": fullName,
        "long_name": longName,
        "is_unit_primary": isUnitPrimary,
        "is_unit_shown": isUnitShown,
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
  double? unitsArea;
  double? applicableArea;
  double? suiteArea;
  double? balconyArea;
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
        unitsArea: json["units_area"]?.toDouble(),
        applicableArea: json["applicable_area"]?.toDouble(),
        suiteArea: json["suite_area"]?.toDouble(),
        balconyArea: json["balcony_area"]?.toDouble(),
        filledParkings: json["filled_parkings"]?.toString(),
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

class Payee {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
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

  Payee({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
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

  factory Payee.fromJson(Map<String, dynamic> json) => Payee(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        email: json["email"],
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
        "mobile": mobile,
        "email": email,
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
  String? memo;
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
  TransactionAccount? account;
  dynamic ledgerable;

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
    this.ledgerable,
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
        account: json["account"] == null
            ? null
            : TransactionAccount.fromJson(json["account"]),
        ledgerable: json["ledgerable"],
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
        "ledgerable": ledgerable,
      };
}

class TransactionAccount {
  int? id;
  String? name;
  String? invoiceTypeCode;
  int? isVat;
  String? title;
  String? fullName;
  String? longName;
  bool? isUnitPrimary;
  bool? isUnitShown;

  TransactionAccount({
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

  factory TransactionAccount.fromJson(Map<String, dynamic> json) =>
      TransactionAccount(
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

class Unitwise {
  int? id;
  String? type;
  String? unit;
  String? name;
  dynamic trn;
  int? associationId;
  double? actualAmount;
  double? actualVat;
  double? amount;
  double? vat;
  double? advanceAmount;
  double? advanceVat;
  Owner? owner;
  bool? isPushable;

  Unitwise({
    this.id,
    this.type,
    this.unit,
    this.name,
    this.trn,
    this.associationId,
    this.actualAmount,
    this.actualVat,
    this.amount,
    this.vat,
    this.advanceAmount,
    this.advanceVat,
    this.owner,
    this.isPushable,
  });

  factory Unitwise.fromJson(Map<String, dynamic> json) => Unitwise(
        id: json["id"],
        type: json["type"],
        unit: json["unit"],
        name: json["name"],
        trn: json["trn"],
        associationId: json["association_id"],
        actualAmount: json["actual_amount"]?.toDouble(),
        actualVat: json["actual_vat"]?.toDouble(),
        amount: json["amount"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        advanceAmount: json["advance_amount"]?.toDouble(),
        advanceVat: json["advance_vat"]?.toDouble(),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        isPushable: json["is_pushable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "unit": unit,
        "name": name,
        "trn": trn,
        "association_id": associationId,
        "actual_amount": actualAmount,
        "actual_vat": actualVat,
        "amount": amount,
        "vat": vat,
        "advance_amount": advanceAmount,
        "advance_vat": advanceVat,
        "owner": owner?.toJson(),
        "is_pushable": isPushable,
      };
}

class Owner {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? mobile;
  String? trnNumber;

  Owner({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.mobile,
    this.trnNumber,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        email: json["email"],
        mobile: json["mobile"],
        trnNumber: json["trn_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "full_name": fullName,
        "email": email,
        "mobile": mobile,
        "trn_number": trnNumber,
      };
}
