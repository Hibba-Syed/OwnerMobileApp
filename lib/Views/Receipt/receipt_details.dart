import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class ReceiptDetailsPage extends StatelessWidget {
  const ReceiptDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? receiptId = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage()
                  .appBar(context, text: "Receipt Details"),
            ),
            Expanded(
              child: BlocBuilder<ReceiptDetailsCubit, ReceiptDetailsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.receiptDetailsModel == null) {
                    return const CreditNotesPage().emptyList(
                        ontap: () => context
                            .read<ReceiptDetailsCubit>()
                            .getReceiptDetails(context, receiptId));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<ReceiptDetailsCubit>()
                          .getReceiptDetails(context, receiptId);
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
                                CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.075,
                                  backgroundColor: kWhite,
                                  child: CircleAvatar(
                                    radius: MediaQuery.of(context).size.width *
                                        0.06,
                                    backgroundColor: kWhite,
                                    backgroundImage: NetworkImage(context
                                            .read<ProfileCubit>()
                                            .state
                                            .profileModel
                                            ?.record
                                            ?.company
                                            ?.faviconUrl ??
                                        ""),
                                    onBackgroundImageError:
                                        (exception, stackTrace) =>
                                            const AssetImage(
                                                "assets/placeHolder.png"),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text:
                                            "Unit ${state.receiptDetailsModel?.unitwise?.first.name}, ${state.receiptDetailsModel?.association?.name ?? ""}",
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        textAlign: TextAlign.left,
                                      ),
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
                                                0.035,
                                        textAlign: TextAlign.left,
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
                                      text: state
                                              .receiptDetailsModel?.reference ??
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
                                          state.receiptDetailsModel?.title),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "TRN:",
                                          state.receiptDetailsModel?.association
                                              ?.trnNumber),
                                      const Gap(10),
                                      if (state.receiptDetailsModel?.unitwise !=
                                              null &&
                                          (state.receiptDetailsModel?.unitwise
                                                  ?.isNotEmpty ??
                                              false))
                                        const ProfilePage().profileInfoTile(
                                            context,
                                            "Unit:",
                                            state.receiptDetailsModel?.unitwise
                                                ?.first.name),
                                      if (state.receiptDetailsModel?.unitwise !=
                                              null &&
                                          (state.receiptDetailsModel?.unitwise
                                                  ?.isNotEmpty ??
                                              false))
                                        const Gap(10),
                                      if (state.receiptDetailsModel?.association
                                              ?.name !=
                                          null)
                                        const ProfilePage().profileInfoTile(
                                            context,
                                            "Community Name:",
                                            state.receiptDetailsModel
                                                ?.association?.name),
                                      if (state.receiptDetailsModel?.association
                                              ?.name !=
                                          null)
                                        const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Payment Method:",
                                          state.receiptDetailsModel
                                              ?.paymentMethod),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Payment Date:",
                                          const OccupantPage()
                                              .dateTimeFormatter(state
                                                  .receiptDetailsModel
                                                  ?.paymentDate)),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Receipt Date:",
                                          const OccupantPage()
                                              .dateTimeFormatter(state
                                                  .receiptDetailsModel
                                                  ?.datetime)),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Paid by:",
                                          state.receiptDetailsModel
                                              ?.unitwise?[0].owner?.mobile),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Phone:",
                                          state.receiptDetailsModel
                                              ?.unitwise?[0].owner?.mobile),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Email:",
                                          state.receiptDetailsModel
                                              ?.unitwise?[0].owner?.email),
                                      const Gap(10),
                                      const ProfilePage().profileInfoTile(
                                          context,
                                          "Bank account:",
                                          state.receiptDetailsModel?.account
                                              ?.type),
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
                              children: state.receiptDetailsModel?.transactions
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
                                                          BorderRadius.circular(
                                                              10),
                                                      color: (e.type?.toLowerCase() ==
                                                                  "credit"
                                                              ? const Color(
                                                                  0xff65D024)
                                                              : const Color(
                                                                  0xffFB5454))
                                                          .withOpacity(0.1),
                                                    ),
                                                    child: CustomText(
                                                      text: e.type
                                                              ?.capitalize() ??
                                                          "",
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.035,
                                                      color:
                                                          e.type?.toLowerCase() ==
                                                                  "credit"
                                                              ? const Color(
                                                                  0xff65D024)
                                                              : const Color(
                                                                  0xffFB5454),
                                                    ),
                                                  ),
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
                            if (state.receiptDetailsModel?.transactions
                                    ?.isNotEmpty ??
                                false)
                              const Gap(10),
                            if (state.receiptDetailsModel?.transactions
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
                                          (state.receiptDetailsModel
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
                          ].animate(interval: 50.ms).fade(),
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

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
