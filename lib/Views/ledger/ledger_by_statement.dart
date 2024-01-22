import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Models/ledger_by_statement.dart';
import '../../Utils/utils.dart';
import 'ledger_by_account_details.dart';

class LedgerByStatement extends StatefulWidget {
  final int? unitId;
  const LedgerByStatement({super.key, required this.unitId});

  @override
  State<LedgerByStatement> createState() => _LedgerByStatementState();
}

class _LedgerByStatementState extends State<LedgerByStatement> {
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
      if (ledgerCubit.state.loadMoreLedgerByStatementState !=
          LoadingState.loading) {
        ledgerCubit.getMoreLedgerByStatement(context, widget.unitId);
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
        if (state.ledgerByStatementModel?.record?.data?.ledgers?.isEmpty ??
            true) {
          return const CreditNotesPage().emptyList(
            ontap: () => context
                .read<LedgerCubit>()
                .getLedgerByStatement(context, widget.unitId),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<LedgerCubit>()
                .getLedgerByStatement(context, widget.unitId);
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount:
                state.ledgerByStatementModel?.record?.data?.ledgers?.length ??
                    0,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Ledger? ledger =
                  state.ledgerByStatementModel?.record?.data?.ledgers?[index];
              return Column(
                children: [
                  if (index == 0)
                    const LedgerPage().openingAndClosingBalance(
                        context,
                        state.ledgerByStatementModel?.record?.meta
                            ?.openingBalance,
                        state.ledgerByStatementModel?.record?.meta
                            ?.closingBalance),
                  if (index == 0) const Gap(5),
                  InkWell(
                    onTap: () {
                      const LedgerPage()
                          .decidePage(context, ledger?.id, ledger?.document);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: CustomText(
                                  text: ledger?.reference ?? "",
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
                                      const OccupantPage()
                                          .dateTimeFormatter(ledger?.date),
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "● ${ledger?.type}",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          color: Color(
                                              ledger?.type?.toLowerCase() ==
                                                      "charge"
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
                                          .ledgerImageIcon(ledger?.document),
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
                                      text: ledger?.document?.toLowerCase() ==
                                              "credit_memo"
                                          ? "Credit Note"
                                          : ledger?.document == "" ||
                                                  ledger?.document == " "
                                              ? "JV"
                                              : ledger?.document ?? "JV",
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CustomText(
                                          text: "Debit",
                                          fontSize: 13,
                                        ),
                                        const Gap(10),
                                        Flexible(
                                          child: CustomText(
                                            text: formatCurrency(
                                                ledger?.debit ?? 0),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.032,
                                            color: const Color(0xffB2B1B1),
                                            maxLines: 1,
                                          ),
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
                                        const Gap(10),
                                        Flexible(
                                          child: CustomText(
                                            text: formatCurrency(
                                                ledger?.credit ?? 0),
                                            color: const Color(0xffB2B1B1),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.032,
                                            maxLines: 1,
                                          ),
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
                                        const Gap(10),
                                        Flexible(
                                          child: CustomText(
                                            text: formatCurrency(
                                                ledger?.balance ?? 0),
                                            fontWeight: FontWeight.bold,
                                            maxLines: 1,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
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
                      state.ledgerByStatementModel?.record?.data?.ledgers
                          ?.length)
                    SizedBox(
                      height: 150,
                      child: state.loadMoreLedgerByStatementState ==
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
