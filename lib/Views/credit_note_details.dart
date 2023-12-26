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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kGrey.shade100),
                        child: const Icon(
                          Icons.person_outline,
                          size: 30,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: context
                                      .read<ProfileCubit>()
                                      .state
                                      .profileModel
                                      ?.record
                                      ?.company
                                      ?.name ??
                                  "",
                              fontWeight: FontWeight.bold,
                              fontsize: 18,
                              textAlign: TextAlign.left,
                            ),
                            const Gap(10),
                            CustomText(
                              text: context
                                      .read<ProfileCubit>()
                                      .state
                                      .profileModel
                                      ?.record
                                      ?.company
                                      ?.address1 ??
                                  "",
                              textAlign: TextAlign.left,
                              fontsize: 12,
                              color: kGrey,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  CustomText(
                    text: "Details",
                    color: context.read<AppThemeCubit>().state.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: kGrey.shade200,
                          blurRadius: 2,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: state.creditNoteDetailsModel?.title ?? "",
                              fontWeight: FontWeight.bold,
                              fontsize: 18,
                            ),
                            const Gap(10),
                            CustomText(
                              text: state.creditNoteDetailsModel?.association
                                      ?.name ??
                                  "",
                              fontsize: 12,
                              color: kGrey,
                            ),
                          ],
                        ),
                        const Divider(),
                        const Gap(10),
                        RowText(
                          text: "TRN:",
                          text2: state.creditNoteDetailsModel?.association
                                  ?.trnNumber ??
                              "",
                        ),
                        const Gap(10),
                        RowText(
                          text: "Unit:",
                          text2: state.creditNoteDetailsModel?.creditable
                                  ?.unitNumber ??
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
                      ],
                    ),
                  ),
                  const Gap(10),
                  CustomText(
                    text: "Transactions",
                    color: context.read<AppThemeCubit>().state.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(10),
                  Column(
                    children: state.creditNoteDetailsModel?.transactions
                            ?.map(
                              (e) => Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        color: kGrey.shade200),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: e.account?.title ?? "",
                                          fontWeight: FontWeight.bold,
                                          fontsize: 18,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: context
                                                    .read<AppThemeCubit>()
                                                    .state
                                                    .primaryColor
                                                    .withOpacity(0.2)),
                                            child: CustomText(
                                                text: e.type?.capitalize() ??
                                                    "")),
                                      ],
                                    ),
                                    CustomText(
                                        text: e.description == "" ||
                                                e.description == " "
                                            ? " -- "
                                            : e.description ?? " -- "),
                                    RowText(
                                      text: "Amount",
                                      text2: formatCurrency(
                                          e.amount ?? 0),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList() ??
                        [],
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
