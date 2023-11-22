import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';

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
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: primaryColor,
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
            BlocBuilder<InvoicesCubit, InvoicesState>(
              builder: (context, state) {
                if (state.loadingState == LoadingState.loading) {
                  return const Expanded(child: CustomLoader());
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => primaryColor.withOpacity(0.1)),
                      border: TableBorder.all(color: primaryColor),
                      columns: [
                        "Date",
                        "Due Date",
                        "Reference",
                        "Mollak Reference",
                        "Description",
                      ]
                          .map((e) => const SharedDocumentPage()
                              .sharedDocumentDataColumn(e))
                          .toList(),
                      rows: state.invoicesModel?.invoices
                              ?.map((e) => const LedgerPage().ledgerDataRow(
                                    e.toJson()..remove("id"),
                                    onTap: () {
                                      context
                                          .read<InvoiceDetailsCubit>()
                                          .getInvoiceDetails(context, e.id);
                                      Navigator.pushNamed(
                                          context, AppRoutes.invoiceDetails);
                                    },
                                  ))
                              .toList() ??
                          []),
                );
              },
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
