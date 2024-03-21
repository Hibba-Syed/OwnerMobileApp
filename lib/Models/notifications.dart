// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  String? totalNotifications;
  List<NotificationRecord>? notifications;
  String? currentPage;
  String? perPage;
  String? totalPages;

  NotificationsModel({
    this.totalNotifications,
    this.notifications,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        totalNotifications: json["totalNotifications"]?.toString(),
        notifications: json["notifications"] == null
            ? []
            : List<NotificationRecord>.from(json["notifications"]!
                .map((x) => NotificationRecord.fromJson(x))),
        currentPage: json["current_page"]?.toString(),
        perPage: json["per_page"]?.toString(),
        totalPages: json["total_pages"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "totalNotifications": totalNotifications,
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
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

  factory NotificationRecord.fromJson(Map<String, dynamic> json) =>
      NotificationRecord(
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
