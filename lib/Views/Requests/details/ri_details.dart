import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class RiDetailsPage extends StatelessWidget {
  const RiDetailsPage({super.key});

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
                  if (state.riDetailsModel?.record == null) {
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
                            state.riDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.riDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.riDetailsModel?.record?.createdAt,
                            state.riDetailsModel?.record?.status,
                            [
                              {
                                  "icon": Icons.link,
                                  "title": "Reference",
                                  "subTitle": reference ?? " -- ",
                                },{
                                "icon": Icons.email_outlined,
                                "title": "Requester Type",
                                "subTitle":
                                    state.riDetailsModel?.record?.clientType ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.person_outlined,
                                "title": "Name",
                                "subTitle":
                                    state.riDetailsModel?.record?.clientName ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.phone_outlined,
                                "title": "Phone",
                                "subTitle":
                                    state.riDetailsModel?.record?.clientPhone ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.email_outlined,
                                "title": "Email",
                                "subTitle":
                                    state.riDetailsModel?.record?.clientEmail ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.card_travel_outlined,
                                "title": "Passport No.",
                                "subTitle": state.riDetailsModel?.record
                                        ?.application?.ownerNumber ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.person_3_outlined,
                                "title": "Emirates ID No.",
                                "subTitle": state.riDetailsModel?.record
                                        ?.application?.emiratesIdNumber ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.request_page_outlined,
                                "title": "Move In Request Reference",
                                "subTitle": state
                                        .riDetailsModel
                                        ?.record
                                        ?.moveInRequest
                                        ?.application
                                        ?.reference ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.question_answer_outlined,
                                "title": "Move In Request Status",
                                "subTitle": state.riDetailsModel?.record
                                        ?.moveInRequest?.application?.status ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.people_outlined,
                                "title": "Adults",
                                "subTitle": (state.riDetailsModel?.record
                                            ?.application?.adult ??
                                        " -- ")
                                    .toString(),
                              },
                              {
                                "icon": Icons.child_care_outlined,
                                "title": "Children",
                                "subTitle": (state.riDetailsModel?.record
                                            ?.application?.child ??
                                        " -- ")
                                    .toString(),
                              },
                            ],
                          ),
                          if ((state.riDetailsModel?.record?.application
                                      ?.residentVehicle?.length ??
                                  0) !=
                              0)
                            const AdDetailsPage().customTableView(
                                context,
                                ["Vehicle Registration Number"],
                                state.riDetailsModel?.record?.application
                                        ?.residentVehicle
                                        ?.map((e) =>
                                            [e.registrationNumber ?? " -- "])
                                        .toList() ??
                                    [],
                                title: "Vehicles"),
                          const AdDetailsPage().headingText(
                            context,
                            "Emergency Contact Details",
                          ),
                          const AdDetailsPage().applicationDetails(
                              context,
                              state.riDetailsModel?.record?.application
                                      ?.firstPersonName ??
                                  " -- ",
                              state.riDetailsModel?.record?.application
                                      ?.firstPersonNumber ??
                                  " -- ",
                              enableHeader: false),
                          const AdDetailsPage().applicationDetails(
                              context,
                              state.riDetailsModel?.record?.application
                                      ?.secondPersonName ??
                                  " -- ",
                              state.riDetailsModel?.record?.application
                                      ?.secondPersonNumber ??
                                  " -- ",
                              enableHeader: false,),
                     
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
