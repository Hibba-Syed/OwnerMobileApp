import 'dart:convert';
UpdateComplianceResponseModel updateComplianceResponseModelFromJson(String str) => UpdateComplianceResponseModel.fromJson(json.decode(str));
String updateComplianceResponseModelToJson(UpdateComplianceResponseModel data) => json.encode(data.toJson());
class UpdateComplianceResponseModel {
  UpdateComplianceResponseModel({
      this.status, 
      this.record, 
      this.code, 
      this.meta, 
      this.requestStatus, 
      this.message,});

  UpdateComplianceResponseModel.fromJson(dynamic json) {
    status = json['status'];
    record = json['record'] != null ? Record.fromJson(json['record']) : null;
    code = json['code'];
    meta = json['meta'];
    requestStatus = json['request_status'];
    message = json['message'];
  }
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (record != null) {
      map['record'] = record?.toJson();
    }
    map['code'] = code;
    map['meta'] = meta;
    map['request_status'] = requestStatus;
    map['message'] = message;
    return map;
  }

}

Record recordFromJson(String str) => Record.fromJson(json.decode(str));
String recordToJson(Record data) => json.encode(data.toJson());
class Record {
  Record({
      this.id, 
      this.datetime, 
      this.expiry, 
      this.description, 
      this.attachment, 
      this.notApplicable, 
      this.compliancelabelId, 
      this.complianceableId, 
      this.complianceableType, 
      this.assigneeId, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.attachmentUrl, 
      this.isExpired,});

  Record.fromJson(dynamic json) {
    id = json['id'];
    datetime = json['datetime'];
    expiry = json['expiry'];
    description = json['description'];
    attachment = json['attachment'];
    notApplicable = json['not_applicable'];
    compliancelabelId = json['compliancelabel_id'];
    complianceableId = json['complianceable_id'];
    complianceableType = json['complianceable_type'];
    assigneeId = json['assignee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    attachmentUrl = json['attachment_url'];
    isExpired = json['is_expired'];
  }
  int? id;
  String? datetime;
  String? expiry;
  String? description;
  String? attachment;
  String? notApplicable;
  int? compliancelabelId;
  int? complianceableId;
  String? complianceableType;
  dynamic assigneeId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? attachmentUrl;
  bool? isExpired;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['datetime'] = datetime;
    map['expiry'] = expiry;
    map['description'] = description;
    map['attachment'] = attachment;
    map['not_applicable'] = notApplicable;
    map['compliancelabel_id'] = compliancelabelId;
    map['complianceable_id'] = complianceableId;
    map['complianceable_type'] = complianceableType;
    map['assignee_id'] = assigneeId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['attachment_url'] = attachmentUrl;
    map['is_expired'] = isExpired;
    return map;
  }

}