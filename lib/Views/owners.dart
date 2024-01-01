import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/owners.dart';
import '../Utils/utils.dart';

class OwnersPage extends StatelessWidget {
  const OwnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Owners",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: const [],
        appBarHeight: 50,
      ),
      body: BlocBuilder<OwnersCubit, OwnersState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<OwnersCubit>().getOwners(context, unitId);
            },
            child: ListView.builder(
              itemCount: state.ownersModel?.units?.owners?.length,
              itemBuilder: (BuildContext context, int index) {
                Owner? owner = state.ownersModel?.units?.owners?[index];
                List<Map<String, dynamic>> ownerData = [
                  {
                    "icon": Icon(
                      Icons.person_outline,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Arabic Name",
                    "value": owner?.detail?.arabicName,
                  },
                  {
                    "icon": Icon(
                      Icons.person_outline,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Mollak Owner Name",
                    "value": owner?.detail?.name,
                  },
                  {
                    "icon": Icon(
                      Icons.email_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Email",
                    "value": owner?.detail?.primaryEmail,
                  },
                  {
                    "icon": Icon(
                      Icons.phone_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Primary Phone",
                    "value": owner?.detail?.primaryPhone,
                  },
                  {
                    "icon": Icon(
                      Icons.phone_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Secondary Phone",
                    "value": owner?.detail?.secondaryPhone,
                  },
                  {
                    "icon": Icon(
                      Icons.card_membership_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Passport No.",
                    "value": owner?.detail?.passportNumber,
                  },
                  {
                    "icon": Icon(
                      Icons.calendar_month_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Passport Expiry",
                    "value": owner?.detail?.passportExpiry,
                  },
                  {
                    "icon": Icon(
                      Icons.numbers_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Emirates ID No.",
                    "value": owner?.detail?.emiratesIdNumber,
                  },
                  {
                    "icon": Icon(
                      Icons.calendar_month_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Emirates ID Expiry",
                    "value": owner?.detail?.emiratesIdExpiry,
                  },
                  {
                    "icon": Icon(
                      Icons.numbers_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "TRN",
                    "value": owner?.detail?.trnNumber,
                  },
                  {
                    "icon": Icon(
                      Icons.title_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Title Deed No.",
                    "value": owner?.detail?.titleDeedNumber,
                  },
                  {
                    "icon": Icon(
                      Icons.calendar_month_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Date of Birth",
                    "value": owner?.detail?.dob,
                  },
                  {
                    "icon": Icon(
                      Icons.location_city_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Country",
                    "value": owner?.detail?.country,
                  },
                  {
                    "icon": Icon(
                      Icons.web_stories_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "State",
                    "value": owner?.detail?.state,
                  },
                  {
                    "icon": Icon(
                      Icons.location_city_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "City",
                    "value": owner?.detail?.city,
                  },
                  {
                    "icon": Icon(
                      Icons.streetview_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    "key": "Address",
                    "value": owner?.detail?.fullAddress,
                  },
                ];
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: kGrey.shade200),
                      ],
                      color: kWhite),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${owner?.detail?.name}",
                              fontWeight: FontWeight.bold,
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor,
                              fontsize: 20,
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
                                    const CustomText(
                                      text: "Primary",
                                      color: kWhite,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10)),
                              ],
                            ),
                        ],
                      ),
                      const Gap(5),
                      Divider(
                        color: context.read<AppThemeCubit>().state.primaryColor,
                      ),
                      const Gap(5),
                      Column(
                        children: ownerData
                            .map((e) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  leading: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kGrey.shade200),
                                    child: e["icon"],
                                  ),
                                  title: CustomText(
                                    text: e["key"] ?? "",
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: CustomText(
                                    text: e["value"] ?? " -- ",
                                    textAlign: TextAlign.left,
                                    color: kGrey,
                                    fontsize: 15,
                                  ),
                                ))
                            .toList(),
                      ),
                      const Gap(5),
                      Divider(
                        color: context.read<AppThemeCubit>().state.primaryColor,
                      ),
                      const Gap(5),
                      CustomText(
                        text: "Documents",
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontsize: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      documentInfo(context, "Title Deed",
                          url: owner?.documents?.titleDeed),
                      documentInfo(context, "Passport",
                          url: owner?.documents?.passportFile),
                      documentInfo(context, "ID",
                          url: owner?.documents?.idFile),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget documentInfo(BuildContext context, String text, {String? url}) {
    return const UnitsPage().roundedContainer(
      context,
      Row(
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
      ),
      color: kGrey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.visibility,
                color: (url == null || url == "$baseUrl/null" || url == "")
                    ? kGrey
                    : context.read<AppThemeCubit>().state.primaryColor,
              ),
              CustomText(
                text: " View",
                color: (url == null || url == "$baseUrl/null" || url == "")
                    ? kGrey
                    : context.read<AppThemeCubit>().state.primaryColor,
              )
            ],
          ),
        ),
        invert:
            (url == null || url == "$baseUrl/null" || url == "") ? false : true,
        color: kWhite,
        padding: const EdgeInsets.symmetric(horizontal: 10));
  }

  TableRow tableRow(BuildContext context, String key, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: context
                .read<AppThemeCubit>()
                .state
                .primaryColor
                .withOpacity(0.1),
            child: CustomText(
              text: key,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        TableCell(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: value,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}
