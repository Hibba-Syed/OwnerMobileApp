import 'package:flutter_animate/flutter_animate.dart';
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
    String? type = arguments['type'];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                text: "Unit $unitNumber - Occupant",
              ),
            ),
            Expanded(
              child: BlocBuilder<OccupantCubit, OccupantState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }

                  if (type?.toLowerCase() == "ss") {
                    List<Map<String, dynamic>> occupantData = [
                      {
                        "icon": Icons.link,
                        "key": "Reference",
                        "value":
                            state.shortStayOccupantModel?.record?.reference,
                      },
                      {
                        "icon": Icons.person,
                        "key": "Requester Type",
                        "value":
                            state.shortStayOccupantModel?.record?.clientType,
                      },
                      {
                        "icon": Icons.person_outline,
                        "key": "Name",
                        "value": state.shortStayOccupantModel?.record?.fullName,
                      },
                      {
                        "icon": Icons.email_outlined,
                        "key": "Reference",
                        "value": state.shortStayOccupantModel?.record?.email,
                      },
                      {
                        "icon": Icons.phone_outlined,
                        "key": "Requester Phone",
                        "value":
                            state.shortStayOccupantModel?.record?.clientPhone,
                      },
                      {
                        "icon": Icons.timer_outlined,
                        "key": "Short Stay Period",
                        "value":
                            "${dateTimeFormatter(state.shortStayOccupantModel?.record?.shortStayApplication?.startDate)} - ${dateTimeFormatter(state.shortStayOccupantModel?.record?.shortStayApplication?.endDate)}",
                      },
                    ];
                    if (state.shortStayOccupantModel?.record == null) {
                      return const CreditNotesPage().emptyList(
                          ontap: () => context
                              .read<OccupantCubit>()
                              .getShortStayOccupant(context, unitId));
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<OccupantCubit>()
                            .getShortStayOccupant(context, unitId);
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                              const OwnersPage().documentInfo(
                                  context, "Title Deed",
                                  url: state.shortStayOccupantModel?.record
                                          ?.titleDeedUrl ??
                                      ""),
                              const SizedBox(
                                height: 10,
                              ),
                              if ((state
                                          .shortStayOccupantModel
                                          ?.record
                                          ?.shortStayApplication
                                          ?.guests
                                          ?.length ??
                                      0) !=
                                  0)
                                CustomText(
                                  text: "Guests",
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              if ((state
                                          .shortStayOccupantModel
                                          ?.record
                                          ?.shortStayApplication
                                          ?.guests
                                          ?.length ??
                                      0) !=
                                  0)
                                const Gap(10),
                              if ((state
                                          .shortStayOccupantModel
                                          ?.record
                                          ?.shortStayApplication
                                          ?.guests
                                          ?.length ??
                                      0) !=
                                  0)
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state
                                          .shortStayOccupantModel
                                          ?.record
                                          ?.shortStayApplication
                                          ?.guests
                                          ?.length ??
                                      0,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final e = state
                                        .shortStayOccupantModel
                                        ?.record
                                        ?.shortStayApplication
                                        ?.guests?[index];
                                    return shortStayGuestInfo(
                                      context,
                                      e?.name ?? "",
                                      e?.phone ?? "",
                                      url: e?.fileUrl,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ).animate().fade(duration: 600.ms),
                      ),
                    );
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
                      "key": "Name",
                      "value": state.occupantModel?.occupant?.details?.name,
                    },
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
                                    ?.emergencyContactPhone,
                              ),
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
                                    ?.alternativeEmergencyContactPhone,
                              ),
                            if (state
                                    .occupantModel
                                    ?.occupant
                                    ?.emergencyContactDetails
                                    ?.alternativeEmergencyContactName !=
                                null)
                              const SizedBox(
                                height: 10,
                              ),

                            // vehicle section removed by fiza

                            // if (state.occupantModel?.occupant?.vehicles !=
                            //         null &&
                            //     (state.occupantModel?.occupant?.vehicles
                            //             ?.isNotEmpty ??
                            //         false))
                            //   vehicleSection(context,
                            //       state.occupantModel?.occupant?.vehicles),

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
                              return ListView.separated(
                                itemCount: state.occupantModel?.occupant
                                        ?.documents?.length ??
                                    0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                                      context,
                                      state.occupantModel?.occupant
                                              ?.documents?[index].name ??
                                          "",
                                      url: state.occupantModel?.occupant
                                              ?.documents?[index].url ??
                                          "");
                                },
                              );
                            }),
                          ],
                        ),
                      ).animate().fade(duration: 600.ms),
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
                      launchUrl(Uri.parse(
                          "https://wa.me/$phoneNumber/?text=${Uri.parse("hello!")}"));
                    }
                  }
                },
              ]
                  .map((e) => InkWell(
                        onTap: e["onTap"] as Function()?,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (phoneNumber == null
                                      ? kGrey
                                      : context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor)
                                  .withOpacity(0.1)),
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            e["icon"] as String,
                            color: phoneNumber == null
                                ? kGrey
                                : context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ],
    );
  }

  Widget shortStayGuestInfo(BuildContext context, String text, String phone,
      {String? url}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              text: "Name",
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: text,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              text: "Phone",
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: phone,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              text: "Passport / EID",
              fontWeight: FontWeight.bold,
            ),
            const OwnersPage().viewButton(context, url)
          ],
        ),
      ],
    );
  }

  String dateTimeFormatter(DateTime? date) {
    if (date != null) {
      return DateFormat("dd/MM/yyyy").format(date);
    }
    return " -- ";
  }
}
