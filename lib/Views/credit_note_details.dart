import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';

import '../Utils/utils.dart';

class CreditNoteDetailsPage extends StatelessWidget {
  const CreditNoteDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Credit Note Details",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: BlocBuilder<CreditNoteDetailsCubit, CreditNoteDetailsState>(
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
                    text: state.creditNoteDetailsModel?.association?.name ?? "",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  const CustomText(
                      text: "Silicon Oasis, Dubai, United Arab Emirates"),
                  const Gap(10),
                  CustomText(
                      text: state.creditNoteDetailsModel?.association?.email ??
                          ""),
                  const Gap(10),
                  CustomText(
                    text:
                        "TRN: ${state.creditNoteDetailsModel?.association?.trnNumber ?? ""}",
                    fontWeight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  const Gap(10),
                  RowText(
                    text:
                        "Unit: ${state.creditNoteDetailsModel?.creditable?.unitNumber ?? ""}",
                    text2:
                        "CreditNote No. ${state.creditNoteDetailsModel?.reference ?? ""}",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Date",
                    text2: const OccupantPage().dateTimeFormatter(
                        state.creditNoteDetailsModel?.datetime),
                  ),
                  const Gap(10),
                  const RowText(
                    text: "Owner",
                    text2: "Hammad Ahmad",
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
                          "Amount",
                        ]
                            .map((e) => const SharedDocumentPage()
                                .sharedDocumentDataColumn(e))
                            .toList(),
                        rows: (state.creditNoteDetailsModel?.transactions
                                    ?.map((e) => {
                                          "Account": e.account?.name ?? " -- ",
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
                            .map((e) => const LedgerPage().ledgerDataRow(e))
                            .toList()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
