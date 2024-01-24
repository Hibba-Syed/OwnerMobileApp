import 'package:cool_alert/cool_alert.dart';
import 'package:iskaanowner/Blocs/Primary%20Owner%20Activity/primary_owner_activity_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/owners.dart';
import '../Models/profile.dart';
import '../Utils/utils.dart';

class OwnersPage extends StatelessWidget {
  const OwnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileModel? profileModel =
        context.read<ProfileCubit>().state.profileModel;
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                text: "Unit $unitNumber - Owners",
              ),
            ),
            GestureDetector(
              onTap: () {
                context
                    .read<PrimaryOwnerActivityCubit>()
                    .getPrimaryOwnerActivity(context, unitId);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomText(
                          text: "Status Logs",
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: BlocBuilder<PrimaryOwnerActivityCubit,
                            PrimaryOwnerActivityState>(
                          builder: (context, state) {
                            if (state.loadingState == LoadingState.loading) {
                              return const CustomLoader();
                            }
                            return ListView.separated(
                              padding: const EdgeInsets.all(10),
                              itemCount: state.primaryOwnerActivityModel?.record
                                      ?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  // margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kWhite),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: context
                                                    .read<AppThemeCubit>()
                                                    .state
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle),
                                            child: CustomText(
                                              text: state
                                                      .primaryOwnerActivityModel
                                                      ?.record?[index]
                                                      .currentOwner
                                                      ?.split(" ")
                                                      .first[0] ??
                                                  "",
                                              color: context
                                                  .read<AppThemeCubit>()
                                                  .state
                                                  .primaryColor,
                                            ),
                                          ),
                                          const Gap(10),
                                          Image.asset(
                                            "assets/switch.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          const Gap(10),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: context
                                                    .read<AppThemeCubit>()
                                                    .state
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle),
                                            child: CustomText(
                                              text: state
                                                      .primaryOwnerActivityModel
                                                      ?.record?[index]
                                                      .oldOwner
                                                      ?.split(" ")
                                                      .first[0] ??
                                                  "",
                                              color: context
                                                  .read<AppThemeCubit>()
                                                  .state
                                                  .primaryColor,
                                            ),
                                          ),
                                          const Spacer(),
                                          CustomText(
                                            text: const OccupantPage()
                                                .dateTimeFormatter(
                                              state.primaryOwnerActivityModel
                                                  ?.record?[index].createdAt,
                                            ),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                            text: state
                                                    .primaryOwnerActivityModel
                                                    ?.record?[index]
                                                    .currentOwner ??
                                                "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          CustomText(
                                            text: " to ",
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          CustomText(
                                            text: state
                                                    .primaryOwnerActivityModel
                                                    ?.record?[index]
                                                    .currentOwner ??
                                                "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Gap(20);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/info.png",
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    const Gap(10),
                    CustomText(
                      text: "Primary status history",
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    )
                  ],
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: BlocBuilder<OwnersCubit, OwnersState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.ownersModel?.units?.owners?.isEmpty ?? true) {
                    return const CreditNotesPage().emptyList(
                        ontap: () => context
                            .read<OwnersCubit>()
                            .getOwners(context, unitId));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<OwnersCubit>().getOwners(context, unitId);
                    },
                    child: ListView.builder(
                      itemCount: state.ownersModel?.units?.owners?.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool iAmPrimary = false;
                        Owner? owner = state.ownersModel?.units?.owners?[index];
                        for (Owner element
                            in state.ownersModel?.units?.owners ?? []) {
                          if (element.detail?.primaryEmail ==
                                  profileModel?.record?.primaryEmail &&
                              element.detail?.id == profileModel?.record?.id) {
                            iAmPrimary = true;
                          }
                        }
                        List<Map<String, dynamic>> ownerData = [
                          {
                            "icon": Icons.person_outline,
                            "key": "Arabic Name",
                            "value": owner?.detail?.arabicName,
                          },
                          {
                            "icon": Icons.person_outline,
                            "key": "Mollak Owner Name",
                            "value": owner?.detail?.name,
                          },
                          {
                            "icon": Icons.email_outlined,
                            "key": "Email",
                            "value": owner?.detail?.primaryEmail,
                          },
                          {
                            "icon": Icons.phone_outlined,
                            "key": "Primary Phone",
                            "value": owner?.detail?.primaryPhone,
                          },
                          {
                            "icon": Icons.phone_outlined,
                            "key": "Secondary Phone",
                            "value": owner?.detail?.secondaryPhone,
                          },
                          {
                            "icon": Icons.card_membership_outlined,
                            "key": "Passport No.",
                            "value": owner?.detail?.passportNumber,
                          },
                          {
                            "icon": Icons.calendar_month_outlined,
                            "key": "Passport Expiry",
                            "value": const OccupantPage().dateTimeFormatter(
                                owner?.detail?.passportExpiry),
                          },
                          {
                            "icon": Icons.numbers_outlined,
                            "key": "Emirates ID No.",
                            "value": owner?.detail?.emiratesIdNumber,
                          },
                          {
                            "icon": Icons.calendar_month_outlined,
                            "key": "Emirates ID Expiry",
                            "value": const OccupantPage().dateTimeFormatter(
                                owner?.detail?.emiratesIdExpiry),
                          },
                          {
                            "icon": Icons.numbers_outlined,
                            "key": "TRN",
                            "value": owner?.detail?.trnNumber,
                          },
                          {
                            "icon": Icons.title_outlined,
                            "key": "Title Deed No.",
                            "value": owner?.detail?.titleDeedNumber,
                          },
                          {
                            "icon": Icons.calendar_month_outlined,
                            "key": "Date of Birth",
                            "value": const OccupantPage()
                                .dateTimeFormatter(owner?.detail?.dob),
                          },
                          {
                            "icon": Icons.location_city_outlined,
                            "key": "Country",
                            "value": owner?.detail?.country,
                          },
                          {
                            "icon": Icons.web_stories_outlined,
                            "key": "State",
                            "value": owner?.detail?.state,
                          },
                          {
                            "icon": Icons.location_city_outlined,
                            "key": "City",
                            "value": owner?.detail?.city,
                          },
                          {
                            "icon": Icons.streetview_outlined,
                            "key": "Address",
                            "value": owner?.detail?.fullAddress,
                          },
                        ];
                        return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kWhite),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ListTileTheme(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                horizontalTitleGap: 0.0,
                                minLeadingWidth: 0,
                                child: ExpansionTile(
                                  initiallyExpanded: index == 0 ? true : false,
                                  tilePadding: EdgeInsets.zero,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          text: owner?.detail?.name ?? "",
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      if (owner?.detail?.isPrimary == 1)
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const UnitsPage().roundedContainer(
                                                context,
                                                CustomText(
                                                  text: "Primary",
                                                  color: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.035,
                                                ),
                                                color: context
                                                    .read<AppThemeCubit>()
                                                    .state
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5)),
                                          ],
                                        ),
                                    ],
                                  ),
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: ownerData
                                              .map((e) => const ProfilePage()
                                                      .profileInfoTile(
                                                    context,
                                                    e["key"] as String,
                                                    e["value"] as String?,
                                                  ))
                                              .toList(),
                                        ),
                                        const Gap(10),
                                        CustomText(
                                          text: "Documents",
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
                                        Builder(builder: (context) {
                                          List documents = [
                                            {
                                              "name": "Title Deed",
                                              "url":
                                                  owner?.documents?.titleDeed,
                                            },
                                            {
                                              "name": "Passport",
                                              "url": owner
                                                  ?.documents?.passportFile,
                                            },
                                            {
                                              "name": "ID",
                                              "url": owner?.documents?.idFile,
                                            },
                                          ];
                                          return ListView.separated(
                                            itemCount: 3,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const Column(
                                                children: [
                                                  Divider(
                                                    thickness: 0.5,
                                                  ),
                                                  Gap(5),
                                                ],
                                              );
                                            },
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return documentInfo(context,
                                                  documents[index]["name"],
                                                  url: documents[index]["url"]);
                                            },
                                          );
                                        }),
                                        if (owner?.detail?.isPrimary == 0 &&
                                            iAmPrimary)
                                          const Gap(20),
                                        if (owner?.detail?.isPrimary == 0 &&
                                            iAmPrimary)
                                          CustomButton(
                                            text: "Make Primary",
                                            function: () {
                                              CoolAlert.show(
                                                  confirmBtnColor: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor,
                                                  backgroundColor: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor
                                                      .withOpacity(0.1),
                                                  context: context,
                                                  type: CoolAlertType.info,
                                                  confirmBtnText: "Yes",
                                                  cancelBtnText: "No",
                                                  text:
                                                      "Are you sure you want to make this owner as primary owner",
                                                  title: "Are you sure?",
                                                  showCancelBtn: true,
                                                  onConfirmBtnTap: () {
                                                    CoolAlert.show(
                                                      context: context,
                                                      type:
                                                          CoolAlertType.loading,
                                                      lottieAsset:
                                                          "assets/loader.json",
                                                    );
                                                  });
                                            },
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
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

  Widget documentInfo(BuildContext context, String text, {String? url}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(
            text: text,
            textAlign: TextAlign.left,
          ),
        ),
        viewButton(context, url)
      ],
    );
  }

  Widget viewButton(BuildContext context, String? url) {
    return const UnitsPage().roundedContainer(
      context,
      InkWell(
        onTap: () {
          if (url != null && url != "$baseUrl/null" && url != "") {
            launchUrl(Uri.parse(url));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: (url == null || url == "$baseUrl/null" || url == "")
                ? kGrey.withOpacity(0.1)
                : context
                    .read<AppThemeCubit>()
                    .state
                    .primaryColor
                    .withOpacity(0.1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/eye.png",
                width: MediaQuery.of(context).size.width * 0.06,
                color: (url == null || url == "$baseUrl/null" || url == "")
                    ? kGrey
                    : context.read<AppThemeCubit>().state.primaryColor,
              ),
              CustomText(
                text: " View",
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: (url == null || url == "$baseUrl/null" || url == "")
                    ? kGrey
                    : context.read<AppThemeCubit>().state.primaryColor,
              )
            ],
          ),
        ),
      ),
      invert:
          (url == null || url == "$baseUrl/null" || url == "") ? false : true,
      color: kWhite,
      // padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
