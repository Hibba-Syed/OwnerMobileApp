import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
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
                  CustomText(
                    text: state.invoiceDetailsModel?.title ?? "",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  RowText(
                    text: "Unit:",
                    text2: state.invoiceDetailsModel?.invoiceable?.name ?? "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Invoice No: ",
                    text2: state.invoiceDetailsModel?.reference ?? "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Owner Name:",
                    text2: state.invoiceDetailsModel?.invoiceable?.owner?.owner
                            ?.fullName ??
                        "",
                  ),
                  const Gap(10),
                  RowText(
                      text: "Owner Email:",
                      text2: context
                              .read<ProfileCubit>()
                              .state
                              .profileModel
                              ?.record
                              ?.email ??
                          " -- "),
                  const Gap(10),
                  RowText(
                    text: "Invoice Date: ",
                    text2: const OccupantPage()
                        .dateTimeFormatter(state.invoiceDetailsModel?.datetime),
                  ),
                  const Gap(10),
                  RowText(
                    text: "Owner TRN:",
                    text2: state.invoiceDetailsModel?.invoiceable?.owner?.owner
                            ?.trnNumber ??
                        " -- ",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Due Date:",
                    text2: const OccupantPage()
                        .dateTimeFormatter(state.invoiceDetailsModel?.dueDate),
                  ),
                  const Gap(10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor
                                .withOpacity(0.1)),
                        border: TableBorder.all(
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor),
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
                            .map((e) => const LedgerPage()
                                .ledgerDataRow(e, context: context))
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
