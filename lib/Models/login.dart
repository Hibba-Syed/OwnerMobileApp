// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) =>
    List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(List<LoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  LoggedInOwner? owner;
  String? tokenType;
  int? expiresIn;
  String? accessToken;

  LoginModel({
    this.owner,
    this.tokenType,
    this.expiresIn,
    this.accessToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        owner: json["owner"] == null
            ? null
            : LoggedInOwner.fromJson(json["owner"]),
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner?.toJson(),
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
      };
}

class LoggedInOwner {
  int? id;
  int? companyId;
  String? email;
  String? fullName;
  Company? company;

  LoggedInOwner({
    this.id,
    this.companyId,
    this.email,
    this.fullName,
    this.company,
  });

  factory LoggedInOwner.fromJson(Map<String, dynamic> json) => LoggedInOwner(
        id: json["id"],
        companyId: json["company_id"],
        email: json["email"],
        fullName: json["full_name"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "email": email,
        "full_name": fullName,
        "company": company?.toJson(),
      };
}

class Company {
  int? id;
  String? name;
  String? themeColor;
  String? faviconUrl;

  Company({
    this.id,
    this.name,
    this.themeColor,
    this.faviconUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        themeColor: json["theme_color"],
        faviconUrl: json["favicon_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "theme_color": themeColor,
        "favicon_url": faviconUrl,
      };
}
