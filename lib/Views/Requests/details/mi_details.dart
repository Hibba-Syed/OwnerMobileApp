import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class MiDetailsPage extends StatelessWidget {
  const MiDetailsPage({super.key});

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
                  text: const AdDetailsPage().getRequestName(type)),
            ),
            Expanded(
              child: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.miDetailsModel?.record == null) {
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
                            state.miDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.miDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.miDetailsModel?.record?.createdAt,
                            state.miDetailsModel?.record?.status,
                            [
                              {
                                "icon": Icons.email_outlined,
                                "title": "Requester Type",
                                "subTitle":
                                    state.miDetailsModel?.record?.clientType ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.numbers_outlined,
                                "title": "Emergency Number",
                                "subTitle": state.miDetailsModel?.record
                                        ?.application?.emergencyNumber ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Requested Date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.miDetailsModel
                                        ?.record?.application?.moveDate),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Requested Time",
                                "subTitle":
                                    "${state.miDetailsModel?.record?.application?.moveTimeFrom ?? ""} - ${state.miDetailsModel?.record?.application?.moveTimeTo ?? ""}",
                              },
                              {
                                "icon": Icons.attach_money_outlined,
                                "title": "Resident Information Reference",
                                "subTitle": state
                                        .miDetailsModel
                                        ?.record
                                        ?.application
                                        ?.residentInformation
                                        ?.reference ??
                                    "",
                              },
                              {
                                "icon": Icons.attach_money_outlined,
                                "title": "Resident Information Status",
                                "subTitle": state
                                        .miDetailsModel
                                        ?.record
                                        ?.application
                                        ?.residentInformation
                                        ?.status ??
                                    "",
                              },
                              {
                                "icon": Icons.attach_money_outlined,
                                "title": "Security Deposit",
                                "subTitle":
                                    "${state.miDetailsModel?.record?.application?.securityDeposit ?? " -- "}",
                              },
                              {
                                "icon": Icons.attach_money_outlined,
                                "title": "Refund Amount",
                                "subTitle":
                                    "${state.miDetailsModel?.record?.application?.refundAmount ?? " -- "}",
                              },
                            ],
                          ),
                          const AdDetailsPage().applicationDetails(
                            context,
                            state.miDetailsModel?.record?.clientName,
                            state.miDetailsModel?.record?.clientPhone,
                          ),
                          const AdDetailsPage().supportingDocuments(context, [
                            {
                              "name": "Emirates ID Or Passport/Visa",
                              "url":
                                  "${state.miDetailsModel?.record?.clientIdFileUrl}",
                            },
                            {
                              "name": "Title Deed",
                              "url":
                                  "${state.miDetailsModel?.record?.titleDeedUrl}",
                            },
                            {
                              "name": "Tenancy Contact",
                              "url":
                                  "${state.miDetailsModel?.record?.tenancyContractUrl}",
                            },
                            {
                              "name": "Trade License",
                              "url":
                                  "${state.miDetailsModel?.record?.tradeLicenseUrl}",
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
