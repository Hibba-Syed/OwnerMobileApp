import 'package:iskaanowner/Views/ledger/ledger_by_account_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/receipts.dart';
import '../Utils/utils.dart';

class ReceiptsListPage extends StatefulWidget {
  final int? unitId;
  const ReceiptsListPage({super.key, this.unitId});

  @override
  State<ReceiptsListPage> createState() => _ReceiptsListPageState();
}

class _ReceiptsListPageState extends State<ReceiptsListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ReceiptsCubit receiptsCubit = context.read<ReceiptsCubit>();
      if (receiptsCubit.state.loadMoreState != LoadingState.loading) {
        receiptsCubit.getMoreReceipts(context, widget.unitId);
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
    return BlocBuilder<ReceiptsCubit, ReceiptsState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.receiptsModel?.receipts?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList(
            ontap: () => context
                .read<ReceiptsCubit>()
                .getReceipts(context, widget.unitId),
          );
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ReceiptsCubit>()
                      .getReceipts(context, widget.unitId);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.receiptsModel?.receipts?.length ?? 0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Receipt? receipt = state.receiptsModel?.receipts?[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            const LedgerPage()
                                .decidePage(context, receipt?.id, "receipt");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF2F2F2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        const LedgerByAccountDetailsPage()
                                            .ledgerImageIcon("receipt"),
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        text: "Receipt",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: CustomText(
                                              text: receipt?.reference ?? "",
                                              fontSize: 13,
                                            ),
                                          ),
                                          const RequestsPage().iconAndText(
                                            context,
                                            "assets/calender.png",
                                            const OccupantPage()
                                                .dateTimeFormatter(
                                                    receipt?.datetime),
                                          )
                                        ],
                                      ),
                                      // const Gap(5),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     const CustomText(
                                      //       text: "Mollak reference",
                                      //       fontSize: 13,
                                      //     ),
                                      //     CustomText(
                                      //       text:
                                      //           invoice?.mollakReference ?? "",
                                      //       fontSize: MediaQuery.of(context)
                                      //               .size
                                      //               .width *
                                      //           0.032,
                                      //       color: const Color(0xffB2B1B1),
                                      //     ),
                                      //   ],
                                      // ),
                                      const Gap(5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: CustomText(
                                              text: receipt?.paidBy ?? "",
                                              fontSize: 13,
                                            ),
                                          ),
                                          CustomText(
                                            text: receipt?.payeeType ?? "",
                                            fontSize: 13,
                                          ),
                                        ],
                                      ),
                                      const Gap(5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: CustomText(
                                              text: "Amount",
                                              fontSize: 13,
                                            ),
                                          ),
                                          Flexible(
                                            child: CustomText(
                                              text: formatCurrency(
                                                  receipt?.amount),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
                                              fontWeight: FontWeight.bold,
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
                                      CustomButton(
                                        text: "Download",
                                        function: () {
                                          if (receipt?.document != null) {
                                            launchUrl(Uri.parse(
                                                receipt?.document ?? ""));
                                          }
                                        },
                                        padding: EdgeInsets.zero,
                                        buttonColor: const Color(0xff65D024)
                                            .withOpacity(0.1),
                                        textColor: const Color(0xff65D024),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        icon: Image.asset(
                                          "assets/download_summary.png",
                                          color: const Color(0xff65D024),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if ((index + 1) ==
                            state.receiptsModel?.receipts?.length)
                          SizedBox(
                            height: 150,
                            child: state.loadMoreState == LoadingState.loading
                                ? const CustomLoader()
                                : null,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
