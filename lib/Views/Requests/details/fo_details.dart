import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class FoDetailsPage extends StatelessWidget {
  const FoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? requestId =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as int?;
    String? reference =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String?;
    String? type =
        (ModalRoute.of(context)?.settings.arguments as List)[2] as String?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(context,
                  text: const AdDetailsPage().getRequestName(type)),
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
                                  "icon": Icons.link,
                                  "title": "Reference",
                                  "subTitle": reference ?? " -- ",
                                },
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
                                  "subTitle": state.foDetailsModel?.record
                                      ?.application?.contractorName,
                                },
                                {
                                  "icon": Icons.phone_android_outlined,
                                  "title": "Contractor Contact Person",
                                  "subTitle": state.foDetailsModel?.record
                                      ?.application?.contactPerson,
                                },
                                {
                                  "icon": Icons.phone_android_outlined,
                                  "title": "Contractor Phone",
                                  "subTitle": state.foDetailsModel?.record
                                      ?.application?.contractorPhone,
                                },
                                {
                                  "icon": Icons.group_outlined,
                                  "title": "No. of Staff Expected",
                                  "subTitle": (state
                                              .foDetailsModel
                                              ?.record
                                              ?.application
                                              ?.noOfStaffExpected ??
                                          " -- ")
                                      .toString(),
                                },
                                {
                                  "icon": Icons.calendar_month_outlined,
                                  "title": "Start date",
                                  "subTitle": const OccupantPage()
                                      .dateTimeFormatter(state.foDetailsModel
                                          ?.record?.application?.startDate),
                                },
                                {
                                  "icon": Icons.calendar_month_outlined,
                                  "title": "End date",
                                  "subTitle": const OccupantPage()
                                      .dateTimeFormatter(state.foDetailsModel
                                          ?.record?.application?.endDate),
                                },
                                {
                                  "icon": Icons.fast_forward_outlined,
                                  "title": "Temporary Electricity Required?",
                                  "subTitle": state.foDetailsModel?.record
                                              ?.application?.isElectricity ==
                                          1
                                      ? "Yes"
                                      : "No",
                                },
                                {
                                  "icon":
                                      Icons.indeterminate_check_box_outlined,
                                  "title": "NOC (fit out) Fee",
                                  "subTitle": (state.foDetailsModel?.record
                                              ?.application?.fitoutFee ??
                                          " -- ")
                                      .toString(),
                                },
                                {
                                  "icon": Icons.security,
                                  "title": "Security Deposit",
                                  "subTitle":
                                      "${state.foDetailsModel?.record?.application?.securityDeposit ?? " -- "}",
                                },
                                {
                                  "icon": Icons.security,
                                  "title": "Security Deposit Status",
                                  "subTitle": state
                                          .foDetailsModel
                                          ?.record
                                          ?.application
                                          ?.securityDepositStatusLbl ??
                                      " -- ",
                                },
                                {
                                  "icon":
                                      Icons.check_box_outline_blank_outlined,
                                  "title": "Total Payable Fee",
                                  "subTitle": state.foDetailsModel?.record
                                          ?.application?.totalPayableFee ??
                                      " -- ",
                                },
                                {
                                  "icon":
                                      Icons.check_box_outline_blank_outlined,
                                  "title": "Total Payable Fee Status",
                                  "subTitle": state.foDetailsModel?.record
                                          ?.application?.feePaymentStatusLbl ??
                                      " -- ",
                                },
                                {
                                  "icon": Icons.notes_outlined,
                                  "title": "Description",
                                  "subTitle": state.foDetailsModel?.record
                                          ?.description ??
                                      " -- ",
                                },
                              ]),
                          const AdDetailsPage().customTableView(
                              context,
                              ["Service Name", "Amount"],
                              state.foDetailsModel?.record?.application?.addons
                                      ?.map((e) => [
                                            e.serviceName ?? " -- ",
                                            formatCurrency(e.servicePrice ?? 0)
                                          ])
                                      .toList() ??
                                  [],
                              title: "Add Ons"),
                          if ((state.foDetailsModel?.record?.application
                                      ?.isDewaNocApplied ??
                                  0) ==
                              1)
                            const AdDetailsPage().customTableView(
                                context,
                                [
                                  "Dewa NOC Requested",
                                  "Dewa NOC Fee",
                                  "Payment Status"
                                ],
                                [
                                  [
                                    "Yes",
                                    formatCurrency(state.foDetailsModel?.record
                                        ?.application?.dewaNocFee),
                                    state.foDetailsModel?.record?.application
                                            ?.dewaNocPaymentStatus ??
                                        "pending",
                                  ]
                                ],
                                title: "DEWA NOC Details"),
                          if ((state.foDetailsModel?.record?.application
                                      ?.isFinalNocApplied ??
                                  0) ==
                              1)
                            const AdDetailsPage().customTableView(
                                context,
                                [
                                  "Dewa NOC Requested",
                                  "Dewa NOC Fee",
                                  "Payment Status"
                                ],
                                [
                                  [
                                    "Yes",
                                    formatCurrency(state.foDetailsModel?.record
                                        ?.application?.finalNocFee),
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
                            enableContacts: false,
                          ),
                        ].animate(interval: 50.ms).fade(),
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
