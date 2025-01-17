import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class WpDetailsPage extends StatelessWidget {
  const WpDetailsPage({super.key});

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
                  if (state.wpDetailsModel?.record == null) {
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
                            state.wpDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.wpDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.wpDetailsModel?.record?.createdAt,
                            state.wpDetailsModel?.record?.status,
                            [
                              {
                                "icon": Icons.link,
                                "title": "Reference",
                                "subTitle": reference ?? " -- ",
                              },
                              {
                                "icon": Icons.email_outlined,
                                "title": "Requester Type",
                                "subTitle":
                                    state.wpDetailsModel?.record?.clientType ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.person_outlined,
                                "title": "Contractor Name",
                                "subTitle": state.wpDetailsModel?.record
                                    ?.application?.contractorName,
                              },
                              {
                                "icon": Icons.phone_android_outlined,
                                "title": "Contractor Contact Person",
                                "subTitle": state.wpDetailsModel?.record
                                    ?.application?.contactPerson,
                              },
                              {
                                "icon": Icons.phone_android_outlined,
                                "title": "Contractor Phone",
                                "subTitle": state.wpDetailsModel?.record
                                    ?.application?.contractorPhone,
                              },
                              {
                                "icon": Icons.group_outlined,
                                "title": "No. of Staff Expected",
                                "subTitle": (state.wpDetailsModel?.record
                                            ?.application?.noOfStaffExpected ??
                                        " -- ")
                                    .toString(),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Start date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.wpDetailsModel
                                        ?.record?.application?.startDate),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "End date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.wpDetailsModel
                                        ?.record?.application?.endDate),
                              },
                              {
                                "icon": Icons.check_box_outline_blank_outlined,
                                "title": "Payable Amount",
                                "subTitle": state.wpDetailsModel?.record
                                        ?.payableAmount ??
                                    " -- ",
                              },
                              {
                                "icon": Icons.security,
                                "title": "Security Deposit",
                                "subTitle":
                                    "${state.wpDetailsModel?.record?.securityDeposit ?? " -- "}",
                                "widget": const ProfilePage().profileInfoTile(
                                  context,
                                  "Status",
                                  "pending",
                                ),
                              },
                              {
                                "icon": Icons.notes_outlined,
                                "title": "Description",
                                "subTitle":
                                    state.wpDetailsModel?.record?.description ??
                                        " -- ",
                              },
                            ],
                          ),
                          const AdDetailsPage().applicationDetails(
                            context,
                            state.wpDetailsModel?.record?.clientName,
                            state.wpDetailsModel?.record?.clientPhone,
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
