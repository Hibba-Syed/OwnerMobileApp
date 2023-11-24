import 'package:iskaanowner/Blocs/Unit%20Financials/unit_financials_cubit.dart';

import '../Utils/utils.dart';

class UnitFinancialPage extends StatelessWidget {
  const UnitFinancialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Financial summary",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<UnitFinancialsCubit, UnitFinancialsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<DownloadLedgerCubit, DownloadLedgerState>(
                    builder: (context, downloadLedgerState) {
                      return CustomButton(
                        buttonColor:
                            state.selectedUnits.isEmpty ? kGrey : primaryColor,
                        width: MediaQuery.of(context).size.width * 0.4,
                        text: "Export",
                        function: () {
                          if (state.selectedUnits.isNotEmpty) {
                            String filter = "";
                            for (var element in context
                                .read<UnitFinancialsCubit>()
                                .state
                                .selectedUnits) {
                              filter = "$filter&propertyIds[]=$element";
                            }
                            context.read<DownloadLedgerCubit>().downloadDocument(
                                context,
                                "$baseUrl/mobile/owner/property/accounting/ledgers/units-ledger-export?ledgerIds[]=${context.read<LedgerCubit>().state.ledgerType?.id}&export=excel$filter");
                            return;
                          }
                          Fluttertoast.showToast(
                              msg: "Select a unit to export");
                        },
                        icon: downloadLedgerState.loadingState ==
                                LoadingState.loading
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
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => primaryColor.withOpacity(0.1)),
                      border: TableBorder.all(color: primaryColor),
                      columns: [
                        "",
                        "Community",
                        "Unit Number",
                        "Balance",
                      ]
                          .map((e) => const SharedDocumentPage()
                              .sharedDocumentDataColumn(e))
                          .toList(),
                      rows: state.unitFinancialsModel?.record
                              ?.map((e) => const LedgerPage().ledgerDataRow(
                                  e.toJson()..remove("unit_id"),
                                  enableCheckbox: true,
                                  context: context,
                                  id: e.unitId,
                                  selectedUnits: state.selectedUnits))
                              .toList() ??
                          []),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  TableRow unitFinancialTableRow(
      String community, String unitNumber, String balance,
      {FontWeight? fontWeight, Color? color}) {
    return TableRow(
      children: [
        Container(
          color: color,
          child: TableCell(
            child: CustomText(
              text: community,
              fontWeight: fontWeight,
            ),
          ),
        ),
        Container(
          color: color,
          child: TableCell(
            child: CustomText(
              text: unitNumber,
              fontWeight: fontWeight,
            ),
          ),
        ),
        Container(
          color: color,
          child: TableCell(
            child: CustomText(
              text: balance,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
