import 'package:iskaanowner/Models/ledger_by_account.dart';

import '../../Utils/utils.dart';

class LedgerByAccount extends StatefulWidget {
  final int? unitId;
  const LedgerByAccount({super.key, required this.unitId});

  @override
  State<LedgerByAccount> createState() => _LedgerByAccountState();
}

class _LedgerByAccountState extends State<LedgerByAccount> {
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
      if (ledgerCubit.state.loadMoreLedgerByAccountState !=
          LoadingState.loading) {
        ledgerCubit.getMoreLedgerByAccount(context, widget.unitId);
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
        if (state.ledgerByAccountLoadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.ledgerByAccountModel?.record?.ledgers?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList(
            ontap: () => context
                .read<LedgerCubit>()
                .getLedgerByAccount(context, widget.unitId),
          );
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<LedgerCubit>()
                      .getLedgerByAccount(context, widget.unitId);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      state.ledgerByAccountModel?.record?.ledgers?.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    AccountDatum? accountDatum =
                        state.ledgerByAccountModel?.record?.ledgers?[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (accountDatum?.transactions?.isNotEmpty ??
                                false) {
                              Navigator.pushNamed(
                                  context, AppRoutes.ledgerByAccountDetail,
                                  arguments: accountDatum);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: accountDatum?.name ?? "",
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 1,
                                      fontSize: 17,
                                    ),
                                    const Gap(20),
                                    CustomText(
                                      text: formatCurrency(
                                          accountDatum?.closingBalance ?? 0),
                                      fontWeight: FontWeight.bold,
                                      color: ((accountDatum?.closingBalance ??
                                                  0) ==
                                              0)
                                          ? const Color(0xffB2B1B1)
                                          : (accountDatum?.closingBalance
                                                      ?.isNegative ??
                                                  false)
                                              ? const Color(0xffFB5454)
                                              : const Color(0xff65D024),
                                      maxLines: 1,
                                    )
                                  ],
                                )),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        if ((index + 1) ==
                            state.ledgerByAccountModel?.record?.ledgers?.length)
                          const SizedBox(
                            height: 150,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (state.loadMoreLedgerByAccountState == LoadingState.loading)
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
