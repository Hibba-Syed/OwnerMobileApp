import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';

import '../Utils/utils.dart';

class InvoiceDetailsPage extends StatelessWidget {
  const InvoiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Invoice Details",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: BlocBuilder<InvoiceDetailsCubit, InvoiceDetailsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kGrey.shade100),
                    child: const Icon(
                      Icons.person_outline,
                      size: 30,
                    ),
                  ),
                  const Gap(10),
                  const CustomText(
                    text: "Community Management Company",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  const CustomText(
                      text:
                          "1004 IT Plaza Dubai Silicon Oasis, P.O. Box 12345, Dubai, United"),
                  const Gap(10),
                  const CustomText(text: "Arab Emirates"),
                  const Gap(10),
                  CustomText(
                    text: state.invoiceDetailsModel?.association?.name ?? "",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  const CustomText(
                      text: "Silicon Oasis, Dubai, United Arab Emirates"),
                  const Gap(10),
                  CustomText(
                      text:
                          state.invoiceDetailsModel?.association?.email ?? ""),
                  const Gap(10),
                  CustomText(
                    text:
                        "TRN: ${state.invoiceDetailsModel?.association?.trnNumber ?? ""}",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  RowText(
                    text:
                        "Unit: ${state.invoiceDetailsModel?.invoiceable?.name ?? ""}",
                    text2: state.invoiceDetailsModel?.title ?? "",
                  ),
                  const Gap(10),
                  RowText(
                    text:
                        "Owner Name: ${state.invoiceDetailsModel?.invoiceable?.owner?.owner?.fullName ?? ""}",
                    text2:
                        "Invoice No: ${state.invoiceDetailsModel?.reference ?? ""}",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Owner Email: imhammadahmad94@gmail.com",
                    text2:
                        "Invoice Date: ${const OccupantPage().dateTimeFormatter(state.invoiceDetailsModel?.datetime)}",
                  ),
                  const Gap(10),
                  RowText(
                    text:
                        "Owner TRN: ${state.invoiceDetailsModel?.invoiceable?.owner?.owner?.trnNumber}",
                    text2:
                        "Due Date: ${const OccupantPage().dateTimeFormatter(state.invoiceDetailsModel?.dueDate)}",
                  ),
                  const Gap(10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => primaryColor.withOpacity(0.1)),
                        border: TableBorder.all(color: primaryColor),
                        columns: [
                          "Account",
                          "Description",
                          "VAT",
                          "Amount",
                        ]
                            .map((e) => const SharedDocumentPage()
                                .sharedDocumentDataColumn(e))
                            .toList(),
                        rows: (state.invoiceDetailsModel?.transactions
                                    ?.map((e) => {
                                          "Account": e.account?.name,
                                          "Description": e.description,
                                          "VAT": e.vat,
                                          "Amount": e.amount,
                                        })
                                    .toList() ??
                                [])
                            // [
                            //   {
                            //     "Account": "Card",
                            //     "Description": "",
                            //     "VAT": "AED 0.50",
                            //     "Amount": "AED 10.00"
                            //   },
                            //   {
                            //     "Account": "",
                            //     "Description": "Sub Total	",
                            //     "VAT": "AED 0.50",
                            //     "Amount": "AED 10.00"
                            //   },
                            //   {
                            //     "Account": "TOTAL",
                            //     "Description": "",
                            //     "VAT": "",
                            //     "Amount": "AED 10.50"
                            //   },
                            // ]
                            .map((e) => const LedgerPage().ledgerDataRow(e))
                            .toList()),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
