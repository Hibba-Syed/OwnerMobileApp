import 'dart:convert';

import 'package:iskaanowner/Models/compliances.dart';
UpdateComplianceResponseModel updateComplianceResponseModelFromJson(String str) => UpdateComplianceResponseModel.fromJson(json.decode(str));
String updateComplianceResponseModelToJson(UpdateComplianceResponseModel data) => json.encode(data.toJson());
class UpdateComplianceResponseModel {
  UpdateComplianceResponseModel({
      this.status, 
      this.compliance,
      this.code, 
      this.meta, 
      this.requestStatus, 
      this.message,});

  UpdateComplianceResponseModel.fromJson(dynamic json) {
    status = json['status'];
    compliance = json['record'] != null ? Compliance.fromJson(json['record']) : null;
    code = json['code'];
    meta = json['meta'];
    requestStatus = json['request_status'];
    message = json['message'];
  }
  String? status;
  Compliance? compliance;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (compliance != null) {
      map['record'] = compliance?.toJson();
    }
    map['code'] = code;
    map['meta'] = meta;
    map['request_status'] = requestStatus;
    map['message'] = message;
    return map;
  }

}

Compliance recordFromJson(String str) => Compliance.fromJson(json.decode(str));
String recordToJson(Compliance data) => json.encode(data.toJson());
