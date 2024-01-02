import 'package:iskaanowner/Views/ledger/ledger_by_account.dart';
import 'package:iskaanowner/Views/ledger/ledger_by_date.dart';
import 'package:iskaanowner/Views/ledger/ledger_by_statement.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Blocs/Credit Note Details/credit_note_details_cubit.dart';
import '../../Blocs/Invoice details/invoice_details_cubit.dart';
import '../../Blocs/Receipt details/receipt_details_cubit.dart';
import '../../Blocs/Unit Financials/unit_financials_cubit.dart';
import '../../Utils/utils.dart';

class LedgerPage extends StatelessWidget {
  const LedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: BaseAppBar(
          title: "$unitNumber - Ledger",
          appBar: AppBar(),
          widgets: [
            IconButton(
                onPressed: () => showFilter(
                      context,
                      child: filterView(context),
                      resetFunction: () {
                        context.read<LedgerCubit>().onChangeCustomDateRange(
                              DateTimeRange(
                                start: DateTime(DateTime.now().year, 1, 1),
                                end: DateTime(DateTime.now().year, 12, 31),
                              ),
                            );
                        context.read<LedgerCubit>().onChangeLedgerType(
                              context
                                  .read<LedgerTypesCubit>()
                                  .state
                                  .ledgerTypesModel
                                  ?.record
                                  ?.ledgers
                                  ?.first,
                            );
                        context
                            .read<LedgerCubit>()
                            .getLedgerByStatement(context, unitId);
                        context
                            .read<LedgerCubit>()
                            .getLedgerByDate(context, unitId);
                        context
                            .read<LedgerCubit>()
                            .getLedgerByAccount(context, unitId);
                        Navigator.pop(context);
                      },
                      applyFunction: () {
                        context
                            .read<LedgerCubit>()
                            .getLedgerByStatement(context, unitId);
                        context
                            .read<LedgerCubit>()
                            .getLedgerByDate(context, unitId);
                        context
                            .read<LedgerCubit>()
                            .getLedgerByAccount(context, unitId);
                        Navigator.pop(context);
                      },
                    ),
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: context.read<AppThemeCubit>().state.primaryColor,
                ))
          ],
          automaticallyImplyLeading: true,
          appBarHeight: 50,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BlocBuilder<DownloadLedgerCubit, DownloadLedgerState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      text: "Export",
                      function: () {
                        context.read<DownloadLedgerCubit>().downloadDocument(
                            context,
                            "$baseUrl/mobile/owner/property/accounting/ledgers/units-ledger-export?ledgerIds[]=${context.read<LedgerCubit>().state.ledgerType?.id}&export=excel&propertyIds[]=$unitId");
                      },
                      width: MediaQuery.of(context).size.width * 0.3,
                      icon: state.loadingState == LoadingState.loading
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: kWhite,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.description_outlined,
                              color: kWhite,
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kGrey.shade200,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.read<AppThemeCubit>().state.primaryColor,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: kWhite,
                  dividerColor: kTransparent,
                  tabs: const [
                    Tab(
                      text: "Statement",
                    ),
                    Tab(
                      text: "Date",
                    ),
                    Tab(
                      text: "Account",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      LedgerByStatement(
                        unitId: unitId,
                      ),
                      LedgerByDate(
                        unitId: unitId,
                      ),
                      LedgerByAccount(
                        unitId: unitId,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DataRow ledgerDataRow(Map data,
      {void Function()? onTap,
      bool enableCheckbox = false,
      required BuildContext context,
      int? id,
      List? selectedUnits}) {
    List<dynamic> dataList = data.values.toList();
    if (enableCheckbox) {
      dataList.insert(0, "element");
    }
    return DataRow(
        cells: List.generate(dataList.length, (index) {
      if (enableCheckbox) {
        if (index == 0) {
          var modifedList = List.from(selectedUnits ?? []);
          int? index = modifedList.indexWhere((element) => element == id);
          return DataCell(Checkbox(
            value: index != -1 ? true : false,
            onChanged: (value) {
              if (index != -1) {
                modifedList.removeAt(index);
              } else {
                modifedList.add(id);
              }
              context
                  .read<UnitFinancialsCubit>()
                  .onChangeSelectedUnits(modifedList);
            },
          ));
        }
      }
      return ledgerDataCell(dataList[index], onTap: onTap);
    }));
  }

  DataCell ledgerDataCell(dynamic text, {void Function()? onTap}) {
    return DataCell(
        CustomText(
          text: (text ?? " -- ").toString(),
        ),
        onTap: onTap);
  }

  Future<T?> showFilter<T>(
    BuildContext context, {
    required Widget child,
    Widget? loadingWidget,
    required void Function() resetFunction,
    required void Function() applyFunction,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          loadingWidget ??
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(10),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "Filter",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontsize: 20,
                    ),
                  ),
                  const Gap(10),
                  child,
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                              text: "Reset", function: resetFunction)),
                      const Gap(10),
                      Expanded(
                          child: CustomButton(
                              text: "Apply", function: applyFunction)),
                    ],
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
    );
  }

  Widget filterView(
    BuildContext context,
  ) {
    return BlocBuilder<LedgerCubit, LedgerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Select Ledger",
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(10),
            filterDropdown(
              (context
                      .read<LedgerTypesCubit>()
                      .state
                      .ledgerTypesModel
                      ?.record
                      ?.ledgers
                      ?.map((e) => e.name ?? "")
                      .toList() ??
                  []),
              value: state.ledgerType?.name,
              onSelected: (value) {
                int? index = context
                    .read<LedgerTypesCubit>()
                    .state
                    .ledgerTypesModel
                    ?.record
                    ?.ledgers
                    ?.indexWhere((element) => element.name == value);
                context.read<LedgerCubit>().onChangeLedgerType(context
                    .read<LedgerTypesCubit>()
                    .state
                    .ledgerTypesModel
                    ?.record
                    ?.ledgers?[index ?? 0]);
              },
            ),
            const Gap(10),
            CustomText(
              text: "Select Date Range",
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(10),
            dateRangeCustomTextWidget(
              context,
              "${const OccupantPage().dateTimeFormatter(state.customDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.customDateRange?.end)}",
              onTap: () => showDateRangePicker(
                context: context,
                firstDate: DateTime(1900, 01, 01),
                lastDate: DateTime(DateTime.now().year, 12, 31),
                currentDate: DateTime.now(),
              ).then(
                (value) =>
                    context.read<LedgerCubit>().onChangeCustomDateRange(value),
              ),
            )
          ],
        );
      },
    );
  }

  Widget dateRangeCustomTextWidget(BuildContext context, String text,
      {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kGrey.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: text,
              textAlign: TextAlign.left,
              color: kBlack.withOpacity(0.7),
            ),
            Icon(
              Icons.date_range_outlined,
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget filterDropdown(List<String> list,
      {void Function(String?)? onSelected, String? value}) {
    return DropdownMenu<String>(
      initialSelection: value ?? list.first,
      expandedInsets: const EdgeInsets.all(0),
      onSelected: onSelected,
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }

  void decidePage(BuildContext context, int? id, String? document) {
    String? page;
    if (document?.toLowerCase() == "receipt") {
      context.read<ReceiptDetailsCubit>().getReceiptDetails(context, id);
      page = AppRoutes.receiptDetails;
    }
    if (document?.toLowerCase().contains("credit") ?? false) {
      context.read<CreditNoteDetailsCubit>().getCreditNoteDetails(context, id);
      page = AppRoutes.creditNoteDetails;
    }
    if (document?.toLowerCase() == "invoice") {
      context.read<InvoiceDetailsCubit>().getInvoiceDetails(context, id);
      page = AppRoutes.invoiceDetails;
    }
    if (page != null) {
      Navigator.pushNamed(context, page, arguments: id);
    }
  }
}
