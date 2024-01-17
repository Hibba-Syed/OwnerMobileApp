import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/utils.dart';

class SsDetailsPage extends StatelessWidget {
  const SsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? requestId =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as int?;
    // String? reference =
    //     (ModalRoute.of(context)?.settings.arguments as List)[1] as String?;
    String? type =
        (ModalRoute.of(context)?.settings.arguments as List)[2] as String?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(context,
                  text:
                      const AdDetailsPage().getRequestName(type)),
            ),
            Expanded(
              child: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.ssDetailsModel?.record == null) {
                    return const CreditNotesPage().emptyList(ontap: () {
                      context
                          .read<RequestDetailsCubit>()
                          .getRequestDetails(context, requestId, type);
                    });
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const AdDetailsPage().header(
                            context,
                            state.ssDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.ssDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.ssDetailsModel?.record?.createdAt,
                            state.ssDetailsModel?.record?.status,
                            [
                              {
                                "icon": Icons.email_outlined,
                                "title": "Requester Type",
                                "subTitle":
                                    state.ssDetailsModel?.record?.clientType ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.person_outlined,
                                "title": "No. of people",
                                "subTitle": (state.ssDetailsModel?.record
                                            ?.application?.numberOfPeople ??
                                        0)
                                    .toString(),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Start Date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.ssDetailsModel
                                        ?.record?.application?.startDate),
                              },
                              {
                                "icon": Icons.calendar_today_outlined,
                                "title": "End Date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.ssDetailsModel
                                        ?.record?.application?.endDate),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Description",
                                "subTitle":
                                    state.ssDetailsModel?.record?.description ??
                                        " -- "
                              },
                            ],
                          ),
                          const AdDetailsPage().customTableView(
                              context,
                              ["Name", "Phone", "Passport/EID"],
                              [
                                [
                                  state.ssDetailsModel?.record?.company?.name ??
                                      " -- ",
                                  state.ssDetailsModel?.record?.company
                                          ?.contactNumber ??
                                      " -- ",
                                  state.ssDetailsModel?.record?.company?.user
                                          ?.passportNumber ??
                                      " -- ",
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
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      RowText(
                                        text: "Tourism License",
                                        text2: "View",
                                        onTap: () {
                                          if (state
                                                  .ssDetailsModel
                                                  ?.record
                                                  ?.application
                                                  ?.tourismLicense ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "No licenses found to view");
                                            return;
                                          }
                                          launchUrl(Uri.parse(
                                              "https://s3.amazonaws.com/hoam-dev/${state.ssDetailsModel?.record?.application?.tourismLicense}"));
                                        },
                                      ),
                                      RowText(
                                        text: "Tourism License Expiry",
                                        text2: const OccupantPage()
                                            .dateTimeFormatter(state
                                                .ssDetailsModel
                                                ?.record
                                                ?.application
                                                ?.tourismLicenseExpiry),
                                      ),
                                      const Gap(10),
                                      RowText(
                                        text: "Company All Risk Insurance",
                                        text2: "View",
                                        onTap: () {
                                          if (state
                                                  .ssDetailsModel
                                                  ?.record
                                                  ?.application
                                                  ?.companyRiskInsurance ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "No Company All Risk Insurance found to view");
                                            return;
                                          }
                                          launchUrl(Uri.parse(
                                              "https://s3.amazonaws.com/hoam-dev/${state.ssDetailsModel?.record?.application?.companyRiskInsurance}"));
                                        },
                                      ),
                                      RowText(
                                        text:
                                            "Company All Risk Insurance Expiry",
                                        text2: const OccupantPage()
                                            .dateTimeFormatter(state
                                                .ssDetailsModel
                                                ?.record
                                                ?.application
                                                ?.tourismLicenseExpiry),
                                      ),
                                      const Gap(10),
                                      RowText(
                                        text: "Visa Copy",
                                        text2: "View",
                                        onTap: () {
                                          if (state.ssDetailsModel?.record
                                                  ?.application?.visaCopy ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "No Visa copy found to view");
                                            return;
                                          }
                                          launchUrl(Uri.parse(
                                              "https://s3.amazonaws.com/hoam-dev/${state.ssDetailsModel?.record?.application?.visaCopy}"));
                                        },
                                      ),
                                      RowText(
                                        text: "Visa Copy Expiry",
                                        text2: const OccupantPage()
                                            .dateTimeFormatter(state
                                                .ssDetailsModel
                                                ?.record
                                                ?.application
                                                ?.visaCopyExpiry),
                                      ),
                                      const Gap(10),
                                      RowText(
                                        text: "Rera ID",
                                        text2: "View",
                                        onTap: () {
                                          if (state.ssDetailsModel?.record
                                                  ?.application?.reraId ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "No Rera id found to view");
                                            return;
                                          }
                                          launchUrl(Uri.parse(
                                              "https://s3.amazonaws.com/hoam-dev/${state.ssDetailsModel?.record?.application?.reraId}"));
                                        },
                                      ),
                                      RowText(
                                        text: "Rera ID Expiry",
                                        text2: const OccupantPage()
                                            .dateTimeFormatter(state
                                                .ssDetailsModel
                                                ?.record
                                                ?.application
                                                ?.reraIdExpiry),
                                      ),
                                      const Gap(10),
                                      RowText(
                                        text: "DTCM Permit",
                                        text2: "View",
                                        onTap: () {
                                          if (state.ssDetailsModel?.record
                                                  ?.application?.dtcmPermit ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "No DTCM Permit found to view");
                                            return;
                                          }
                                          launchUrl(Uri.parse(
                                              "https://s3.amazonaws.com/hoam-dev/${state.ssDetailsModel?.record?.application?.dtcmPermit}"));
                                        },
                                      ),
                                      RowText(
                                        text: "DTCM Permit Expiry",
                                        text2: const OccupantPage()
                                            .dateTimeFormatter(state
                                                .ssDetailsModel
                                                ?.record
                                                ?.application
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
                                  "${state.ssDetailsModel?.record?.titleDeedUrl}",
                            },
                            {
                              "name": "ID File",
                              "url":
                                  "${state.ssDetailsModel?.record?.clientIdFileUrl}",
                            },
                            {
                              "name": "Passport File",
                              "url":
                                  "${state.ssDetailsModel?.record?.passportFileUrl}",
                            },
                          ])
                        ],
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
}
