import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Views/Requests/ad_details.dart';

import '../../Utils/utils.dart';

class SsDetailsPage extends StatelessWidget {
  const SsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // int? requestId =
    //     (ModalRoute.of(context)?.settings.arguments as List)[0] as int?;
    String? reference =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String?;
    String? type =
        (ModalRoute.of(context)?.settings.arguments as List)[2] as String?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "${const AdDetailsPage().getRequestName(type)}\n$reference",
        fontSize: 14,
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const AdDetailsPage().header(
                    context,
                        state.ssDetailsModel?.record?.unit?.unitNumber ?? " -- ",
                    state.ssDetailsModel?.record?.association?.name ?? " -- ",
                    state.ssDetailsModel?.record?.createdAt,
                    state.ssDetailsModel?.record?.status,
                    [
                      {
                        "icon": Icons.email_outlined,
                        "title": "Requester Type",
                        "subTitle":
                            state.ssDetailsModel?.record?.clientType ?? " -- ",
                      },
                      {
                        "icon": Icons.person_outlined,
                        "title": "No. of people",
                        "subTitle": (state.ssDetailsModel?.record?.application
                                    ?.numberOfPeople ??
                                0)
                            .toString(),
                      },
                      {
                        "icon": Icons.calendar_month_outlined,
                        "title": "Start Date",
                        "subTitle": const OccupantPage().dateTimeFormatter(state
                            .ssDetailsModel?.record?.application?.startDate),
                      },
                      {
                        "icon": Icons.calendar_today_outlined,
                        "title": "End Date",
                        "subTitle": const OccupantPage().dateTimeFormatter(
                            state.ssDetailsModel?.record?.application?.endDate),
                      },
                      {
                        "icon": Icons.calendar_month_outlined,
                        "title": "Description",
                        "subTitle":
                            state.ssDetailsModel?.record?.description ?? " -- "
                      },
                    ],
                  ),
                  const AdDetailsPage().customTableView(
                      context,
                      ["Name", "Phone", "Passport/EID"],
                      [
                        [
                          state.ssDetailsModel?.record?.application
                                  ?.companyName ??
                              " -- ",
                          "ask hammad",
                          "ask hammad"
                        ]
                      ],
                      title: "Add Ons"),
                  const AdDetailsPage().applicationDetails(
                    context,
                    state.ssDetailsModel?.record?.clientName,
                    state.ssDetailsModel?.record?.clientPhone,
                    state.ssDetailsModel?.record?.clientEmail,
                    customWidget: Column(
                      children: [
                        Divider(
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const RowText(
                                text: "Tourism License",
                                text2: "View",
                              ),
                              RowText(
                                text: "Tourism License Expiry",
                                text2: const OccupantPage().dateTimeFormatter(
                                    state.ssDetailsModel?.record?.application
                                        ?.tourismLicenseExpiry),
                              ),
                              const Gap(10),
                              const RowText(
                                text: "Company All Risk Insurance",
                                text2: "View",
                              ),
                              RowText(
                                text: "Company All Risk Insurance Expiry",
                                text2: const OccupantPage().dateTimeFormatter(
                                    state.ssDetailsModel?.record?.application
                                        ?.tourismLicenseExpiry),
                              ),
                              const Gap(10),
                              const RowText(
                                text: "Visa Copy",
                                text2: "View",
                              ),
                              RowText(
                                text: "Visa Copy Expiry",
                                text2: const OccupantPage().dateTimeFormatter(
                                    state.ssDetailsModel?.record?.application
                                        ?.visaCopyExpiry),
                              ),
                              const Gap(10),
                              const RowText(
                                text: "Rera ID",
                                text2: "View",
                              ),
                              RowText(
                                text: "Rera ID Expiry",
                                text2: const OccupantPage().dateTimeFormatter(
                                    state.ssDetailsModel?.record?.application
                                        ?.reraIdExpiry),
                              ),
                              const Gap(10),
                              const RowText(
                                text: "DTCM Permit",
                                text2: "View",
                              ),
                              RowText(
                                text: "DTCM Permit Expiry",
                                text2: const OccupantPage().dateTimeFormatter(
                                    state.ssDetailsModel?.record?.application
                                        ?.visaCopyExpiry),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const AdDetailsPage().supportingDocuments(context, [
                    {
                      "name": "Title Deed",
                      "url":
                          "$baseUrl/${state.ssDetailsModel?.record?.titleDeed}",
                    },
                    {
                      "name": "ID File",
                      "url":
                          "$baseUrl/${state.ssDetailsModel?.record?.clientIdFile}",
                    },
                    {
                      "name": "Passport File",
                      "url":
                          "$baseUrl/${state.ssDetailsModel?.record?.passportFile}",
                    },
                  ])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
