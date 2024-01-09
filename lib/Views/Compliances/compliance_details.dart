import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';

import '../../Utils/utils.dart';

class ComplianceDetailsPage extends StatelessWidget {
  const ComplianceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          function: () {},
          fontSize: MediaQuery.of(context).size.width * 0.035,
          buttonColor:
              context.read<AppThemeCubit>().state.primaryColor.withOpacity(0.8),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const DashboardPage().appBar(
                  context,
                  widget: CustomText(
                    text: "View Compliance",
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                      const Gap(10),
                      const ProfilePage().profileInfoTile(
                          context, "Compliance Date", "12/18/2023"),
                      const ProfilePage().profileInfoTile(
                          context, "Compliance Expiry", "12/28/2023"),
                      const ProfilePage().profileInfoTile(
                          context,
                          "Description",
                          "Write the description of the compliance here this area will be used for the description"),
                      const Gap(10),
                      CustomText(
                        text: "Certificate",
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Compliance Certificate",
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    const Color(0xff65D024).withOpacity(0.1)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/download_summary.png",
                                  color: const Color(0xff65D024),
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                CustomText(
                                  text: "Download",
                                  color: const Color(0xff65D024),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                )
                              ],
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
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                      const Gap(10),
                      const ProfilePage().profileInfoTile(
                          context, "Compliance Date", "12/18/2023"),
                      const ProfilePage().profileInfoTile(
                          context, "Compliance Expiry", "12/28/2023"),
                      const Gap(10),
                      CustomText(
                        text: "Certificate",
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Compliance Certificate",
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    const Color(0xff65D024).withOpacity(0.1)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/download_summary.png",
                                  color: const Color(0xff65D024),
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                CustomText(
                                  text: "Download",
                                  color: const Color(0xff65D024),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
