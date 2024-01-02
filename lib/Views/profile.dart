import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Profile Information",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          if (state.profileModel?.record == null) {
            return const CreditNotesPage().emptyList(
              ontap: () => context.read<ProfileCubit>().getProfile(context),
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
              "title": "Phoe",
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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
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
                                height: 50,
                              ),
                              CustomText(
                                text:
                                    state.profileModel?.record?.firstName ?? "",
                                fontWeight: FontWeight.bold,
                                fontsize: 20,
                              ),
                              CustomText(
                                text:
                                    "Owner ID : ${state.profileModel?.record?.ownerNumber ?? " -- "}",
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                                fontsize: 15,
                              ),
                              Divider(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: profileData.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    color: kGrey.shade300,
                                    height: 1,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return profileInfoTile(
                                    context,
                                    profileData[index]["title"] as String,
                                    profileData[index]["subTitle"] as String?,
                                    profileData[index]["icon"] as IconData,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          state.profileModel?.record?.profileImageUrl ?? "",
                          height: 100,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) =>
                              const UnitsPage().roundedContainer(
                                  context,
                                  const Icon(
                                    Icons.person_3_outlined,
                                    color: kWhite,
                                    size: 45,
                                  ),
                                  height: 100,
                                  width: 100),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Color parseHexColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    int hexValue = int.parse(hexColor, radix: 16);

    return Color(hexValue)
        .withAlpha(0xFF); // Ensure full opacity (alpha value of 0xFF)
  }
  Widget profileInfoTile(
      BuildContext context, String title, String? subTitle, IconData icon) {
    return ListTile(
      dense: true,
      leading: Icon(
        icon,
        color: context.read<AppThemeCubit>().state.primaryColor,
      ),
      title: CustomText(
        text: title,
        textAlign: TextAlign.left,
        fontsize: 15,
      ),
      subtitle: CustomText(
        text: subTitle ?? " -- ",
        textAlign: TextAlign.left,
        color: kGrey,
        fontsize: 13,
      ),
    );
  }
}
