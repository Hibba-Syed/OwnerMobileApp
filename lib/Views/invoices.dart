import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/invoices.dart';
import '../Utils/utils.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String?;
    int? unitId =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Invioces",
        appBar: AppBar(),
        widgets: [
          IconButton(
              onPressed: () => const LedgerPage().showFilter(context,
                      child: filterView(context), resetFunction: () {
                    context.read<InvoicesCubit>().reset();
                    context.read<InvoicesCubit>().getInvoices(context, unitId);
                    Navigator.pop(context);
                  }, applyFunction: () {
                    context.read<InvoicesCubit>().getInvoices(context, unitId);
                    Navigator.pop(context);
                  }),
              icon: Icon(
                Icons.filter_alt_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ))
        ],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomSearch(
              initialValue: context.read<InvoicesCubit>().state.keyword,
              onChanged: (value) =>
                  context.read<InvoicesCubit>().onChangeKeyword(value),
              onSubmitted: (value) =>
                  context.read<InvoicesCubit>().getInvoices(context, unitId),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<InvoicesCubit, InvoicesState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.invoicesModel?.invoices?.isEmpty ?? true) {
                    return const CreditNotesPage().emptyList();
                  }
                  return ListView.builder(
                    itemCount: state.invoicesModel?.invoices?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Invoice? invoice = state.invoicesModel?.invoices?[index];
                      return InkWell(
                        onTap: () {
                          context
                              .read<InvoiceDetailsCubit>()
                              .getInvoiceDetails(context, invoice?.id);
                          Navigator.pushNamed(
                              context, AppRoutes.creditNoteDetails);
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
                                                invoice?.documents?.first));
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
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget filterView(BuildContext context) {
    return BlocBuilder<InvoicesCubit, InvoicesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Invoice Date Range"),
            const Gap(10),
            const LedgerPage().dateRangeCustomTextWidget(
              context,
              state.invoiceDateRange != null
                  ? "${const OccupantPage().dateTimeFormatter(state.invoiceDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.invoiceDateRange?.end)}"
                  : "Select date range",
              onTap: () => showDateRangePicker(
                context: context,
                firstDate: DateTime(1900, 01, 01),
                lastDate: DateTime(DateTime.now().year, 12, 31),
                currentDate: DateTime.now(),
              ).then(
                (value) => context
                    .read<InvoicesCubit>()
                    .onChangeInvoiceDateRange(value),
              ),
            ),
            const Gap(10),
            const CustomText(text: "Due Date Range"),
            const Gap(10),
            const LedgerPage().dateRangeCustomTextWidget(
              context,
              state.dueDateRange != null
                  ? "${const OccupantPage().dateTimeFormatter(state.dueDateRange?.start)} - ${const OccupantPage().dateTimeFormatter(state.dueDateRange?.end)}"
                  : "Select date range",
              onTap: () => showDateRangePicker(
                context: context,
                firstDate: DateTime(1900, 01, 01),
                lastDate: DateTime(DateTime.now().year, 12, 31),
                currentDate: DateTime.now(),
              ).then(
                (value) =>
                    context.read<InvoicesCubit>().onChangeDueDateRange(value),
              ),
            ),
          ],
        );
      },
    );
  }
}
