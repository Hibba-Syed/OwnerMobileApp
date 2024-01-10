import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iskaanowner/Models/ledgers_type.dart';

import '../Utils/utils.dart';

class UnitsService {
  static Future<Object?> getUnits(BuildContext context, int? id, int page,
      {int limit = 10}) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/community-units/$id?page=$page&limit=$limit",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getDropdownUnits(
    BuildContext context,
    int? id,
  ) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/services/units?association_id=$id",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitOwners(BuildContext context, int? id) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/owner/$id",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitOccupant(BuildContext context, int? id) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/occupant/$id ",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitRequests(
    BuildContext context,
    int? id,
    String? keyword,
    String? requestType,
    String? status,
    int page,
  ) async {
    return await ExceptionService.applyTryCatch(() async {
      String filter = "?keyword=$keyword";
      if (requestType != null && requestType.toLowerCase() != "select") {
        filter = "$filter&application_type=$requestType";
      }
      if (status != null && status.toLowerCase() != "select") {
        filter = "$filter&status=$status";
      }
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/applications/$id$filter&page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitCompliances(
      BuildContext context, int? id, String? keyword, int page) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/compliance?complianceable_type=unit&complianceable_id=$id&search=$keyword&page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitComplianceDetails(
    BuildContext context,
    int? id,
    int? unitId,
  ) async {
    return await ExceptionService.applyTryCatch(() async {
      // if (kDebugMode) {
      //   id = 32;
      // }
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/compliance/$id?complianceable_type=unit&complianceable_id=$unitId",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitInvoices(
    BuildContext context,
    int? id,
    String search,
    DateTimeRange? dateTimeRange,
    DateTimeRange? dueDateTimeRange,
    int page,
  ) async {
    return await ExceptionService.applyTryCatch(() async {
      String filter = "";
      if (dateTimeRange != null) {
        filter =
            "&datetime[]=${dateTimeRange.start}&datetime[]=${dateTimeRange.end}";
      }
      if (dueDateTimeRange != null) {
        filter =
            "&due_date[]=${dueDateTimeRange.start}&due_date[]=${dueDateTimeRange.end}";
      }
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/invoices?unit_id=$id&search=$search$filter&page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitInvoiceDetails(
      BuildContext context, int? id) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/invoices/$id",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitReceipts(BuildContext context, int? id,
      DateTimeRange? dateTimeRange, String? search) async {
    return await ExceptionService.applyTryCatch(() async {
      String filter = "";
      if (dateTimeRange != null) {
        filter =
            "&datetime[]=${dateTimeRange.start}&datetime[]=${dateTimeRange.end}";
      }
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/receipts?unit_id=$id&search=$search$filter",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitReceiptDetails(
      BuildContext context, int? id) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/receipts/$id",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitCreditNotes(BuildContext context, int? id,
      String? keyword, DateTimeRange? dateTimeRange, int page) async {
    return await ExceptionService.applyTryCatch(() async {
      String filter = "";
      if (dateTimeRange != null) {
        filter =
            "&datetime[]=${dateTimeRange.start}&datetime[]=${dateTimeRange.end}";
      }
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/credit-notes?creditable_type=unit&creditable_id=$id&search=$keyword$filter&page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitCreditNoteDetails(
      BuildContext context, int? id) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/credit-notes/$id",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitLedgerByStatement(
      BuildContext context,
      int? id,
      IndividualLedger? individualLedger,
      DateTimeRange? customDateRange,
      int page) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/ledgers/by-statement/$id?fromDate=${customDateRange?.start}&toDate=${customDateRange?.end}&ledgerIds[]=${individualLedger?.id}&limit=5&page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitLedgerByDate(
      BuildContext context,
      int? id,
      IndividualLedger? individualLedger,
      DateTimeRange? customDateRange,
      int page) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/ledgers/by-date/$id?fromDate=${customDateRange?.start}&toDate=${customDateRange?.end}&ledgerIds[]=${individualLedger?.id}&limit=5&page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitLedgerByAccount(
    BuildContext context,
    int? id,
    IndividualLedger? individualLedger,
    DateTimeRange? customDateRange,
    int page,
  ) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/ledgers/by-account/$id?fromDate=${customDateRange?.start}&toDate=${customDateRange?.end}&ledgerIds[]=${individualLedger?.id}&limit=15&page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitRequestsFilters(BuildContext context) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/applications/filters",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitLedgerTypes(BuildContext context) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/accounting/ledgers/types",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitRequestDetails(
      BuildContext context, int? requestId, String? applicationType) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/applications/$requestId/$applicationType/details",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getUnitFinancials(
      BuildContext context, int page) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/profile/units-financial-summary?page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 201) {
          return Success(201, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }
}
