// To parse this JSON data, do
//
//     final creditNoteDetailsModel = creditNoteDetailsModelFromJson(jsonString);

import 'dart:convert';

CreditNoteDetailsModel creditNoteDetailsModelFromJson(String str) =>
    CreditNoteDetailsModel.fromJson(json.decode(str));

String creditNoteDetailsModelToJson(CreditNoteDetailsModel data) =>
    json.encode(data.toJson());

class CreditNoteDetailsModel {
  int? id;
  String? reference;
  int? companyId;
  int? associationId;
  String? creditableType;
  int? creditableId;
  dynamic noteableType;
  dynamic noteableId;
  String? books;
  int? userId;
  String? title;
  dynamic memo;
  dynamic note;
  DateTime? datetime;
  dynamic pdfPath;
  dynamic sentTo;
  dynamic sent;
  int? showResident;
  String? type;
  String? spo;
  String? status;
  int? isPushed;
  dynamic pushedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalAmount;
  int? totalVat;
  String? description;
  String? pdfUrl;
  bool? isPushable;
  List<Transaction>? transactions;
  Association? association;
  Creditable? creditable;
  List<dynamic>? documents;

  CreditNoteDetailsModel({
    this.id,
    this.reference,
    this.companyId,
    this.associationId,
    this.creditableType,
    this.creditableId,
    this.noteableType,
    this.noteableId,
    this.books,
    this.userId,
    this.title,
    this.memo,
    this.note,
    this.datetime,
    this.pdfPath,
    this.sentTo,
    this.sent,
    this.showResident,
    this.type,
    this.spo,
    this.status,
    this.isPushed,
    this.pushedAt,
    this.createdAt,
    this.updatedAt,
    this.totalAmount,
    this.totalVat,
    this.description,
    this.pdfUrl,
    this.isPushable,
    this.transactions,
    this.association,
    this.creditable,
    this.documents,
  });

