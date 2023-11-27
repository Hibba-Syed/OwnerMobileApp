import 'dart:io';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class OccupantPage extends StatelessWidget {
  const OccupantPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Occupant",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: const [],
        appBarHeight: 50,
      ),
      body: BlocBuilder<OccupantCubit, OccupantState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          if (state.occupantModel?.occupant == null) {
            return const CreditNotesPage().emptyList();
          }
          List<Map<String, String?>> occupantData = [
            {
              "key": "Type",
              "value": state.occupantModel?.occupant?.details?.name,
            },
            {
              "key": "Primary Email",
              "value": state.occupantModel?.occupant?.details?.primaryEmail,
            },
            {
              "key": "Secondary Email",
              "value": state.occupantModel?.occupant?.details?.primaryEmail,
            },
            {
              "key": "Primary Phone",
              "value": state.occupantModel?.occupant?.details?.primaryPhone,
            },
            {
              "key": "Passport No.",
              "value": state.occupantModel?.occupant?.details?.passportNumber,
            },
            {
              "key": "Passport Expiry",
              "value": dateTimeFormatter(
                  state.occupantModel?.occupant?.details?.passportExpiry),
            },
            {
              "key": "Emirates ID No.",
              "value": state.occupantModel?.occupant?.details?.emiratesIdNumber,
            },
            {
              "key": "Emirates ID Expiry",
              "value": dateTimeFormatter(
                  state.occupantModel?.occupant?.details?.emiratesIdExpiry),
            },
            {
              "key": "TRN",
              "value": state.occupantModel?.occupant?.details?.trnNumber,
            },
            {
              "key": "Date of Birth",
              "value": state.occupantModel?.occupant?.details?.dob,
            },
            {
              "key": "Tenancy Contract Expiry",
              "value": dateTimeFormatter(state
                  .occupantModel?.occupant?.details?.tenancyContractExpiry),
            },
            {
              "key": "Title Deed No.",
              "value": state.occupantModel?.occupant?.details?.titleDeedNumber,
            },
            {
              "key": "Country",
              "value": state.occupantModel?.occupant?.details?.country,
            },
            {
              "key": "State",
              "value": state.occupantModel?.occupant?.details?.state,
            },
            {
              "key": "City",
              "value": state.occupantModel?.occupant?.details?.city,
            },
            {
              "key": "Address",
              "value": state.occupantModel?.occupant?.details?.fullAddress,
            },
          ];
          return SingleChildScrollView(
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
                  Row(
                    children: [
                      CustomText(
                        text: "Occupant : ",
                        fontWeight: FontWeight.bold,
                        color: context.read<AppThemeCubit>().state.primaryColor,
                      ),
                      CustomText(
                        text: state.occupantModel?.occupant?.details?.name ??
                            "Not provided",
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Table(
                    border: TableBorder.all(
                        color:
                            context.read<AppThemeCubit>().state.primaryColor),
                    columnWidths: const {
                      0: FixedColumnWidth(120),
                      1: FlexColumnWidth(1),
                    },
                    children: occupantData
                        .map(
                          (e) => const OwnersPage().tableRow(
                            context,
                            e["key"] ?? "",
                            e["value"] ?? "not provided",
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "Emergency Contact Details",
                    color: context.read<AppThemeCubit>().state.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontsize: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  emergencyContactCard(
                      context,
                      state.occupantModel?.occupant?.emergencyContactDetails
                              ?.emergencyContactName ??
                          "not Provided"),
                  const SizedBox(
                    height: 10,
                  ),
                  emergencyContactCard(
                      context,
                      state.occupantModel?.occupant?.emergencyContactDetails
                              ?.alternativeEmergencyContactName ??
                          "not Provided"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "Documents",
                    color: context.read<AppThemeCubit>().state.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontsize: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state.occupantModel?.occupant?.vehicles != null)
                    vehicleSection(
                        context, state.occupantModel?.occupant?.vehicles),
                  const OwnersPage().documentInfo(context, "Passport",
                      url: state
                          .occupantModel?.occupant?.documents?.passportFile),
                  const OwnersPage().documentInfo(context, "Tenancy Contract",
                      url: state
                          .occupantModel?.occupant?.documents?.tenancyContract),
                  const OwnersPage().documentInfo(context, "Title Deed",
                      url: state.occupantModel?.occupant?.documents?.titleDeed),
                  const OwnersPage().documentInfo(context, "ID",
                      url: state.occupantModel?.occupant?.documents?.idFile),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget vehicleSection(BuildContext context, dynamic vechicles) {
    return Column(
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
              color: kGrey.shade200,
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
                const Icon(
                  Icons.person,
                  color: kWhite,
                  size: 25,
                ),
                padding: const EdgeInsets.all(20),
              ),
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
