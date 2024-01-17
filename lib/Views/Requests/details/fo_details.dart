import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class FoDetailsPage extends StatelessWidget {
  const FoDetailsPage({super.key});

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
                  if (state.foDetailsModel?.record == null) {
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
                              state.foDetailsModel?.record?.unit?.unitNumber ??
                                  " -- ",
                              state.foDetailsModel?.record?.association?.name ??
                                  " -- ",
                              state.foDetailsModel?.record?.createdAt,
                              state.foDetailsModel?.record?.status,
                              [
                                {
                                  "icon": Icons.email_outlined,
                                  "title": "Requester Type",
                                  "subTitle": state
                                          .foDetailsModel?.record?.clientType ??
                                      " -- ",
                                },
                                {
                                  "icon": Icons.person_outlined,
                                  "title": "Contractor Name",
                                  "subTitle":
                                      state.foDetailsModel?.record?.clientName,
                                },
                                {
                                  "icon": Icons.phone_android_outlined,
                                  "title": "Contractor Contact Person",
                                  "subTitle":
                                      state.foDetailsModel?.record?.clientName,
                                },
                                {
                                  "icon": Icons.group_outlined,
                                  "title": "No. of Staff Expected",
                                  "subTitle":
                                      state.foDetailsModel?.record?.clientName,
                                },
                                {
                                  "icon": Icons.calendar_month_outlined,
                                  "title": "Start date",
                                  "subTitle":
                                      state.foDetailsModel?.record?.clientName,
                                  "widget": const ProfilePage().profileInfoTile(
                                    context,
                                    "End Date",
                                    "23 May 20223",
                                  )
                                },
                                {
                                  "icon": Icons.fast_forward_outlined,
                                  "title": "Temporary Electricity Required?",
                                  "subTitle": "No",
                                },
                                {
                                  "icon":
                                      Icons.indeterminate_check_box_outlined,
                                  "title": "NOC (fit out) Fee",
                                  "subTitle": " -- ",
                                },
                                {
                                  "icon": Icons.security,
                                  "title": "Security Deposit",
                                  "subTitle":
                                      "${state.foDetailsModel?.record?.securityDeposit ?? " -- "}",
                                  "widget": const ProfilePage().profileInfoTile(
                                    context,
                                    "Status",
                                    "pending",
                                  ),
                                },
                                {
                                  "icon":
                                      Icons.check_box_outline_blank_outlined,
                                  "title": "Total Payable Fee",
                                  "subTitle": state.foDetailsModel?.record
                                          ?.payableAmount ??
                                      " -- ",
                                  "widget": const ProfilePage().profileInfoTile(
                                    context,
                                    "Status",
                                    "pending",
                                  ),
                                },
                                {
                                  "icon": Icons.notes_outlined,
                                  "title": "Description",
                                  "subTitle": state.foDetailsModel?.record
                                          ?.description ??
                                      " -- ",
                                },
                              ]),
                          // const AdDetailsPage().customTableView(
                          //     context,
                          //     ["Service Name", "Amount"],
                          //     state.foDetailsModel?.record?.application?.addons
                          //             ?.map((e) => [
                          //                   e.serviceName ?? " -- ",
                          //                   "${e.servicePrice ?? 0}"
                          //                 ])
                          //             .toList() ??
                          //         [],
                          //     title: "Add Ons"),
                          const AdDetailsPage().customTableView(
                              context,
                              [
                                "Dewa NOC Requested",
                                "Dewa NOC Fee (AED)",
                                "Payment Status"
                              ],
                              [
                                [
                                  (state.foDetailsModel?.record?.application
                                                  ?.isDewaNocApplied ??
                                              0) ==
                                          0
                                      ? "No"
                                      : "Yes",
                                  "${state.foDetailsModel?.record?.application?.dewaNocFee ?? "0"}",
                                  state.foDetailsModel?.record?.application
                                          ?.dewaNocPaymentStatus ??
                                      "pending",
                                ]
                              ],
                              title: "DEWA NOC Details"),
                          const AdDetailsPage().customTableView(
                              context,
                              [
                                "Dewa NOC Requested",
                                "Dewa NOC Fee (AED)",
                                "Payment Status"
                              ],
                              [
                                [
                                  (state.foDetailsModel?.record?.application
                                                  ?.isFinalNocApplied ??
                                              0) ==
                                          0
                                      ? "No"
                                      : "Yes",
                                  "${state.foDetailsModel?.record?.application?.finalNocFee ?? "0"}",
                                  state.foDetailsModel?.record?.application
                                          ?.finalNocPaymentStatus ??
                                      "pending",
                                ]
                              ],
                              title: "Final NOC Details"),
                          const AdDetailsPage().applicationDetails(
                              context,
                              state.foDetailsModel?.record?.clientName,
                              state.foDetailsModel?.record?.clientPhone,
                              state.foDetailsModel?.record?.clientEmail),
                          const AdDetailsPage().supportingDocuments(context, [
                            {
                              "name": "Title Deed",
                              "url": state.foDetailsModel?.record?.titleDeedUrl,
                            },
                            {
                              "name": "ID File",
                              "url":
                                  state.foDetailsModel?.record?.clientIdFileUrl,
                            },
                            {
                              "name": "Passport File",
                              "url":
                                  state.foDetailsModel?.record?.passportFileUrl,
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
