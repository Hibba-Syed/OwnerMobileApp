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
      appBar: BaseAppBar(
        title: "$unitNumber - Occupant",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: [const DashboardPage().notificationIcon(context)],
        appBarHeight: 50,
      ),
      body: BlocBuilder<OccupantCubit, OccupantState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          if (state.occupantModel?.occupant == null) {
            return const CreditNotesPage().emptyList(
                ontap: () =>
                    context.read<OccupantCubit>().getOccupant(context, unitId));
          }
          List<Map<String, dynamic>> occupantData = [
            {
              "icon": Icon(
                Icons.merge_type_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Type",
              "value": state.occupantModel?.occupant?.details?.type,
            },
            {
              "icon": Icon(
                Icons.email_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Email",
              "value": state.occupantModel?.occupant?.details?.primaryEmail,
            },
            {
              "icon": Icon(
                Icons.phone_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Primary Phone",
              "value": state.occupantModel?.occupant?.details?.primaryPhone,
            },
            {
              "icon": Icon(
                Icons.card_membership_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Passport No.",
              "value": state.occupantModel?.occupant?.details?.passportNumber,
            },
            {
              "icon": Icon(
                Icons.calendar_month_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Passport Expiry",
              "value": dateTimeFormatter(
                  state.occupantModel?.occupant?.details?.passportExpiry),
            },
            {
              "icon": Icon(
                Icons.numbers_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Emirates ID No.",
              "value": state.occupantModel?.occupant?.details?.emiratesIdNumber,
            },
            {
              "icon": Icon(
                Icons.calendar_month_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Emirates ID Expiry",
              "value": dateTimeFormatter(
                  state.occupantModel?.occupant?.details?.emiratesIdExpiry),
            },
            {
              "icon": Icon(
                Icons.numbers_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "TRN",
              "value": state.occupantModel?.occupant?.details?.trnNumber,
            },
            {
              "icon": Icon(
                Icons.calendar_month_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Date of Birth",
              "value": state.occupantModel?.occupant?.details?.dob,
            },
            {
              "icon": Icon(
                Icons.calendar_month_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Tenancy Contract Expiry",
              "value": dateTimeFormatter(state
                  .occupantModel?.occupant?.details?.tenancyContractExpiry),
            },
            {
              "icon": Icon(
                Icons.title_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Title Deed No.",
              "value": state.occupantModel?.occupant?.details?.titleDeedNumber,
            },
            {
              "icon": Icon(
                Icons.location_city_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Country",
              "value": state.occupantModel?.occupant?.details?.country,
            },
            {
              "icon": Icon(
                Icons.web_stories_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "State",
              "value": state.occupantModel?.occupant?.details?.state,
            },
            {
              "icon": Icon(
                Icons.location_city_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "City",
              "value": state.occupantModel?.occupant?.details?.city,
            },
            {
              "icon": Icon(
                Icons.streetview_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              "key": "Address",
              "value": state.occupantModel?.occupant?.details?.fullAddress,
            },
          ];
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OccupantCubit>().getOccupant(context, unitId);
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
                    CustomText(
                      text: state.occupantModel?.occupant?.details?.name ??
                          " -- ",
                      fontWeight: FontWeight.bold,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      fontsize: 20,
                      textAlign: TextAlign.left,
                    ),
                    const Gap(5),
                    Divider(
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    const Gap(5),
                    Column(
                      children: occupantData
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
                    if (state.occupantModel?.occupant?.emergencyContactDetails
                                ?.alternativeEmergencyContactName !=
                            null ||
                        state.occupantModel?.occupant?.emergencyContactDetails
                                ?.emergencyContactName !=
                            null)
                      CustomText(
                        text: "Emergency Contact Details",
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontsize: 20,
                      ),
                    if (state.occupantModel?.occupant?.emergencyContactDetails
                                ?.alternativeEmergencyContactName !=
                            null ||
                        state.occupantModel?.occupant?.emergencyContactDetails
                                ?.emergencyContactName !=
                            null)
                      const SizedBox(
                        height: 10,
                      ),
                    if (state.occupantModel?.occupant?.emergencyContactDetails
                            ?.emergencyContactName !=
                        null)
                      emergencyContactCard(
                          context,
                          state.occupantModel?.occupant?.emergencyContactDetails
                                  ?.emergencyContactName ??
                              " -- ",
                          phoneNumber: state.occupantModel?.occupant
                              ?.emergencyContactDetails?.emergencyContactPhone),
                    if (state.occupantModel?.occupant?.emergencyContactDetails
                            ?.emergencyContactName !=
                        null)
                      const SizedBox(
                        height: 10,
                      ),
                    if (state.occupantModel?.occupant?.emergencyContactDetails
                            ?.alternativeEmergencyContactName !=
                        null)
                      emergencyContactCard(
                          context,
                          state.occupantModel?.occupant?.emergencyContactDetails
                                  ?.alternativeEmergencyContactName ??
                              " -- ",
                          phoneNumber: state
                              .occupantModel
                              ?.occupant
                              ?.emergencyContactDetails
                              ?.alternativeEmergencyContactPhone),
                    if (state.occupantModel?.occupant?.emergencyContactDetails
                            ?.alternativeEmergencyContactName !=
                        null)
                      const SizedBox(
                        height: 10,
                      ),
                    if (state.occupantModel?.occupant?.vehicles != null &&
                        (state.occupantModel?.occupant?.vehicles?.isNotEmpty ??
                            false))
                      vehicleSection(
                          context, state.occupantModel?.occupant?.vehicles),
                    CustomText(
                      text: "Documents",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontsize: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const OwnersPage().documentInfo(context, "Passport",
                        url: state
                            .occupantModel?.occupant?.documents?.passportFile),
                    const OwnersPage().documentInfo(context, "Tenancy Contract",
                        url: state.occupantModel?.occupant?.documents
                            ?.tenancyContract),
                    const OwnersPage().documentInfo(context, "Title Deed",
                        url: state
                            .occupantModel?.occupant?.documents?.titleDeed),
                    const OwnersPage().documentInfo(context, "ID",
                        url: state.occupantModel?.occupant?.documents?.idFile),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget vehicleSection(BuildContext context, dynamic vechicles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Vehicles",
          color: context.read<AppThemeCubit>().state.primaryColor,
          fontWeight: FontWeight.bold,
          fontsize: 20,
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
                fontsize: 13,
              ),
              CustomText(
                text: registration,
                color: kBlack,
                fontsize: 13,
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
                fontsize: 13,
              ),
              CustomText(
                text: date,
                color: kBlack,
                fontsize: 13,
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: const Offset(1, 1),
              color: kGrey.shade300,
              spreadRadius: 2,
              blurRadius: 2),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const UnitsPage().roundedContainer(
                  context,
                  Icon(
                    Icons.person,
                    color: context.read<AppThemeCubit>().state.primaryColor,
                    size: 25,
                  ),
                  padding: const EdgeInsets.all(20),
                  invert: true),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: const UnitsPage().roundedContainer(
                    context, CustomText(text: name),
                    padding: const EdgeInsets.all(5),
                    color: kGrey.shade200,
                    alignment: Alignment.centerLeft),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const UnitsPage().contactsRow(context, [
            {
              "icon": Icons.phone_outlined,
              "name": "Call",
              "onTap": () {
                if (phoneNumber != null) {
                  launchUrl(Uri.parse("tel:$phoneNumber"));
                }
              }
            },
            {
              "icon": Icons.sms_outlined,
              "name": "SMS",
              "onTap": () {
                if (phoneNumber != null) {
                  launchUrl(Uri.parse("sms:$phoneNumber"));
                }
              }
            },
            {
              "icon": Icons.phone_outlined,
              "name": "WhatsApp",
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
          ])
        ],
      ),
    );
  }

  String dateTimeFormatter(DateTime? date) {
    if (date != null) {
      return DateFormat.yMd().format(date);
    }
    return " -- ";
  }
}
