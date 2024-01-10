import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
             
                  text: "Profile Information",
             
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state.loadingState == LoadingState.loading) {
                  return const CustomLoader();
                }
                if (state.profileModel?.record == null) {
                  return const CreditNotesPage().emptyList(
                    ontap: () =>
                        context.read<ProfileCubit>().getProfile(context),
                  );
                }
                List<Map> profileData = [
                  {
                    "icon": Icons.email_outlined,
                    "title": "Email",
                    "subTitle": state.profileModel?.record?.email,
                  },
                  {
                    "icon": Icons.phone_outlined,
                    "title": "Phone",
                    "subTitle": state.profileModel?.record?.primaryPhone,
                  },
                  {
                    "icon": Icons.cake_outlined,
                    "title": "D.O.B",
                    "subTitle": state.profileModel?.record?.dob,
                  },
                  {
                    "icon": Icons.padding_outlined,
                    "title": "Passport Number",
                    "subTitle": state.profileModel?.record?.passportNumber,
                  },
                  {
                    "icon": Icons.calendar_month_outlined,
                    "title": "Passport Expiry",
                    "subTitle": state.profileModel?.record?.passportExpiry,
                  },
                  {
                    "icon": Icons.perm_identity_outlined,
                    "title": "Emirates ID",
                    "subTitle": state.profileModel?.record?.emiratesIdNumber,
                  },
                  {
                    "icon": Icons.email_outlined,
                    "title": "Emirates ID Expiry",
                    "subTitle": state.profileModel?.record?.emiratesIdExpiry,
                  },
                ];
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhite,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1, 1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  color: kGrey.shade200),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomText(
                                text:
                                    "${state.profileModel?.record?.firstName ?? ""} ${state.profileModel?.record?.lastName ?? ""}",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              CustomText(
                                text:
                                    "Owner ID : ${state.profileModel?.record?.ownerNumber ?? " -- "}",
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                                fontSize: 15,
                              ),
                              Divider(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                              ),
                              ListView.builder(
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: profileData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return profileInfoTile(
                                    context,
                                    profileData[index]["title"] as String,
                                    profileData[index]["subTitle"] as String?,
                                  );
                                },
                              ),
                              const Gap(10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color parseHexColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    int hexValue = int.parse(hexColor, radix: 16);

    return Color(hexValue)
        .withAlpha(0xFF); // Ensure full opacity (alpha value of 0xFF)
  }

  Widget profileInfoTile(BuildContext context, String title, String? subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: const Color(0xffB2B1B1),
          fontSize: MediaQuery.of(context).size.width * 0.032,
        ),
        const Gap(10),
        CustomText(
          text: subTitle ?? " -- ",
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.w600,
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
