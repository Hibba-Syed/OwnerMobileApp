import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class DpDetailsPage extends StatelessWidget {
  const DpDetailsPage({super.key});

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
                  if (state.dpDetailsModel?.record == null) {
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
                            state.dpDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.dpDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.dpDetailsModel?.record?.createdAt,
                            state.dpDetailsModel?.record?.status,
                            [
                              {
                                  "icon": Icons.link,
                                  "title": "Reference",
                                  "subTitle": reference ?? " -- ",
                                },{
                                "icon": Icons.email_outlined,
                                "title": "Requester Type",
                                "subTitle":
                                    state.dpDetailsModel?.record?.clientType ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.calendar_today_outlined,
                                "title": " Requester Date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.dpDetailsModel
                                        ?.record?.application?.datetime),
                              },
                              {
                                "icon": Icons.money_outlined,
                                "title": "Delivery Company",
                                "subTitle": state.dpDetailsModel?.record
                                        ?.application?.deliveryCompany ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.notes_outlined,
                                "title": "Description",
                                "subTitle":
                                    state.dpDetailsModel?.record?.description ??
                                        " -- ",
                              },
                            ],
                          ),
                          const AdDetailsPage().applicationDetails(
                            context,
                            state.dpDetailsModel?.record?.clientName,
                            state.dpDetailsModel?.record?.clientPhone,
                          ),
                          const AdDetailsPage().supportingDocuments(context, [
                            {
                              "name": "ID File",
                              "url":
                                  state.dpDetailsModel?.record?.clientIdFileUrl,
                            },
                            {
                              "name": "Passport File",
                              "url":
                                  state.dpDetailsModel?.record?.passportFileUrl,
                            },
                            {
                              "name": "Tenancy Contract",
                              "url": state
                                  .dpDetailsModel?.record?.tenancyContractUrl,
                            },
                          ])
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
