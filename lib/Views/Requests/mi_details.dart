import 'package:iskaanowner/Views/Requests/ad_details.dart';

import '../../Utils/utils.dart';

class MiDetailsPage extends StatelessWidget {
  const MiDetailsPage({super.key});

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
                    state.miDetailsModel?.record?.unit?.unitNumber ?? " -- ",
                    state.miDetailsModel?.record?.association?.name ?? " -- ",
                    state.miDetailsModel?.record?.createdAt,
                    state.miDetailsModel?.record?.status,
                    [
                      {
                        "icon": Icons.email_outlined,
                        "title": "Requester Type",
                        "subTitle":
                            state.miDetailsModel?.record?.clientType ?? " -- ",
                      },
                      {
                        "icon": Icons.numbers_outlined,
                        "title": "Emergency Number",
                        "subTitle": state.miDetailsModel?.record?.application
                                ?.emergencyNumber ??
                            " -- ",
                      },
                      {
                        "icon": Icons.calendar_month_outlined,
                        "title": "Requested Date",
                        "subTitle": const OccupantPage().dateTimeFormatter(state
                            .miDetailsModel?.record?.application?.moveDate),
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
                        "subTitle": "ask hammad",
                      },
                      {
                        "icon": Icons.attach_money_outlined,
                        "title": "Resident Information Status",
                        "subTitle": "ask hammad",
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
                      state.miDetailsModel?.record?.clientEmail),
                  const AdDetailsPage().supportingDocuments(context, [
                    {
                      "name": "Emirates ID Or Passport/Visa (Ask Hammad)",
                      "url":
                          "$baseUrl/${state.miDetailsModel?.record?.titleDeed}",
                    },
                    {
                      "name": "Title Deed",
                      "url":
                          "$baseUrl/${state.miDetailsModel?.record?.titleDeed}",
                    },
                    {
                      "name": "Tenancy Contact (ask hammad)",
                      "url":
                          "$baseUrl/${state.miDetailsModel?.record?.clientIdFile}",
                    },
                    {
                      "name": "Trade License (ask hammad)",
                      "url":
                          "$baseUrl/${state.miDetailsModel?.record?.passportFile}",
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
