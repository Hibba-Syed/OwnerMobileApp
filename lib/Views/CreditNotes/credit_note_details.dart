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
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        textAlign: TextAlign.left,
                                      ),
                                      const Gap(2),
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
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
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
                                    title: CustomText(
                                      text: state.creditNoteDetailsModel
                                              ?.reference ??
                                          " -- ",
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                      textAlign: TextAlign.left,
                                    ),
                                    children: [
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Title:",
                                          state.creditNoteDetailsModel?.title),
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
                                      if (state.creditNoteDetailsModel
                                              ?.association?.name !=
                                          null)
                                        const Gap(10),
                                      if (state.creditNoteDetailsModel
                                              ?.association?.name !=
                                          null)
                                        const ProfilePage().profileInfoTile(
                                            context,
                                            "Community Name.",
                                            state.creditNoteDetailsModel
                                                ?.association?.name),
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
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.045,
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: (e.type?.toLowerCase() ==
                                                                      "credit"
                                                                  ? const Color(
                                                                      0xff65D024)
                                                                  : const Color(
                                                                      0xffFB5454))
                                                              .withOpacity(
                                                                  0.1)),
                                                      child: CustomText(
                                                        text: e.type
                                                                ?.capitalize() ??
                                                            "",
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                        color:
                                                            e.type?.toLowerCase() ==
                                                                    "credit"
                                                                ? Colors.green
                                                                : Colors.red,
                                                      )),
                                                ],
                                              ),
                                              CustomText(
                                                text: e.description == "" ||
                                                        e.description == " "
                                                    ? " -- "
                                                    : e.description ?? " -- ",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: "Amount",
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                  ),
                                                  const Gap(10),
                                                  Flexible(
                                                    child: CustomText(
                                                      text: formatCurrency(
                                                          e.amount ?? 0),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.035,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
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
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "Total",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                    ),
                                    const Gap(10),
                                    Flexible(
                                      child: CustomText(
                                        text: formatCurrency(
                                          (state.creditNoteDetailsModel
                                                      ?.transactions
                                                      ?.map(
                                                          (e) => e.amount ?? 0)
                                                      .toList() ??
                                                  [])
                                              .reduce((value, element) =>
                                                  value + element),
                                        ),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
