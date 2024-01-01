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
          return const CreditNotesPage().emptyList();
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  context.read<LedgerCubit>().getLedgerByStatement(context, widget.unitId);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.ledgerByStatementModel?.record?.data?.ledgers
                          ?.length ??
                      0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Ledger? ledger = state
                        .ledgerByStatementModel?.record?.data?.ledgers?[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            const LedgerPage().decidePage(
                                context, ledger?.id, ledger?.document);
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
                                          .ledgerIcon(ledger?.document),
                                    ),
                                    const Gap(10),
                                    CustomText(
                                      text: " ${ledger?.type ?? " -- "}",
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
                                            text: ledger?.document
                                                        ?.toLowerCase() ==
                                                    "credit_memo"
                                                ? "Credit Note"
                                                : ledger?.document == "" ||
                                                        ledger?.document == " "
                                                    ? "JV"
                                                    : ledger?.document ?? "JV")),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: ledger?.reference ?? " -- ",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Gap(10),
                                    CustomText(
                                      text: const OccupantPage()
                                          .dateTimeFormatter(ledger?.date),
                                      color: kGrey,
                                      fontsize: 12,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: ledger?.description ?? " -- ",
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
                                      text: formatCurrency(ledger?.debit ?? 0),
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
                                      text: formatCurrency(ledger?.credit ?? 0),
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
                                      text: formatCurrency(ledger?.balance ?? 0),
                                      fontsize: 13,
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
                          const SizedBox(
                            height: 150,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (state.loadMoreLedgerByStatementState == LoadingState.loading)
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
