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
          return const CreditNotesPage().emptyList();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.receiptsModel?.receipts?.length ?? 0,
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
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.receipt_outlined,
                                  color: kWhite,
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
                                        CustomText(
                                          text: receipt?.reference ?? " -- ",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const Gap(10),
                                        CustomText(
                                          text: const OccupantPage()
                                              .dateTimeFormatter(
                                                  receipt?.datetime),
                                          color: kGrey,
                                          fontsize: 12,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: receipt?.paidBy ?? " -- ",
                                          fontsize: 14,
                                        ),
                                        CustomText(
                                          text:
                                              " (${receipt?.payeeType ?? " -- "})",
                                          fontsize: 12,
                                          color: kGrey,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: formatCurrency(
                                              receipt?.amount ?? 0),
                                          fontsize: 13,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (receipt?.document?.isEmpty ??
                                                true) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "No documents found to download");
                                              return;
                                            }
                                            launchUrl(Uri.parse(
                                                receipt?.document ?? ""));
                                          },
                                          child: Icon(
                                            Icons.download_outlined,
                                            color: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if ((index + 1) == state.receiptsModel?.receipts?.length)
                        const SizedBox(
                          height: 150,
                        ),
                    ],
                  );
                },
              ),
            ),
            if (state.loadMoreState == LoadingState.loading)
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
