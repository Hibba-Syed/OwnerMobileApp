import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Blocs/Compliance%20Details/compliance_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/compliance_details.dart';
import '../../Utils/utils.dart';

class ComplianceDetailsPage extends StatelessWidget {
  const ComplianceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int? unitId = arguments['unit_id'];
    int? id = arguments['id'];
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton(
          text: "Update Compliance",
          height: MediaQuery.of(context).size.width * 0.12,
          icon: Image.asset(
            "assets/edit.png",
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          function: () {
            Navigator.pushNamed(context, AppRoutes.editCompliances);
          },
          fontSize: MediaQuery.of(context).size.width * 0.035,
          buttonColor:
              context.read<AppThemeCubit>().state.primaryColor.withOpacity(0.8),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const DashboardPage().appBar(
                context,
                text: "View Compliance",
              ),
              Expanded(
                child:
                    BlocBuilder<ComplianceDetailsCubit, ComplianceDetailsState>(
                  builder: (context, state) {
                    if (state.loadingState == LoadingState.loading) {
                      return const CustomLoader();
                    }
                    if (state.loadingState == LoadingState.error) {
                      return const CreditNotesPage().emptyList(
                          ontap: () => context
                              .read<ComplianceDetailsCubit>()
                              .getUnitComplianceDetails(context, id, unitId));
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(10),
                                CustomText(
                                  text: "Chiller Maintenance",
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                const Gap(10),
                                const ProfilePage().profileInfoTile(
                                    context,
                                    "Compliance Date",
                                    state.complianceDetailsModel?.record
                                            ?.date ??
                                        ""),
                                const ProfilePage().profileInfoTile(
                                    context,
                                    "Compliance Expiry",
                                    state.complianceDetailsModel?.record
                                            ?.expiryDate ??
                                        ""),
                                const ProfilePage().profileInfoTile(
                                    context,
                                    "Description",
                                    state.complianceDetailsModel?.record
                                            ?.description ??
                                        ""),
                                const Gap(10),
                                CustomText(
                                  text: "Certificate",
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                const Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "Compliance Certificate",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (state.complianceDetailsModel?.record
                                                ?.certificate !=
                                            null) {
                                          launchUrl(Uri.parse(state
                                                  .complianceDetailsModel
                                                  ?.record
                                                  ?.certificate ??
                                              ""));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(0xff65D024)
                                                .withOpacity(0.1)),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/download_summary.png",
                                              color: const Color(0xff65D024),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            CustomText(
                                              text: "Download",
                                              color: const Color(0xff65D024),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Gap(10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(10),
                                CustomText(
                                  text: "History",
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                const Gap(10),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      History? history = state
                                          .complianceDetailsModel
                                          ?.record
                                          ?.history?[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const ProfilePage().profileInfoTile(
                                              context,
                                              "Compliance Date",
                                              history?.date),
                                          const ProfilePage().profileInfoTile(
                                              context,
                                              "Compliance Expiry",
                                              history?.expiryDate),
                                          const Gap(10),
                                          CustomText(
                                            text: "Certificate",
                                            color: context
                                                .read<AppThemeCubit>()
                                                .state
                                                .primaryColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          const Gap(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: "Compliance Certificate",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (history?.certificate !=
                                                      null) {
                                                    launchUrl(Uri.parse(
                                                        history?.certificate ??
                                                            ""));
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: const Color(
                                                              0xff65D024)
                                                          .withOpacity(0.1)),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/download_summary.png",
                                                        color: const Color(
                                                            0xff65D024),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      CustomText(
                                                        text: "Download",
                                                        color: const Color(
                                                            0xff65D024),
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Divider(
                                            thickness: 2,
                                          ),
                                        ),
                                    itemCount: state.complianceDetailsModel
                                            ?.record?.history?.length ??
                                        0)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
