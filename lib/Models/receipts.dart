// To parse this JSON data, do
//
//     final receiptsModel = receiptsModelFromJson(jsonString);

import 'dart:convert';

ReceiptsModel receiptsModelFromJson(String str) => ReceiptsModel.fromJson(json.decode(str));

String receiptsModelToJson(ReceiptsModel data) => json.encode(data.toJson());

class ReceiptsModel {
    int? totalReceipts;
    List<Receipt>? receipts;
    int? currentPage;
    int? perPage;
    int? totalPages;

    ReceiptsModel({
        this.totalReceipts,
        this.receipts,
        this.currentPage,
        this.perPage,
        this.totalPages,
    });

    factory ReceiptsModel.fromJson(Map<String, dynamic> json) => ReceiptsModel(
        totalReceipts: json["totalReceipts"],
        receipts: json["receipts"] == null ? [] : List<Receipt>.from(json["receipts"]!.map((x) => Receipt.fromJson(x))),
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "totalReceipts": totalReceipts,
        "receipts": receipts == null ? [] : List<dynamic>.from(receipts!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
    };
}

class Receipt {
    DateTime? datetime;
    String? reference;
    String? paidBy;
    String? payeeType;
    int? amount;

    Receipt({
        this.datetime,
        this.reference,
        this.paidBy,
        this.payeeType,
        this.amount,
    });

    factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        reference: json["reference"],
        paidBy: json["paid_by"],
        payeeType: json["payee_type"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "datetime": "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
        "reference": reference,
        "paid_by": paidBy,
        "payee_type": payeeType,
        "amount": amount,
    };
}
