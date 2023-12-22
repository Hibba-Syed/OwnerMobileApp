import 'package:iskaanowner/Views/Requests/ad_details.dart';

import '../../Utils/utils.dart';

class HbDetailsPage extends StatelessWidget {
  const HbDetailsPage({super.key});

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
                    state.hbDetailsModel?.record?.unit?.unitNumber ?? " -- ",
                    state.hbDetailsModel?.record?.association?.name ?? " -- ",
                    state.hbDetailsModel?.record?.createdAt,
                    state.hbDetailsModel?.record?.status,
                    [
                      {
                        "icon": Icons.email_outlined,
                        "title": "Requester Type",
                        "subTitle":
                            state.hbDetailsModel?.record?.clientType ?? " -- ",
                      },
                      {
                        "icon": Icons.build_circle_outlined,
                        "title": "Facility",
                        "subTitle": state.hbDetailsModel?.record?.application
                                ?.facility ??
                            " -- ",
                      },
                      {
                        "icon": Icons.door_back_door_outlined,
                        "title": "Nature of Function",
                        "subTitle": state.hbDetailsModel?.record?.application
                                ?.natureOfFunction ??
                            " -- ",
                      },
                      {
                        "icon": Icons.group_outlined,
                        "title": "Expected Guests",
                        "subTitle": (state.hbDetailsModel?.record?.application
                                    ?.expectedGuests ??
                                " -- ")
                            .toString(),
                      },
                      {
                        "icon": Icons.book_online,
                        "title": "Booking Date",
                        "subTitle": const OccupantPage().dateTimeFormatter(state
                            .hbDetailsModel?.record?.application?.bookingDate),
                      },
                      {
                        "icon": Icons.timer_outlined,
                        "title": "Start Time",
                        "subTitle": state.hbDetailsModel?.record?.application
                                ?.startTime ??
                            " -- ",
                      },
                      {
                        "icon": Icons.timer_outlined,
                        "title": "End Date",
                        "subTitle": state
                                .hbDetailsModel?.record?.application?.endTime ??
                            " -- ",
                      },
                      {
                        "icon": Icons.attach_money_outlined,
                        "title": "Payable Amount",
                        "subTitle":
                            (state.hbDetailsModel?.record?.payableAmount ??
                                    " -- ")
                                .toString(),
                      },
                      {
                        "icon": Icons.attach_money_outlined,
                        "title": "Security Deposit",
                        "subTitle":
                            (state.hbDetailsModel?.record?.securityDeposit ??
                                    " -- ")
                                .toString(),
                      },
                    ],
                  ),
                  const AdDetailsPage().applicationDetails(
                      context,
                      state.hbDetailsModel?.record?.clientName,
                      state.hbDetailsModel?.record?.clientPhone,
                      state.hbDetailsModel?.record?.clientEmail),
                  const AdDetailsPage().supportingDocuments(context, [
                    {
                      "name": "Title Deed",
                      "url":
                          "$baseUrl/${state.hbDetailsModel?.record?.titleDeed}",
                    },
                    {
                      "name": "ID File",
                      "url":
                          "$baseUrl/${state.hbDetailsModel?.record?.clientIdFile}",
                    },
                    {
                      "name": "Passport File",
                      "url":
                          "$baseUrl/${state.hbDetailsModel?.record?.passportFile}",
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
