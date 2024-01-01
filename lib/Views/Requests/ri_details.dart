import 'package:iskaanowner/Views/Requests/ad_details.dart';

import '../../Utils/utils.dart';

class RiDetailsPage extends StatelessWidget {
  const RiDetailsPage({super.key});

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
                    state.riDetailsModel?.record?.unit?.unitNumber ?? " -- ",
                    state.riDetailsModel?.record?.association?.name ?? " -- ",
                    state.riDetailsModel?.record?.createdAt,
                    state.riDetailsModel?.record?.status,
                    [
                      {
                        "icon": Icons.email_outlined,
                        "title": "Requester Type",
                        "subTitle":
                            state.riDetailsModel?.record?.clientType ?? " -- ",
                      },
                      {
                        "icon": Icons.person_outlined,
                        "title": "Name",
                        "subTitle":
                            state.riDetailsModel?.record?.clientName ?? " -- ",
                      },
                      {
                        "icon": Icons.phone_outlined,
                        "title": "Phone",
                        "subTitle":
                            state.riDetailsModel?.record?.clientPhone ?? " -- ",
                      },
                      {
                        "icon": Icons.email_outlined,
                        "title": "Email",
                        "subTitle":
                            state.riDetailsModel?.record?.clientEmail ?? " -- ",
                      },
                      {
                        "icon": Icons.card_travel_outlined,
                        "title": "Passport No.",
                        "subTitle":
                            state.riDetailsModel?.record?.passportNumber ??
                                " -- ",
                      },
                      {
                        "icon": Icons.person_3_outlined,
                        "title": "ID No.",
                        "subTitle":
                            state.riDetailsModel?.record?.clientIdNumber ??
                                " -- ",
                      },
                      {
                        "icon": Icons.email_outlined,
                        "title": "Email",
                        "subTitle":
                            state.riDetailsModel?.record?.clientEmail ?? " -- ",
                      },
                      {
                        "icon": Icons.request_page_outlined,
                        "title": "Move In Request Ref#",
                        "subTitle": state.riDetailsModel?.record?.moveInRequest
                                ?.application?.reference ??
                            " -- ",
                      },
                      {
                        "icon": Icons.question_answer_outlined,
                        "title": "Status",
                        "subTitle": state.riDetailsModel?.record?.moveInRequest
                                ?.application?.status ??
                            " -- ",
                      },
                      {
                        "icon": Icons.people_outlined,
                        "title": "Adults",
                        "subTitle":
                            state.riDetailsModel?.record?.status ?? " -- ",
                      },
                      {
                        "icon": Icons.child_care_outlined,
                        "title": "Children",
                        "subTitle":
                            state.riDetailsModel?.record?.status ?? " -- ",
                      },
                    ],
                  ),
                  const AdDetailsPage().customTableView(
                      context,
                      ["Vehicle Registration Number"],
                      state.riDetailsModel?.record?.application?.residentVehicle
                              ?.map((e) => [e.registrationNumber ?? " -- "])
                              .toList() ??
                          [],
                      title: "Vehicles"),
                  const AdDetailsPage().customTableView(
                      context,
                      ["Person Name", "Phone No."],
                      [
                        [
                          state.riDetailsModel?.record?.application
                                  ?.firstPersonName ??
                              " -- ",
                          state.riDetailsModel?.record?.application
                                  ?.firstPersonNumber ??
                              " -- "
                        ],
                        [
                          state.riDetailsModel?.record?.application
                                  ?.secondPersonName ??
                              " -- ",
                          state.riDetailsModel?.record?.application
                                  ?.secondPersonNumber ??
                              " -- "
                        ],
                      ],
                      title: "Emergency Contact Details"),
                  const AdDetailsPage().supportingDocuments(context, [
                    {
                      "name": "Tenancy Contract",
                      "url": state.riDetailsModel?.record?.tenancyContractUrl,
                    },
                    {
                      "name": "Title Deed",
                      "url": state.riDetailsModel?.record?.titleDeedUrl,
                    },
                    {
                      "name": "ID File",
                      "url": state.riDetailsModel?.record?.clientIdFileUrl,
                    },
                    {
                      "name": "Passport File",
                      "url": state.riDetailsModel?.record?.passportFileUrl,
                    },
                    {
                      "name": "Trade License",
                      "url": state.riDetailsModel?.record?.tradeLicenseUrl,
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
