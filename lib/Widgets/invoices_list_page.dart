import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Blocs/Invoice details/invoice_details_cubit.dart';
import '../Models/invoices.dart';
import '../Utils/utils.dart';

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
          return const CreditNotesPage().emptyList();
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  context.read<InvoicesCubit>().getInvoices(context, widget.unitId);
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
                                context, AppRoutes.invoiceDetails,arguments: invoice?.id);
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
                                    Icons.receipt_long_outlined,
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
                                            text: invoice?.reference ?? " -- ",
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const Gap(10),
                                          CustomText(
                                            text: const OccupantPage()
                                                .dateTimeFormatter(invoice?.date),
                                            color: kGrey,
                                            fontsize: 12,
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: invoice?.description == ""
                                            ? " -- "
                                            : invoice?.description ?? " -- ",
                                        fontsize: 14,
                                      ),
                                      Row(
                                        children: [
                                          const CustomText(
                                            text: "Mollak reference . ",
                                            fontsize: 13,
                                          ),
                                          CustomText(
                                            text: invoice?.mollakReference ??
                                                " -- ",
                                            fontsize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const CustomText(
                                                text: "Due at . ",
                                                fontsize: 12,
                                              ),
                                              CustomText(
                                                text: const OccupantPage()
                                                    .dateTimeFormatter(
                                                        invoice?.dueDate),
                                                fontsize: 12,
                                                fontWeight: FontWeight.bold,
                                              )
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (invoice?.documents?.isEmpty ??
                                                  true) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "No documents found to download");
                                                return;
                                              }
                                              launchUrl(Uri.parse(
                                                  invoice?.documents ?? ""));
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
                        if ((index + 1) == state.invoicesModel?.invoices?.length)
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
        );
      },
    );
  }
}
