// To parse this JSON data, do
//
//     final primaryOwnerActivityModel = primaryOwnerActivityModelFromJson(jsonString);

import 'dart:convert';

PrimaryOwnerActivityModel primaryOwnerActivityModelFromJson(String str) => PrimaryOwnerActivityModel.fromJson(json.decode(str));

String primaryOwnerActivityModelToJson(PrimaryOwnerActivityModel data) => json.encode(data.toJson());

class PrimaryOwnerActivityModel {
    String? status;
    List<Record>? record;
    int? code;
    dynamic meta;
    bool? requestStatus;
    String? message;

    PrimaryOwnerActivityModel({
        this.status,
        this.record,
        this.code,
        this.meta,
        this.requestStatus,
        this.message,
    });

    factory PrimaryOwnerActivityModel.fromJson(Map<String, dynamic> json) => PrimaryOwnerActivityModel(
        status: json["status"],
        record: json["record"] == null ? [] : List<Record>.from(json["record"]!.map((x) => Record.fromJson(x))),
        code: json["code"],
        meta: json["meta"],
        requestStatus: json["request_status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "record": record == null ? [] : List<dynamic>.from(record!.map((x) => x.toJson())),
        "code": code,
        "meta": meta,
        "request_status": requestStatus,
        "message": message,
    };
}

class Record {
    int? id;
    String? currentOwner;
    String? oldOwner;
    String? actionType;
    String? type;
    DateTime? createdAt;

    Record({
        this.id,
        this.currentOwner,
        this.oldOwner,
        this.actionType,
        this.type,
        this.createdAt,
    });

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        currentOwner: json["current_owner"],
        oldOwner: json["old_owner"],
        actionType: json["action_type"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "current_owner": currentOwner,
        "old_owner": oldOwner,
        "action_type": actionType,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
    };
}
