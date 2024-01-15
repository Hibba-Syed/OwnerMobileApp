import 'package:flutter_animate/flutter_animate.dart';
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
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const DashboardPage().appBar(
                  context,
                  text: "Unit $unitNumber - Ledger",
                  trailingIcon: IconButton(
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
                    visualDensity: VisualDensity.compact,
                    icon: Image.asset(
                      "assets/filter.png",
                      scale: 4,
                      color: const Color(0xff575757),
                    ),
                  ),
                ),
                BlocBuilder<DownloadLedgerCubit, DownloadLedgerState>(
                  builder: (context, state) {
                    return CustomButton(
                      padding: EdgeInsets.zero,
                      text: "Export Ledger",
                      function: () {
                        context.read<DownloadLedgerCubit>().downloadDocument(
                            context,
                            "$baseUrl/mobile/owner/property/accounting/ledgers/units-ledger-export?ledgerIds[]=${context.read<LedgerCubit>().state.ledgerType?.id}&unit_id[]=$unitId&type=${context.read<LedgerCubit>().state.ledgerName}");
                      },
                      height: MediaQuery.of(context).size.width * 0.12,
                      fontSize: MediaQuery.of(context).size.width * 0.02,
                      buttonColor: context
                          .read<AppThemeCubit>()
                          .state
                          .primaryColor
                          .withOpacity(0.8),
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
                          : Image.asset(
                              "assets/export.png",
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: kGrey.shade200,
                //   ),
                //   child: TabBar(
                //     indicator: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: context.read<AppThemeCubit>().state.primaryColor,
                //     ),
                //     indicatorSize: TabBarIndicatorSize.tab,
                //     labelColor: kWhite,
                //     dividerColor: kTransparent,
                //     onTap: (value) {
                //       if (value == 0) {
                //         return context
                //             .read<LedgerCubit>()
                //             .onChangeLedgerName("statement");
                //       }
                //       if (value == 1) {
                //         return context
                //             .read<LedgerCubit>()
                //             .onChangeLedgerName("date");
                //       }
                //       return context
                //           .read<LedgerCubit>()
                //           .onChangeLedgerName("account");
                //     },
                //     tabs: const [
                //       Tab(
                //         text: "Statement",
                //       ),
                //       Tab(
                //         text: "Date",
                //       ),
                //       Tab(
                //         text: "Account",
                //       ),
                //     ],
                //   ),
                // ),
                StatefulBuilder(builder: (context, changeState) {
                  return Container(
                    height: MediaQuery.of(context).size.height* 0.07,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: kWhite),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeState(() {
                                DefaultTabController.of(context).animateTo(0);
                              });
                            },
                            child: AnimatedContainer(
                              duration: 400.ms,
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor
                                    .withOpacity(
                                        DefaultTabController.of(context)
                                                    .index ==
                                                0
                                            ? 0.8
                                            : 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomText(
                                text: "Statement",
                                color:
                                    DefaultTabController.of(context).index == 0
                                        ? kWhite
                                        : context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeState(() {
                                DefaultTabController.of(context).animateTo(1);
                              });
                            },
                            child: AnimatedContainer(
                              duration: 400.ms,
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor
                                    .withOpacity(
                                        DefaultTabController.of(context)
                                                    .index ==
                                                1
                                            ? 0.8
                                            : 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomText(
                                text: "Date",
                                color:
                                    DefaultTabController.of(context).index == 1
                                        ? kWhite
                                        : context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeState(() {
                                DefaultTabController.of(context).animateTo(2);
                              });
                            },
                            child: AnimatedContainer(
                              duration: 400.ms,
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor
                                    .withOpacity(
                                        DefaultTabController.of(context)
                                                    .index ==
                                                2
                                            ? 0.8
                                            : 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomText(
                                text: "Account",
                                color:
                                    DefaultTabController.of(context).index == 2
                                        ? kWhite
                                        : context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
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
          var modifiedList = List.from(selectedUnits ?? []);
          int? index = modifiedList.indexWhere((element) => element == id);
          return DataCell(Checkbox(
            value: index != -1 ? true : false,
            onChanged: (value) {
              if (index != -1) {
                modifiedList.removeAt(index);
              } else {
                modifiedList.add(id);
              }
              context
                  .read<UnitFinancialsCubit>()
                  .onChangeSelectedUnits(modifiedList);
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
      backgroundColor: kBackgroundColor,
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
                  const CustomText(
                    text: "Filter",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  const Gap(10),
                  child,
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Reset",
                          function: resetFunction,
                          invert: true,
                          textColor: context
                              .read<AppThemeCubit>()
                              .state
                              .primaryColor
                              .withOpacity(0.8),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                          child: CustomButton(
                        text: "Apply",
                        function: applyFunction,
                        buttonColor: context
                            .read<AppThemeCubit>()
                            .state
                            .primaryColor
                            .withOpacity(0.8),
                      )),
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
              color: const Color(0xffB2B1B1),
              fontSize: MediaQuery.of(context).size.width * 0.032,
            ),
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
              initialSelection: state.ledgerType?.name,
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
              color: const Color(0xffB2B1B1),
              fontSize: MediaQuery.of(context).size.width * 0.032,
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
      child: Column(
        children: [
          Row(
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
          const Gap(10),
          const Divider(),
        ],
      ),
    );
  }

  Widget filterDropdown(List<String> list,
      {void Function(String?)? onSelected, String? initialSelection}) {
    return DropdownMenu<String>(
      initialSelection: initialSelection,
      hintText: "Select",
      expandedInsets: const EdgeInsets.all(0),
      onSelected: onSelected,
      inputDecorationTheme:
          const InputDecorationTheme(border: UnderlineInputBorder()),
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

  Widget openingAndClosingBalance(
      BuildContext context, double? openingBalance, double? closingBalance) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kWhite,
            ),
            child: Column(
              children: [
                CustomText(
                  text: "Opening Balance",
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
                const Gap(10),
                CustomText(
                  text: formatCurrency(
                    openingBalance ?? 0,
                  ),
                  color: const Color(0xff65D024),
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kWhite,
            ),
            child: Column(
              children: [
                CustomText(
                  text: "Closing Balance",
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
                const Gap(10),
                CustomText(
                  text: formatCurrency(
                    closingBalance ?? 0,
                  ),
                  color: const Color(0xffFB5454),
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
