import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Views/Requests/details/ad_details.dart';

import '../../../Utils/utils.dart';

class MoDetailsPage extends StatelessWidget {
  const MoDetailsPage({super.key});

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
                  if (state.moDetailsModel?.record == null) {
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
                            state.moDetailsModel?.record?.unit?.unitNumber ??
                                " -- ",
                            state.moDetailsModel?.record?.association?.name ??
                                " -- ",
                            state.moDetailsModel?.record?.createdAt,
                            state.moDetailsModel?.record?.status,
                            [
                              {
                                  "icon": Icons.link,
                                  "title": "Reference",
                                  "subTitle": reference ?? " -- ",
                                },{
                                "icon": Icons.email_outlined,
                                "title": "Requester Type",
                                "subTitle":
                                    state.moDetailsModel?.record?.clientType ??
                                        " -- ",
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Requested Date",
                                "subTitle": const OccupantPage()
                                    .dateTimeFormatter(state.moDetailsModel
                                        ?.record?.application?.moveDate),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Emergency Number",
                                "subTitle": (state.moDetailsModel?.record
                                            ?.application?.emergencyNumber ??
                                        " -- ")
                                    .toString(),
                              },
                              {
                                "icon": Icons.calendar_month_outlined,
                                "title": "Requested Time",
                                "subTitle":
                                    "${state.moDetailsModel?.record?.application?.moveTimeFrom ?? ""} - ${state.moDetailsModel?.record?.application?.moveTimeTo ?? ""}",
                              },
                              {
                                "icon": Icons.attach_money_outlined,
                                "title": "Security Deposit",
                                "subTitle":
                                    "${state.moDetailsModel?.record?.application?.securityDeposit ?? " -- "}",
                              },
                              {
                                "icon": Icons.attach_money_outlined,
                                "title": "Refund Amount",
                                "subTitle":
                                    "${state.moDetailsModel?.record?.application?.refundAmount ?? " -- "}",
                              },
                            ],
                          ),
                          const AdDetailsPage().applicationDetails(
                            context,
                            state.moDetailsModel?.record?.clientName,
                            state.moDetailsModel?.record?.clientPhone,enableContacts: false,
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
