import 'package:iskaanowner/Blocs/Unit%20Financials/unit_financials_cubit.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Models/unit_financials.dart';
import '../../Utils/utils.dart';

class UnitFinancialPage extends StatefulWidget {
  const UnitFinancialPage({super.key});

  @override
  State<UnitFinancialPage> createState() => _UnitFinancialPageState();
}

class _UnitFinancialPageState extends State<UnitFinancialPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      UnitFinancialsCubit unitFinancialsCubit =
          context.read<UnitFinancialsCubit>();
      if (unitFinancialsCubit.state.loadMoreState != LoadingState.loading) {
        unitFinancialsCubit.getMoreUnitFinancials(context);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                text: "Financial summary",
              ),
            ),
            Expanded(
              child: BlocBuilder<UnitFinancialsCubit, UnitFinancialsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.unitFinancialsModel?.unitSummaries?.isEmpty ??
                      true) {
                    return const CreditNotesPage().emptyList(
                      ontap: () => context
                          .read<UnitFinancialsCubit>()
                          .getUnitFinancials(context),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: BlocBuilder<DownloadLedgerCubit,
                              DownloadLedgerState>(
                            builder: (context, downloadLedgerState) {
                              return CustomButton(
                                text: "Export",
                                function: () {
                                  if (state.selectedUnits.isNotEmpty) {
                                    String filter = "";
                                    for (var element in context
                                        .read<UnitFinancialsCubit>()
                                        .state
                                        .selectedUnits) {
                                      filter = "$filter&unit_id[]=$element";
                                    }
                                    context
                                        .read<DownloadLedgerCubit>()
                                        .downloadDocument(context,
                                            "$baseUrl/mobile/owner/property/accounting/ledgers/units-ledger-export?ledgerIds[]=${context.read<LedgerCubit>().state.ledgerType?.id}&export=excel$filter");
                                    return;
                                  }
                                  Fluttertoast.showToast(
                                      msg: "Select units to export");
                                },
                                height:
                                    MediaQuery.of(context).size.width * 0.12,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                buttonColor: state.selectedUnits.isEmpty
                                    ? kGrey
                                    : context
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                      ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<UnitFinancialsCubit>()
                                  .getUnitFinancials(context);
                            },
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: state
                                  .unitFinancialsModel?.unitSummaries?.length,
                              itemBuilder: (BuildContext context, int index) {
                                UnitSummary? unitFinancialsRecord = state
                                    .unitFinancialsModel?.unitSummaries?[index];
                                var modifiedList =
                                    List.from(state.selectedUnits);
                                int? checkboxIndex = modifiedList.indexWhere(
                                    (element) =>
                                        element ==
                                        unitFinancialsRecord?.unitId);
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: kGrey.shade200,
                                              blurRadius: 2,
                                              spreadRadius: 2)
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF2F2F2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/community.png",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.14,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  color: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor,
                                                ),
                                                const Gap(5),
                                                CustomText(
                                                  text: "Community",
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.center,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.038,
                                                  color: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor
                                                      .withOpacity(0.8),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Gap(10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomText(
                                                        text: unitFinancialsRecord
                                                                ?.communityName ??
                                                            "",
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    Checkbox(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      value: checkboxIndex != -1
                                                          ? true
                                                          : false,
                                                      onChanged: (value) {
                                                        if (checkboxIndex !=
                                                            -1) {
                                                          modifiedList.removeAt(
                                                              checkboxIndex);
                                                        } else {
                                                          modifiedList.add(
                                                              unitFinancialsRecord
                                                                  ?.unitId);
                                                        }
                                                        context
                                                            .read<
                                                                UnitFinancialsCubit>()
                                                            .onChangeSelectedUnits(
                                                                modifiedList);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                const Gap(5),
                                                CustomText(
                                                  text:
                                                      "Unit # : ${unitFinancialsRecord?.unitNumber ?? " -- "}",
                                                  fontSize: 13,
                                                ),
                                                const Gap(5),
                                                const Divider(
                                                  color: kGrey,
                                                ),
                                                const Gap(5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      text: "Balance",
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                    ),
                                                    CustomText(
                                                      text: formatCurrency(
                                                          unitFinancialsRecord
                                                                  ?.balance ??
                                                              0),
                                                      color: (unitFinancialsRecord
                                                                      ?.balance ??
                                                                  0) ==
                                                              0
                                                          ? null
                                                          : (unitFinancialsRecord
                                                                      ?.balance
                                                                      ?.isNegative ??
                                                                  false)
                                                              ? const Color(
                                                                  0xffFB5454)
                                                              : const Color(
                                                                  0xff65D024),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if ((index + 1) ==
                                        state.unitFinancialsModel?.unitSummaries
                                            ?.length)
                                      const SizedBox(
                                        height: 150,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        if (state.loadMoreState == LoadingState.loading)
                          const SizedBox(
                            height: 150,
                            child: Center(child: CircularProgressIndicator()),
                          )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
