import 'package:iskaanowner/Views/ledger/ledger_by_account_details.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Models/ledger_by_date.dart';
import '../../Utils/utils.dart';

class LedgerByDate extends StatefulWidget {
  final int? unitId;
  const LedgerByDate({super.key, required this.unitId});

  @override
  State<LedgerByDate> createState() => _LedgerByDateState();
}

class _LedgerByDateState extends State<LedgerByDate> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      LedgerCubit ledgerCubit = context.read<LedgerCubit>();
      if (ledgerCubit.state.loadMoreLedgerByDateState != LoadingState.loading) {
        ledgerCubit.getMoreLedgerByDate(context, widget.unitId);
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
    return BlocBuilder<LedgerCubit, LedgerState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.ledgerByDateModel?.record?.data?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList();
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<LedgerCubit>()
                      .getLedgerByDate(context, widget.unitId);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.ledgerByDateModel?.record?.data?.length ?? 0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    LedgerByDateDatum? ledgerByDateDatum =
                        state.ledgerByDateModel?.record?.data?[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            const LedgerPage().decidePage(
                                context,
                                ledgerByDateDatum?.id,
                                ledgerByDateDatum?.document);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor),
                                      padding: const EdgeInsets.all(10),
                                      child: const LedgerByAccountDetailsPage()
                                          .ledgerIcon(
                                              ledgerByDateDatum?.document),
                                    ),
                                    const Gap(10),
                                    CustomText(
                                      text:
                                          " ${ledgerByDateDatum?.type ?? " -- "}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Gap(10),
                                    const Spacer(),
                                    const Gap(10),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor
                                                .withOpacity(0.2)),
                                        child: CustomText(
                                            text: ledgerByDateDatum?.document
                                                        ?.toLowerCase() ==
                                                    "credit_memo"
                                                ? "Credit Note"
                                                : ledgerByDateDatum?.document ==
                                                            "" ||
                                                        ledgerByDateDatum
                                                                ?.document ==
                                                            " "
                                                    ? "JV"
                                                    : ledgerByDateDatum
                                                            ?.document ??
                                                        "JV")),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: ledgerByDateDatum?.account ??
                                            " -- ",
                                        fontsize: 18,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    const Gap(10),
                                    CustomText(
                                      text: const OccupantPage()
                                          .dateTimeFormatter(
                                              ledgerByDateDatum?.date),
                                      color: kGrey,
                                      fontsize: 12,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: ledgerByDateDatum?.transactionNo ??
                                      " -- ",
                                  fontsize: 13,
                                ),
                                CustomText(
                                  text: ledgerByDateDatum?.reference ?? " -- ",
                                  fontWeight: FontWeight.w500,
                                  fontsize: 17,
                                ),
                                CustomText(
                                  text:
                                      ledgerByDateDatum?.description ?? " -- ",
                                  fontsize: 15,
                                ),
                                const Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "Debit : ",
                                      fontsize: 13,
                                    ),
                                    CustomText(
                                      text: formatCurrency(
                                          ledgerByDateDatum?.debit ?? 0),
                                      fontsize: 13,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "Credit : ",
                                      fontsize: 13,
                                    ),
                                    CustomText(
                                      text: formatCurrency(
                                          ledgerByDateDatum?.credit ?? 0),
                                      fontsize: 13,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: kGrey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "Balance : ",
                                      fontsize: 13,
                                    ),
                                    CustomText(
                                      text: formatCurrency(
                                          ledgerByDateDatum?.balance ?? 0),
                                      fontsize: 13,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if ((index + 1) ==
                            state.ledgerByDateModel?.record?.data?.length)
                          const SizedBox(
                            height: 150,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (state.loadMoreLedgerByDateState == LoadingState.loading)
              const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}
