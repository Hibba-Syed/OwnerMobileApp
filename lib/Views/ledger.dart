import 'package:iskaanowner/Views/ledger_by_account.dart';
import 'package:iskaanowner/Views/ledger_by_date.dart';
import 'package:iskaanowner/Views/ledger_by_statement.dart';

import '../Utils/utils.dart';

class LedgerPage extends StatelessWidget {
  const LedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String?;
    int? unitId =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as int?;
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
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  color: primaryColor,
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
                              Icons.document_scanner_outlined,
                              color: kWhite,
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "By Statement",
                  ),
                  Tab(
                    text: "By Date",
                  ),
                  Tab(
                    text: "By Account",
                  ),
                ],
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      LedgerByStatement(),
                      LedgerByDate(),
                      LedgerByAccount(),
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

  DataRow ledgerDataRow(Map data, {void Function()? onTap}) {
    return DataRow(
      cells: data.values
          .toList()
          .map((e) => ledgerDataCell(e, onTap: onTap))
          .toList(),
    );
  }

  DataCell ledgerDataCell(dynamic text, {void Function()? onTap}) {
    return DataCell(
        Center(
          child: CustomText(
            text: (text ?? " -- ").toString(),
          ),
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
                  const Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: "Filter",
                      color: primaryColor,
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
            const CustomText(
              text: "Select Ledger",
              color: primaryColor,
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
            const CustomText(
              text: "Select Date Range",
              color: primaryColor,
            ),
            const Gap(10),
            dateRangeCustomTextWidget(context,
                "${const OccupantPage().dateTimeFormatter(state.customDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.customDateRange?.end)}")
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
            const Icon(
              Icons.date_range_outlined,
              color: primaryColor,
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
      onSelected: onSelected,
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
