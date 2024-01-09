import 'dart:io';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class OccupantPage extends StatelessWidget {
  const OccupantPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                widget: CustomText(
                  text: "Unit $unitNumber - Occupant",
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<OccupantCubit, OccupantState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.occupantModel?.occupant == null) {
                    return const CreditNotesPage().emptyList(
                        ontap: () => context
                            .read<OccupantCubit>()
                            .getOccupant(context, unitId));
                  }
                  List<Map<String, dynamic>> occupantData = [
                    {
                      "icon": Icons.merge_type_outlined,
                      "key": "Type",
                      "value": state.occupantModel?.occupant?.details?.type,
                    },
                    {
                      "icon": Icons.email_outlined,
                      "key": "Email",
                      "value":
                          state.occupantModel?.occupant?.details?.primaryEmail,
                    },
                    {
                      "icon": Icons.phone_outlined,
                      "key": "Primary Phone",
                      "value":
                          state.occupantModel?.occupant?.details?.primaryPhone,
                    },
                    {
                      "icon": Icons.card_membership_outlined,
                      "key": "Passport No.",
                      "value": state
                          .occupantModel?.occupant?.details?.passportNumber,
                    },
                    {
                      "icon": Icons.calendar_month_outlined,
                      "key": "Passport Expiry",
                      "value": dateTimeFormatter(state
                          .occupantModel?.occupant?.details?.passportExpiry),
                    },
                    {
                      "icon": Icons.numbers_outlined,
                      "key": "Emirates ID No.",
                      "value": state
                          .occupantModel?.occupant?.details?.emiratesIdNumber,
                    },
                    {
                      "icon": Icons.calendar_month_outlined,
                      "key": "Emirates ID Expiry",
                      "value": dateTimeFormatter(state
                          .occupantModel?.occupant?.details?.emiratesIdExpiry),
                    },
                    {
                      "icon": Icons.numbers_outlined,
                      "key": "TRN",
                      "value":
                          state.occupantModel?.occupant?.details?.trnNumber,
                    },
                    {
                      "icon": Icons.calendar_month_outlined,
                      "key": "Date of Birth",
                      "value": state.occupantModel?.occupant?.details?.dob,
                    },
                    {
                      "icon": Icons.calendar_month_outlined,
                      "key": "Tenancy Contract Expiry",
                      "value": dateTimeFormatter(state.occupantModel?.occupant
                          ?.details?.tenancyContractExpiry),
                    },
                    {
                      "icon": Icons.title_outlined,
                      "key": "Title Deed No.",
                      "value": state
                          .occupantModel?.occupant?.details?.titleDeedNumber,
                    },
                    {
                      "icon": Icons.location_city_outlined,
                      "key": "Country",
                      "value": state.occupantModel?.occupant?.details?.country,
                    },
                    {
                      "icon": Icons.web_stories_outlined,
                      "key": "State",
                      "value": state.occupantModel?.occupant?.details?.state,
                    },
                    {
                      "icon": Icons.location_city_outlined,
                      "key": "City",
                      "value": state.occupantModel?.occupant?.details?.city,
                    },
                    {
                      "icon": Icons.streetview_outlined,
                      "key": "Address",
                      "value":
                          state.occupantModel?.occupant?.details?.fullAddress,
                    },
                  ];
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<OccupantCubit>()
                          .getOccupant(context, unitId);
                    },
                    child: SingleChildScrollView(
                      child: Container(
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
                            Column(
                              children: occupantData
                                  .map((e) =>
                                      const ProfilePage().profileInfoTile(
                                        context,
                                        e["key"] as String,
                                        e["value"] as String?,
                                      ))
                                  .toList(),
                            ),
                            const Gap(5),
                            if (state
                                        .occupantModel
                                        ?.occupant
                                        ?.emergencyContactDetails
                                        ?.alternativeEmergencyContactName !=
                                    null ||
                                state
                                        .occupantModel
                                        ?.occupant
                                        ?.emergencyContactDetails
                                        ?.emergencyContactName !=
                                    null)
                              CustomText(
                                text: "Emergency Contact Details",
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            if (state
                                        .occupantModel
                                        ?.occupant
                                        ?.emergencyContactDetails
                                        ?.alternativeEmergencyContactName !=
                                    null ||
                                state
                                        .occupantModel
                                        ?.occupant
                                        ?.emergencyContactDetails
                                        ?.emergencyContactName !=
                                    null)
                              const SizedBox(
                                height: 10,
                              ),
                            if (state
                                    .occupantModel
                                    ?.occupant
                                    ?.emergencyContactDetails
                                    ?.emergencyContactName !=
                                null)
                              emergencyContactCard(
                                  context,
                                  state
                                          .occupantModel
                                          ?.occupant
                                          ?.emergencyContactDetails
                                          ?.emergencyContactName ??
                                      " -- ",
                                  phoneNumber: state
                                      .occupantModel
                                      ?.occupant
                                      ?.emergencyContactDetails
                                      ?.emergencyContactPhone),
                            if (state
                                    .occupantModel
                                    ?.occupant
                                    ?.emergencyContactDetails
                                    ?.emergencyContactName !=
                                null)
                              const SizedBox(
                                height: 10,
                              ),
                            if (state
                                    .occupantModel
                                    ?.occupant
                                    ?.emergencyContactDetails
                                    ?.alternativeEmergencyContactName !=
                                null)
                              emergencyContactCard(
                                  context,
                                  state
                                          .occupantModel
                                          ?.occupant
                                          ?.emergencyContactDetails
                                          ?.alternativeEmergencyContactName ??
                                      " -- ",
                                  phoneNumber: state
                                      .occupantModel
                                      ?.occupant
                                      ?.emergencyContactDetails
                                      ?.alternativeEmergencyContactPhone),
                            if (state
                                    .occupantModel
                                    ?.occupant
                                    ?.emergencyContactDetails
                                    ?.alternativeEmergencyContactName !=
                                null)
                              const SizedBox(
                                height: 10,
                              ),
                            if (state.occupantModel?.occupant?.vehicles !=
                                    null &&
                                (state.occupantModel?.occupant?.vehicles
                                        ?.isNotEmpty ??
                                    false))
                              vehicleSection(context,
                                  state.occupantModel?.occupant?.vehicles),
                            CustomText(
                              text: "Documents",
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                            const Gap(10),
                            Builder(builder: (context) {
                              List documents = [
                                {
                                  "name": "Passport",
                                  "url": state.occupantModel?.occupant
                                      ?.documents?.passportFile,
                                },
                                {
                                  "name": "Tenancy Contract",
                                  "url": state.occupantModel?.occupant
                                      ?.documents?.tenancyContract,
                                },
                                {
                                  "name": "Title Deed",
                                  "url": state.occupantModel?.occupant
                                      ?.documents?.titleDeed,
                                },
                                {
                                  "name": "ID",
                                  "url": state.occupantModel?.occupant
                                      ?.documents?.idFile,
                                },
                              ];
                              return ListView.separated(
                                itemCount: 4,
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Column(
                                    children: [
                                      Divider(
                                        thickness: 0.5,
                                      ),
                                      Gap(5),
                                    ],
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return const OwnersPage().documentInfo(
                                      context, documents[index]["name"],
                                      url: documents[index]["url"]);
                                },
                              );
                            }),
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

  Widget vehicleSection(BuildContext context, dynamic vehicles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Vehicles",
          color: context.read<AppThemeCubit>().state.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        vehicleRegistrationCard(context, "1231234", "Apr 1, 2024"),
        const SizedBox(
          height: 10,
        ),
        vehicleRegistrationCard(context, "6565765", "Sept 15, 2024"),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget vehicleRegistrationCard(
      BuildContext context, String registration, String date) {
    return const UnitsPage().roundedContainer(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Registration No.",
                color: context.read<AppThemeCubit>().state.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              CustomText(
                text: registration,
                color: kBlack,
                fontSize: 13,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Date Added : ",
                color: context.read<AppThemeCubit>().state.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              CustomText(
                text: date,
                color: kBlack,
                fontSize: 13,
              ),
            ],
          ),
        ],
      ),
      color: kGrey.shade200,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
    );
  }

  Widget emergencyContactCard(BuildContext context, String name,
      {String? phoneNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Image.asset(
              "assets/occupant.png",
              width: MediaQuery.of(context).size.width * 0.07,
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(10),
            Expanded(
              child: CustomText(
                text: name,
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.bold,
                maxLines: 1,
              ),
            ),
            Row(
              children: [
                {
                  "icon": "assets/phone.png",
                  "onTap": () {
                    if (phoneNumber != null) {
                      launchUrl(Uri.parse("tel:$phoneNumber"));
                    }
                  }
                },
                {
                  "icon": "assets/messages.png",
                  "onTap": () {
                    if (phoneNumber != null) {
                      launchUrl(Uri.parse("sms:$phoneNumber"));
                    }
                  }
                },
                {
                  "icon": "assets/whatsapp.png",
                  "onTap": () {
                    if (phoneNumber != null) {
                      if (Platform.isAndroid) {
                        launchUrl(Uri.parse(
                            "https://wa.me/$phoneNumber/?text=${Uri.parse("hello!")}"));
                      } else {
                        launchUrl(Uri.parse(
                            "https://api.whatsapp.com/send?phone=$phoneNumber=${Uri.parse("hello!")}"));
                      }
                    }
                  }
                },
              ]
                  .map((e) => Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor
                                .withOpacity(0.1)),
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          e["icon"] as String,
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ],
    );
  }

  String dateTimeFormatter(DateTime? date) {
    if (date != null) {
      return DateFormat.yMd().format(date);
    }
    return " -- ";
  }
}
