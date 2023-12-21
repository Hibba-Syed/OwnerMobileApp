import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
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
                    text: "Unit:",
                    text2:
                        state.creditNoteDetailsModel?.creditable?.unitNumber ??
                            "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "CreditNote No.",
                    text2: state.creditNoteDetailsModel?.reference ?? "",
                  ),
                  const Gap(10),
                  RowText(
                    text: "Date:",
                    text2: const OccupantPage().dateTimeFormatter(
                        state.creditNoteDetailsModel?.datetime),
                  ),
                  const Gap(10),
                  RowText(
                    text: "Owner:",
                    text2: context
                            .read<ProfileCubit>()
                            .state
                            .profileModel
                            ?.record
                            ?.fullName ??
                        " -- ",
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
                        rows: (state.creditNoteDetailsModel?.transactions
                                    ?.map((e) => {
                                          "Account": e.account?.name ?? " -- ",
                                          "Description": e.description,
                                          "Amount": e.totalAmount,
                                        })
                                    .toList() ??
                                [])
                            .map((e) => const LedgerPage()
                                .ledgerDataRow(e, context: context))
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
