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
          return const CreditNotesPage().emptyList(
            ontap: () => context
                .read<LedgerCubit>()
                .getLedgerByDate(context, widget.unitId),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<LedgerCubit>().getLedgerByDate(context, widget.unitId);
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
                  if (index == 0)
                    const LedgerPage().openingAndClosingBalance(
                        context,
                        state.ledgerByDateModel?.record?.meta?.openingBalance,
                        state.ledgerByDateModel?.record?.meta?.closingBalance),
                  if (index == 0) const Gap(5),
                  InkWell(
                    onTap: () {
                      const LedgerPage().decidePage(context,
                          ledgerByDateDatum?.id, ledgerByDateDatum?.document);
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
                          CustomText(
                            text: ledgerByDateDatum?.account ?? "",
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                          const Divider(),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: CustomText(
                                  text: ledgerByDateDatum?.reference ?? "",
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  color: const Color(0xffB2B1B1),
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const RequestsPage().iconAndText(
                                      context,
                                      "assets/calender.png",
                                      const OccupantPage().dateTimeFormatter(
                                          ledgerByDateDatum?.date),
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "● ${ledgerByDateDatum?.type}",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Color(ledgerByDateDatum?.type
                                                      ?.toLowerCase() ==
                                                  "payment"
                                              ? 0xffFB5454
                                              : 0xff65D024),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: MediaQuery.of(context).size.width * 0.3,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      const LedgerByAccountDetailsPage()
                                          .ledgerImageIcon(
                                              ledgerByDateDatum?.document),
                                      width: MediaQuery.of(context).size.width *
                                          0.14,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor,
                                    ),
                                    const Gap(5),
                                    CustomText(
                                      text: ledgerByDateDatum?.document
                                                  ?.toLowerCase() ==
                                              "credit_memo"
                                          ? "Credit Note"
                                          : ledgerByDateDatum?.document == "" ||
                                                  ledgerByDateDatum?.document ==
                                                      " "
                                              ? "JV"
                                              : ledgerByDateDatum?.document ??
                                                  "JV",
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: ledgerByDateDatum?.transactionNo ??
                                          "",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.032,
                                      color: const Color(0xffB2B1B1),
                                    ),
                                    const Gap(5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CustomText(
                                          text: "Debit",
                                          fontSize: 13,
                                        ),
                                        CustomText(
                                          text: formatCurrency(
                                              ledgerByDateDatum?.debit ?? 0),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.032,
                                          color: const Color(0xffB2B1B1),
                                        ),
                                      ],
                                    ),
                                    const Gap(5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CustomText(
                                          text: "Credit",
                                          fontSize: 13,
                                        ),
                                        CustomText(
                                          text: formatCurrency(
                                              ledgerByDateDatum?.credit ?? 0),
                                          color: const Color(0xffB2B1B1),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.032,
                                        ),
                                      ],
                                    ),
                                    const Gap(5),
                                    const Divider(
                                      color: kGrey,
                                    ),
                                    const Gap(5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: "Balance",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                        ),
                                        CustomText(
                                          text: formatCurrency(
                                              ledgerByDateDatum?.balance ?? 0),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if ((index + 1) ==
                      state.ledgerByDateModel?.record?.data?.length)
                    SizedBox(
                      height: 150,
                      child: state.loadMoreLedgerByDateState ==
                              LoadingState.loading
                          ? const Center(child: CircularProgressIndicator())
                          : null,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
