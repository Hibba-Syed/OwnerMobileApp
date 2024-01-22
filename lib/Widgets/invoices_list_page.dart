import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Blocs/Invoice details/invoice_details_cubit.dart';
import '../Models/invoices.dart';
import '../Utils/utils.dart';
import '../Views/ledger/ledger_by_account_details.dart';

class InvoicesListPage extends StatefulWidget {
  final int? unitId;
  const InvoicesListPage({super.key, this.unitId});

  @override
  State<InvoicesListPage> createState() => _InvoicesListPageState();
}

class _InvoicesListPageState extends State<InvoicesListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      InvoicesCubit invoicesCubit = context.read<InvoicesCubit>();
      if (invoicesCubit.state.loadMoreState != LoadingState.loading) {
        invoicesCubit.getMoreInvoices(context, widget.unitId);
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
    return BlocBuilder<InvoicesCubit, InvoicesState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const CustomLoader();
        }
        if (state.invoicesModel?.invoices?.isEmpty ?? true) {
          return const CreditNotesPage().emptyList(
              ontap: () => context
                  .read<InvoicesCubit>()
                  .getInvoices(context, widget.unitId));
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<InvoicesCubit>()
                      .getInvoices(context, widget.unitId);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.invoicesModel?.invoices?.length ?? 0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Invoice? invoice = state.invoicesModel?.invoices?[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<InvoiceDetailsCubit>()
                                .getInvoiceDetails(context, invoice?.id);
                            Navigator.pushNamed(
                                context, AppRoutes.invoiceDetails,
                                arguments: invoice?.id);
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
                                            .ledgerImageIcon("invoice"),
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
                                        text: "Invoice",
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
                                              text: invoice?.reference ?? "",
                                              fontSize: 13,
                                            ),
                                          ),
                                          const RequestsPage().iconAndText(
                                            context,
                                            "assets/calender.png",
                                            const OccupantPage()
                                                .dateTimeFormatter(
                                                    invoice?.date),
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
                                          const CustomText(
                                            text: "Due at",
                                            fontSize: 13,
                                          ),
                                          const RequestsPage().iconAndText(
                                            context,
                                            "assets/calender.png",
                                            const OccupantPage()
                                                .dateTimeFormatter(
                                                    invoice?.dueDate),
                                          )
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
                                          if (invoice?.documents != null) {
                                            launchUrl(Uri.parse(
                                                invoice?.documents ?? ""));
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
                            state.invoicesModel?.invoices?.length)
                          SizedBox(
                            height: 150,
                            child: state.loadMoreState == LoadingState.loading
                                ? const Center(
                                    child: CircularProgressIndicator())
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
