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
          if (state.wpDetailsModel?.record != null) {
            return const CreditNotesPage().emptyList(ontap: () {
              context.read<RequestDetailsCubit>().getRequestDetails(
                  context, requestId, type);
            });
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const AdDetailsPage().header(
                    context,
                    state.wpDetailsModel?.record?.unit?.unitNumber ?? " -- ",
                    state.wpDetailsModel?.record?.association?.name ?? " -- ",
                    state.wpDetailsModel?.record?.createdAt,
                    state.wpDetailsModel?.record?.status,
                    [
                      {
                        "icon": Icons.email_outlined,
                        "title": "Requester Type",
                        "subTitle":
                            state.wpDetailsModel?.record?.clientType ?? " -- ",
                      },
                      {
                        "icon": Icons.person_outlined,
                        "title": "Contractor Name",
                        "subTitle": state.wpDetailsModel?.record?.clientName,
                      },
                      {
                        "icon": Icons.phone_android_outlined,
                        "title": "Contractor Contact Person",
                        "subTitle": state.wpDetailsModel?.record?.clientName,
                      },
                      {
                        "icon": Icons.group_outlined,
                        "title": "No. of Staff Expected",
                        "subTitle": state.wpDetailsModel?.record?.clientName,
                      },
                      {
                        "icon": Icons.calendar_month_outlined,
                        "title": "Start date",
                        "subTitle": const OccupantPage().dateTimeFormatter(state
                            .wpDetailsModel?.record?.application?.startDate),
                      },
                      {
                        "icon": Icons.calendar_month_outlined,
                        "title": "End date",
                        "subTitle": const OccupantPage().dateTimeFormatter(
                            state.wpDetailsModel?.record?.application?.endDate),
                      },
                      {
                        "icon": Icons.security,
                        "title": "Security Deposit",
                        "subTitle":
                            "${state.wpDetailsModel?.record?.securityDeposit ?? " -- "}",
                        "widget": const ProfilePage().profileInfoTile(context,
                            "Status", "pending", Icons.done_all_outlined),
                      },
                      {
                        "icon": Icons.check_box_outline_blank_outlined,
                        "title": "Payable Amount",
                        "subTitle":
                            state.wpDetailsModel?.record?.payableAmount ??
                                " -- ",
                        "widget": const ProfilePage().profileInfoTile(context,
                            "Status", "pending", Icons.done_all_outlined),
                      },
                      {
                        "icon": Icons.money_outlined,
                        "title": "Cheque details",
                        "subTitle":
                            state.wpDetailsModel?.record?.serviceChargeStatus ??
                                " -- ",
                      },
                      {
                        "icon": Icons.notes_outlined,
                        "title": "Description",
                        "subTitle":
                            state.wpDetailsModel?.record?.description ?? " -- ",
                      },
                    ],
                  ),
                  const AdDetailsPage().applicationDetails(
                      context,
                      state.wpDetailsModel?.record?.clientName,
                      state.wpDetailsModel?.record?.clientPhone,
                      state.wpDetailsModel?.record?.clientEmail),
                  const AdDetailsPage().supportingDocuments(context, [
                    {
                      "name": "Title Deed",
                      "url":
                          state.wpDetailsModel?.record?.titleDeedUrl,
                    },
                    {
                      "name": "ID File",
                      "url":
                          state.wpDetailsModel?.record?.clientIdFileUrl,
                    },
                    {
                      "name": "Passport File",
                      "url":
                          state.wpDetailsModel?.record?.passportFileUrl,
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