  factory CreditNoteDetailsModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteDetailsModel(
        id: json["id"],
        reference: json["reference"],
        companyId: json["company_id"],
        associationId: json["association_id"],
        creditableType: json["creditable_type"],
        creditableId: json["creditable_id"],
        noteableType: json["noteable_type"],
        noteableId: json["noteable_id"],
        books: json["books"],
        userId: json["user_id"],
        title: json["title"],
        memo: json["memo"],
        note: json["note"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        pdfPath: json["pdf_path"],
        sentTo: json["sent_to"],
        sent: json["sent"],
        showResident: json["show_resident"],
        type: json["type"],
        spo: json["spo"],
        status: json["status"],
        isPushed: json["is_pushed"],
        pushedAt: json["pushed_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalAmount: json["total_amount"],
        totalVat: json["total_vat"],
        description: json["description"],
        pdfUrl: json["pdf_url"],
        isPushable: json["is_pushable"],
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
        association: json["association"] == null
            ? null
            : Association.fromJson(json["association"]),
        creditable: json["creditable"] == null
            ? null
            : Creditable.fromJson(json["creditable"]),
        documents: json["documents"] == null
            ? []
            : List<dynamic>.from(json["documents"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "company_id": companyId,
        "association_id": associationId,
        "creditable_type": creditableType,
        "creditable_id": creditableId,
        "noteable_type": noteableType,
        "noteable_id": noteableId,
        "books": books,
        "user_id": userId,
        "title": title,
        "memo": memo,
        "note": note,
        "datetime":
            "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
        "pdf_path": pdfPath,
        "sent_to": sentTo,
        "sent": sent,
        "show_resident": showResident,
        "type": type,
        "spo": spo,
        "status": status,
        "is_pushed": isPushed,
        "pushed_at": pushedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_amount": totalAmount,
        "total_vat": totalVat,
        "description": description,
        "pdf_url": pdfUrl,
        "is_pushable": isPushable,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "association": association?.toJson(),
        "creditable": creditable?.toJson(),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
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

class Creditable {
  int? id;
  String? unitNumber;
  bool? isLegalNoticeActive;
  bool? isRdcActive;
  Owner? owner;

  Creditable({
    this.id,
    this.unitNumber,
    this.isLegalNoticeActive,
    this.isRdcActive,
    this.owner,
  });

  factory Creditable.fromJson(Map<String, dynamic> json) => Creditable(
        id: json["id"],
        unitNumber: json["unit_number"],
        isLegalNoticeActive: json["is_legal_notice_active"],
        isRdcActive: json["is_rdc_active"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_number": unitNumber,
        "is_legal_notice_active": isLegalNoticeActive,
        "is_rdc_active": isRdcActive,
        "owner": owner?.toJson(),
      };
}

class Owner {
  int? id;
  int? ownerId;
  int? unitId;
  int? isPrimary;
  int? isCurrent;
  String? titleDeedUrl;
  dynamic owner;

  Owner({
    this.id,
    this.ownerId,
    this.unitId,
    this.isPrimary,
    this.isCurrent,
    this.titleDeedUrl,
    this.owner,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        ownerId: json["owner_id"],
        unitId: json["unit_id"],
        isPrimary: json["is_primary"],
        isCurrent: json["is_current"],
        titleDeedUrl: json["title_deed_url"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "unit_id": unitId,
        "is_primary": isPrimary,
        "is_current": isCurrent,
        "title_deed_url": titleDeedUrl,
        "owner": owner,
      };
}

class Transaction {
  int? id;
  String? trxNumber;
  int? accountId;
  String? ledgerableType;
  int? ledgerableId;
  String? books;
  String? type;
  double? amount;
  int? vat;
  int? vatRate;
  int? advanceAmount;
  int? advanceVat;
  int? balance;
  String? note;
  String? memo;
  dynamic userReference;
  dynamic paymentMethod;
  dynamic budgetId;
  int? isRf;
  int? userId;
  int? companyId;
  int? associationId;
  int? transactionId;
  int? transactionableId;
  String? transactionableType;
  String? reason;
  DateTime? datetime;
  dynamic bankTransactionId;
  dynamic reconciledAt;
  dynamic contraEntryId;
  dynamic expectedLedgerableType;
  dynamic expectedLedgerableId;
  dynamic taxReturnId;
  dynamic jvId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic cancelledAt;
  String? ledgerableName;
  bool? isReconciled;
  bool? isCash;
  List<Ledgerable>? ledgerables;
  int? totalAmount;
  String? description;
  Account? account;

  Transaction({
    this.id,
    this.trxNumber,
    this.accountId,
    this.ledgerableType,
    this.ledgerableId,
    this.books,
    this.type,
    this.amount,
    this.vat,
    this.vatRate,
    this.advanceAmount,
    this.advanceVat,
    this.balance,
    this.note,
    this.memo,
    this.userReference,
    this.paymentMethod,
    this.budgetId,
    this.isRf,
    this.userId,
    this.companyId,
    this.associationId,
    this.transactionId,
    this.transactionableId,
    this.transactionableType,
    this.reason,
    this.datetime,
    this.bankTransactionId,
    this.reconciledAt,
    this.contraEntryId,
    this.expectedLedgerableType,
    this.expectedLedgerableId,
    this.taxReturnId,
    this.jvId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cancelledAt,
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
        trxNumber: json["trx_number"],
        accountId: json["account_id"],
        ledgerableType: json["ledgerable_type"],
        ledgerableId: json["ledgerable_id"],
        books: json["books"],
        type: json["type"],
        amount: json["amount"]?.toDouble(),
        vat: json["vat"],
        vatRate: json["vat_rate"],
        advanceAmount: json["advance_amount"],
        advanceVat: json["advance_vat"],
        balance: json["balance"],
        note: json["note"],
        memo: json["memo"],
        userReference: json["user_reference"],
        paymentMethod: json["payment_method"],
        budgetId: json["budget_id"],
        isRf: json["is_rf"],
        userId: json["user_id"],
        companyId: json["company_id"],
        associationId: json["association_id"],
        transactionId: json["transaction_id"],
        transactionableId: json["transactionable_id"],
        transactionableType: json["transactionable_type"],
        reason: json["reason"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        bankTransactionId: json["bank_transaction_id"],
        reconciledAt: json["reconciled_at"],
        contraEntryId: json["contra_entry_id"],
        expectedLedgerableType: json["expected_ledgerable_type"],
        expectedLedgerableId: json["expected_ledgerable_id"],
        taxReturnId: json["tax_return_id"],
        jvId: json["jv_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        cancelledAt: json["cancelled_at"],
        ledgerableName: json["ledgerable_name"],
        isReconciled: json["is_reconciled"],
        isCash: json["is_cash"],
        ledgerables: json["ledgerables"] == null
            ? []
            : List<Ledgerable>.from(
                json["ledgerables"]!.map((x) => Ledgerable.fromJson(x))),
        totalAmount: json["total_amount"],
        description: json["description"],
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trx_number": trxNumber,
        "account_id": accountId,
        "ledgerable_type": ledgerableType,
        "ledgerable_id": ledgerableId,
        "books": books,
        "type": type,
        "amount": amount,
        "vat": vat,
        "vat_rate": vatRate,
        "advance_amount": advanceAmount,
        "advance_vat": advanceVat,
        "balance": balance,
        "note": note,
        "memo": memo,
        "user_reference": userReference,
        "payment_method": paymentMethod,
        "budget_id": budgetId,
        "is_rf": isRf,
        "user_id": userId,
        "company_id": companyId,
        "association_id": associationId,
        "transaction_id": transactionId,
        "transactionable_id": transactionableId,
        "transactionable_type": transactionableType,
        "reason": reason,
        "datetime":
            "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
        "bank_transaction_id": bankTransactionId,
        "reconciled_at": reconciledAt,
        "contra_entry_id": contraEntryId,
        "expected_ledgerable_type": expectedLedgerableType,
        "expected_ledgerable_id": expectedLedgerableId,
        "tax_return_id": taxReturnId,
        "jv_id": jvId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "cancelled_at": cancelledAt,
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
  String? prefix;
  dynamic code;
  dynamic oldCode;
  dynamic provisionalCode;
  String? description;
  String? type;
  dynamic accKey;
  String? subType;
  int? balance;
  int? companyId;
  dynamic accountId;
  int? categoryId;
  dynamic invoiceTypeCode;
  dynamic bankAccountId;
  int? referenceAccountId;
  int? isDefault;
  int? isBase;
  int? isHidden;
  dynamic cfActivity;
  int? receivableOrder;
  int? isAdvancePayment;
  int? isUnitLedger;
  int? isVat;
  int? vatAccountId;
  String? books;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? title;
  String? fullName;
  String? longName;
  bool? isUnitPrimary;
  bool? isUnitShown;

  Account({
    this.id,
    this.name,
    this.prefix,
    this.code,
    this.oldCode,
    this.provisionalCode,
    this.description,
    this.type,
    this.accKey,
    this.subType,
    this.balance,
    this.companyId,
    this.accountId,
    this.categoryId,
    this.invoiceTypeCode,
    this.bankAccountId,
    this.referenceAccountId,
    this.isDefault,
    this.isBase,
    this.isHidden,
    this.cfActivity,
    this.receivableOrder,
    this.isAdvancePayment,
    this.isUnitLedger,
    this.isVat,
    this.vatAccountId,
    this.books,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.fullName,
    this.longName,
    this.isUnitPrimary,
    this.isUnitShown,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        prefix: json["prefix"],
        code: json["code"],
        oldCode: json["old_code"],
        provisionalCode: json["provisional_code"],
        description: json["description"],
        type: json["type"],
        accKey: json["acc_key"],
        subType: json["sub_type"],
        balance: json["balance"],
        companyId: json["company_id"],
        accountId: json["account_id"],
        categoryId: json["category_id"],
        invoiceTypeCode: json["invoice_type_code"],
        bankAccountId: json["bank_account_id"],
        referenceAccountId: json["reference_account_id"],
        isDefault: json["is_default"],
        isBase: json["is_base"],
        isHidden: json["is_hidden"],
        cfActivity: json["cf_activity"],
        receivableOrder: json["receivable_order"],
        isAdvancePayment: json["is_advance_payment"],
        isUnitLedger: json["is_unit_ledger"],
        isVat: json["is_vat"],
        vatAccountId: json["vat_account_id"],
        books: json["books"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
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
        "old_code": oldCode,
        "provisional_code": provisionalCode,
        "description": description,
        "type": type,
        "acc_key": accKey,
        "sub_type": subType,
        "balance": balance,
        "company_id": companyId,
        "account_id": accountId,
        "category_id": categoryId,
        "invoice_type_code": invoiceTypeCode,
        "bank_account_id": bankAccountId,
        "reference_account_id": referenceAccountId,
        "is_default": isDefault,
        "is_base": isBase,
        "is_hidden": isHidden,
        "cf_activity": cfActivity,
        "receivable_order": receivableOrder,
        "is_advance_payment": isAdvancePayment,
        "is_unit_ledger": isUnitLedger,
        "is_vat": isVat,
        "vat_account_id": vatAccountId,
        "books": books,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
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
