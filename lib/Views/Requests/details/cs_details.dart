import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class CsDetailsPage extends StatelessWidget {
  const CsDetailsPage({super.key});

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
                  if (state.csDetailsModel?.record == null) {
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
                            state.csDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.csDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.csDetailsModel?.record?.createdAt,
                            state.csDetailsModel?.record?.status,
                            [
                              {
                                "icon": Icons.email_outlined,
                                "title": "Requester Type",
                                "subTitle":
                                    state.csDetailsModel?.record?.clientType ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.room_service_outlined,
                                "title": "Service",
                                "subTitle": state.csDetailsModel?.record
                                        ?.application?.service ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.security,
                                "title": "Description",
                                "subTitle":
                                    state.csDetailsModel?.record?.description ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.csDetailsModel
                                        ?.record?.application?.date),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "time",
                                "subTitle": state.csDetailsModel?.record
                                        ?.application?.time ??
                                    " -- ",
                              },
                            ],
                          ),
                          const AdDetailsPage().applicationDetails(
                            context,
                            state.csDetailsModel?.record?.clientName,
                            state.csDetailsModel?.record?.clientPhone,
                          ),
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
