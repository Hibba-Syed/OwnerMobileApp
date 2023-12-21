import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class ReceiptDetailsPage extends StatelessWidget {
  const ReceiptDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Receipt Details",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: BlocBuilder<ReceiptDetailsCubit, ReceiptDetailsState>(
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
                    text: state.receiptDetailsModel?.association?.name ?? "",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  const CustomText(
                      text: "Silicon Oasis, Dubai, United Arab Emirates"),
                  const Gap(10),
                  CustomText(
                      text:
                          state.receiptDetailsModel?.association?.email ?? ""),
                  const Gap(10),
                  CustomText(
                    text:
                        "TRN: ${state.receiptDetailsModel?.association?.trnNumber ?? ""}",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  RowText(
                    text: "Unit:",
                    text2: state.receiptDetailsModel?.unitwise?[0].name ?? "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Receipt No.",
                    text2: state.receiptDetailsModel?.reference ?? "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Payment Method:",
                    text2: state.receiptDetailsModel?.paymentMethod ?? "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Payment Date:",
                    text2: const OccupantPage().dateTimeFormatter(
                        state.receiptDetailsModel?.paymentDate),
                  ),
                  const Gap(10),
                  RowText(
                    text: "Receipt Date:",
                    text2: const OccupantPage()
                        .dateTimeFormatter(state.receiptDetailsModel?.datetime),
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
                          "Amount",
                        ]
                            .map((e) => const SharedDocumentPage()
                                .sharedDocumentDataColumn(e))
                            .toList(),
                        rows: (state.receiptDetailsModel?.transactions
                                    ?.map((e) => {
                                          "Account": e.account?.name,
                                          "Description": e.description,
                                          "Amount": e.totalAmount,
                                        })
                                    .toList() ??
                                [])
                            // [
                            //   {
                            //     "Account": "Access Card VAT",
                            //     "Description": "",
                            //     "Amount": "AED 10.48"
                            //   },
                            //   {
                            //     "Account": "Access Card",
                            //     "Description": "",
                            //     "Amount": "AED 9.52"
                            //   },
                            //   {
                            //     "Account": "Income Account",
                            //     "Description": "",
                            //     "Amount": "AED 9.52"
                            //   },
                            //   {
                            //     "Account": "",
                            //     "Description": "TOTAL",
                            //     "Amount": "AED 50.50"
                            //   },
                            // ]
                            .map((e) => const LedgerPage()
                                .ledgerDataRow(e, context: context))
                            .toList()),
                  ),
                  const Gap(10),
                  RowText(
                    text: "PAID BY:",
                    text2: state.receiptDetailsModel?.unitwise?[0].owner
                            ?.fullName ??
                        "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "PHONE:",
                    text2:
                        state.receiptDetailsModel?.unitwise?[0].owner?.mobile ??
                            "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "EMAIL:",
                    text2:
                        state.receiptDetailsModel?.unitwise?[0].owner?.email ??
                            "",
                  ),
                  const Gap(10),
                  const RowText(
                    text: "BANK ACCOUNT:",
                    text2: "Current",
                  ),
                  const Gap(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
