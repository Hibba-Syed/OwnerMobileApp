// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  String? status;
  List<NotificationRecord>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  NotificationsModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        status: json["status"],
        record: json["record"] == null
            ? []
            : List<NotificationRecord>.from(json["record"]!.map((x) => NotificationRecord.fromJson(x))),
        code: json["code"],
        meta: json["meta"],
        requestStatus: json["request_status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": record == null
            ? []
            : List<dynamic>.from(record!.map((x) => x.toJson())),
        "code": code,
        "meta": meta,
        "request_status": requestStatus,
        "message": message,
      };
}

class NotificationRecord {
  int? id;
  int? userId;
  String? subject;
  String? message;
  String? activity;
  int? objectId;
  String? objectType;
  String? group;
  String? subGroup;
  int? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationRecord({
    this.id,
    this.userId,
    this.subject,
    this.message,
    this.activity,
    this.objectId,
    this.objectType,
    this.group,
    this.subGroup,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationRecord.fromJson(Map<String, dynamic> json) => NotificationRecord(
        id: json["id"],
        userId: json["user_id"],
        subject: json["subject"],
        message: json["message"],
        activity: json["activity"],
        objectId: json["object_id"],
        objectType: json["object_type"],
        group: json["group"],
        subGroup: json["sub_group"],
        isRead: json["is_read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "subject": subject,
        "message": message,
        "activity": activity,
        "object_id": objectId,
        "object_type": objectType,
        "group": group,
        "sub_group": subGroup,
        "is_read": isRead,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
