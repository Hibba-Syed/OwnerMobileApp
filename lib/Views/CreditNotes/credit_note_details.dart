import 'package:iskaanowner/Blocs/Credit%20Note%20Details/credit_note_details_cubit.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class CreditNoteDetailsPage extends StatelessWidget {
  const CreditNoteDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? creditNoteId = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage()
                  .appBar(context, text: "Credit Note Details"),
            ),
            Expanded(
              child:
                  BlocBuilder<CreditNoteDetailsCubit, CreditNoteDetailsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.creditNoteDetailsModel == null) {
                    return const CreditNotesPage().emptyList(
                        ontap: () => context
                            .read<CreditNoteDetailsCubit>()
                            .getCreditNoteDetails(context, creditNoteId));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<CreditNoteDetailsCubit>()
                          .getCreditNoteDetails(context, creditNoteId);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  height:
                                      MediaQuery.of(context).size.width * 0.12,
                                  decoration: const BoxDecoration(
                                    color: kWhite,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    context
                                            .read<ProfileCubit>()
                                            .state
                                            .profileModel
                                            ?.record
                                            ?.company
                                            ?.faviconUrl ??
                                        "",
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    height: MediaQuery.of(context).size.width *
                                        0.12,
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        fontSize: 18,
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
                                        fontSize: 12,
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
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
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
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ListTileTheme(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  horizontalTitleGap: 0.0,
                                  minLeadingWidth: 0,
                                  child: ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            text: state.creditNoteDetailsModel
                                                    ?.title ??
                                                " -- ",
                                            color: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        if (state.creditNoteDetailsModel
                                                ?.association?.name !=
                                            null)
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const UnitsPage()
                                                  .roundedContainer(
                                                      context,
                                                      CustomText(
                                                        text: state
                                                                .creditNoteDetailsModel
                                                                ?.association
                                                                ?.name ??
                                                            "",
                                                        color: context
                                                            .read<
                                                                AppThemeCubit>()
                                                            .state
                                                            .primaryColor,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                      ),
                                                      color: context
                                                          .read<AppThemeCubit>()
                                                          .state
                                                          .primaryColor
                                                          .withOpacity(0.1),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 5)),
                                            ],
                                          ),
                                      ],
                                    ),
                                    children: [
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "TRN:",
                                          state.creditNoteDetailsModel
                                              ?.association?.trnNumber),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Unit:",
                                          state.creditNoteDetailsModel
                                              ?.creditable?.unitNumber),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "CreditNote No.",
                                          state.creditNoteDetailsModel
                                              ?.reference),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Date:",
                                          const OccupantPage()
                                              .dateTimeFormatter(state
                                                  .creditNoteDetailsModel
                                                  ?.datetime)),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Owner:",
                                          context
                                              .read<ProfileCubit>()
                                              .state
                                              .profileModel
                                              ?.record
                                              ?.fullName),
                                      const Gap(10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            CustomText(
                              text: "Transactions",
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                            const Gap(10),
                            Column(
                              children: state
                                      .creditNoteDetailsModel?.transactions
                                      ?.map(
                                        (e) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: kWhite,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2,
                                                  spreadRadius: 2,
                                                  color: kGrey.shade200),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: CustomText(
                                                      text: e.account?.title ??
                                                          "",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: context
                                                              .read<
                                                                  AppThemeCubit>()
                                                              .state
                                                              .primaryColor
                                                              .withOpacity(
                                                                  0.2)),
                                                      child: CustomText(
                                                          text: e.type
                                                                  ?.capitalize() ??
                                                              "")),
                                                ],
                                              ),
                                              CustomText(
                                                  text: e.description == "" ||
                                                          e.description == " "
                                                      ? " -- "
                                                      : e.description ??
                                                          " -- "),
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
                            ),
                            if (state.creditNoteDetailsModel?.transactions
                                    ?.isNotEmpty ??
                                false)
                              const Gap(10),
                            if (state.creditNoteDetailsModel?.transactions
                                    ?.isNotEmpty ??
                                false)
                              RowText(
                                text: "Total : ",
                                text2: formatCurrency((state
                                            .creditNoteDetailsModel
                                            ?.transactions
                                            ?.map((e) => e.amount ?? 0)
                                            .toList() ??
                                        [])
                                    .reduce(
                                        (value, element) => value + element)),
                              ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
